## Typical CMake code used in any of my Qt5 projects.
## Its main interest is its use of the very convenient windeployqt script coming with qt.
##
## Usage:
## MyTargetName(2) - The name of the executable target.

find_package(Qt5Widgets REQUIRED)

set(CMAKE_AUTOMOC ON)

if(WIN32)
  # Use classic main declaration and get rid of the console.
  set(QT_USE_QTMAIN TRUE)

  # Create a target called deploy-qt that automatically add all necessary qt files for distribution.
  get_target_property(QtCore_location Qt5::Core LOCATION)
  get_filename_component(QT_BIN ${QtCore_location} DIRECTORY)
  add_custom_target(deploy-qt set "PATH=%PATH%;${QT_BIN}"
                    COMMAND
                    ${QT_BIN}/windeployqt $<TARGET_FILE:MyTargetName>
                    )

endif(WIN32)

target_link_libraries(MyTargetName Qt5::Widgets)
