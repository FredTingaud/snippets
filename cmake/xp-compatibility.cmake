## Ensure builds are compatible with Windows XP.
## It defines Macro versions to target Windows XP and ensures that Visual Studio >= 2012
## use the toolset supported by Windows XP.
 
add_definitions(-DWINVER=0x0501)
add_definitions(-D_WIN32_WINNT=0x0501)

if (MSVC11)
  # Visual Studio 2012
  set(CMAKE_GENERATOR_TOOLSET "v110_xp" CACHE STRING "Platform Toolset" FORCE)
elseif (MSVC12)
  # Visual Studio 2013
  set(CMAKE_GENERATOR_TOOLSET "v120_xp" CACHE STRING "Platform Toolset" FORCE)
elseif (MSVC14)
  # Visual Studio 2015
  set(CMAKE_GENERATOR_TOOLSET "v140_xp" CACHE STRING "Platform Toolset" FORCE)
endif (MSVC11)
