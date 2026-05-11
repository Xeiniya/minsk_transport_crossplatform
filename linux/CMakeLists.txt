cmake_minimum_required(VERSION 3.10)
project(minsk_transport)

set(APPLICATION_ID "com.example.minsk_transport")

# Get flutter tool information
set(FLUTTER_EPHEMERAL_DIR "${CMAKE_CURRENT_SOURCE_DIR}/flutter/ephemeral")

# Add flutter subdirectory
add_subdirectory(flutter)

# Add runner
add_subdirectory(runner)
