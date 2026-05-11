cmake_minimum_required(VERSION 3.10)

set(BINARY_NAME "minsk_transport")

add_executable(${BINARY_NAME}
  main.cc
  my_application.cc
)

target_link_libraries(${BINARY_NAME} PRIVATE
  ${FLUTTER_LIBRARY}
  ${GTK_LIBRARIES}
)

target_include_directories(${BINARY_NAME} PRIVATE
  ${FLUTTER_INCLUDE_DIR}
)

# Install
install(TARGETS ${BINARY_NAME} RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR})
install(FILES ${FLUTTER_LIBRARY} DESTINATION ${CMAKE_INSTALL_LIBDIR})
install(DIRECTORY ${FLUTTER_ASSETS_DIR} DESTINATION ${CMAKE_INSTALL_DATADIR}/${APPLICATION_ID})
