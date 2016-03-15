## Typical CMake code used to pass gtest as a target in the test projects.
## It uses the ExternalProject CMake module, downloading the gtest sources and compiling them on-the-fly.
##

# Enable ExternalProject CMake module
include(ExternalProject)

# Create a variable with arguments for the external project, export dynamic libraries next to the other runtimes.
set(EXTERNAL_ARGS -DCMAKE_RUNTIME_OUTPUT_DIRECTORY=${CMAKE_RUNTIME_OUTPUT_DIRECTORY})
foreach(OUTPUTCONFIG ${CMAKE_CONFIGURATION_TYPES})
   string(TOUPPER ${OUTPUTCONFIG} OUTPUTCONFIG)
   set(EXTERNAL_ARGS ${EXTERNAL_ARGS} -DCMAKE_RUNTIME_OUTPUT_DIRECTORY_${OUTPUTCONFIG}=${CMAKE_RUNTIME_OUTPUT_DIRECTORY})
endforeach(OUTPUTCONFIG CMAKE_CONFIGURATION_TYPES)

# Download and install GoogleTest
ExternalProject_Add(
    gtest
    URL https://github.com/google/googletest/archive/release-1.7.0.zip
    PREFIX ${CMAKE_CURRENT_BINARY_DIR}/gtest
    CMAKE_ARGS -DBUILD_SHARED_LIBS=ON ${EXTERNAL_ARGS}
    # Disable install step
    INSTALL_COMMAND ""
)

# Create a libgtest target to be used as a dependency by test programs
add_library(libgtest IMPORTED SHARED GLOBAL)
add_dependencies(libgtest gtest)

# Export gtest properties
ExternalProject_Get_Property(gtest source_dir binary_dir)

# Set library location in libgtest
set_target_properties(libgtest PROPERTIES
    "IMPORTED_LOCATION" "${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/${CMAKE_IMPORT_LIBRARY_PREFIX}gtest${CMAKE_SHARED_LIBRARY_SUFFIX}"
    "IMPORTED_IMPLIB" "${binary_dir}/${CMAKE_CFG_INTDIR}/${CMAKE_IMPORT_LIBRARY_PREFIX}gtest${CMAKE_IMPORT_LIBRARY_SUFFIX}"
    "IMPORTED_LINK_INTERFACE_LIBRARIES" "${CMAKE_THREAD_LIBS_INIT}"
)

# Add the hearders
include_directories("${source_dir}/include")