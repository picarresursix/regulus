# Time-stamp: <>
# AUTHOR: Léo Perrin <leoperrin@picarresursix.fr>

CMAKE_MINIMUM_REQUIRED(VERSION 2.6)

# !TODO! Write the instructions for compilation.

# the complete project
PROJECT(<PROJECT_NAME>)
SET(BIN_NAME <BIN_NAME>)

# compiler options
ADD_DEFINITIONS(-Wall -pedantic -std=c++0x -g)

# the names of the libraries
SET(LIB_<LIB1>_NAME <LIB1>)

# building the libraries
ADD_SUBDIRECTORY(src/<LIB1>)

# building main executable
ADD_EXECUTABLE(${BIN_NAME} main.cpp)
TARGET_LINK_LIBRARIES(
  ${BIN_NAME}
  ${LIB_<LIB1>_NAME}
  )
  
