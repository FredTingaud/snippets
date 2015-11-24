## A script to redirect all targets in a given file, even for multi-configuration generators like Visual Studio
## This script was probably copied from this answer: http://stackoverflow.com/a/7750816/2027107
##
## Usage:
## ${CMAKE_INSTALL_PREFIX}/bin (2) - The output directory for RUNTIME target files.

set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_INSTALL_PREFIX}/bin)
foreach(OUTPUTCONFIG ${CMAKE_CONFIGURATION_TYPES})
    string(TOUPPER ${OUTPUTCONFIG} OUTPUTCONFIG)
    set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_${OUTPUTCONFIG} ${CMAKE_INSTALL_PREFIX}/bin)
endforeach(OUTPUTCONFIG CMAKE_CONFIGURATION_TYPES)
