# Install script for directory: /home/aayush/catkin_ws/eece5554/LAB2/src/gpsrtk_driver

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "/home/aayush/catkin_ws/eece5554/LAB2/install")
endif()
string(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
if(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  if(BUILD_TYPE)
    string(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  else()
    set(CMAKE_INSTALL_CONFIG_NAME "")
  endif()
  message(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
endif()

# Set the component getting installed.
if(NOT CMAKE_INSTALL_COMPONENT)
  if(COMPONENT)
    message(STATUS "Install component: \"${COMPONENT}\"")
    set(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  else()
    set(CMAKE_INSTALL_COMPONENT)
  endif()
endif()

# Install shared libraries without execute permission?
if(NOT DEFINED CMAKE_INSTALL_SO_NO_EXE)
  set(CMAKE_INSTALL_SO_NO_EXE "1")
endif()

# Is this installation the result of a crosscompile?
if(NOT DEFINED CMAKE_CROSSCOMPILING)
  set(CMAKE_CROSSCOMPILING "FALSE")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/gpsrtk_driver/msg" TYPE FILE FILES "/home/aayush/catkin_ws/eece5554/LAB2/src/gpsrtk_driver/msg/NavSatMsg.msg")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/gpsrtk_driver/cmake" TYPE FILE FILES "/home/aayush/catkin_ws/eece5554/LAB2/build/gpsrtk_driver/catkin_generated/installspace/gpsrtk_driver-msg-paths.cmake")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include" TYPE DIRECTORY FILES "/home/aayush/catkin_ws/eece5554/LAB2/devel/include/gpsrtk_driver")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/roseus/ros" TYPE DIRECTORY FILES "/home/aayush/catkin_ws/eece5554/LAB2/devel/share/roseus/ros/gpsrtk_driver")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/common-lisp/ros" TYPE DIRECTORY FILES "/home/aayush/catkin_ws/eece5554/LAB2/devel/share/common-lisp/ros/gpsrtk_driver")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/gennodejs/ros" TYPE DIRECTORY FILES "/home/aayush/catkin_ws/eece5554/LAB2/devel/share/gennodejs/ros/gpsrtk_driver")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  execute_process(COMMAND "/usr/bin/python3" -m compileall "/home/aayush/catkin_ws/eece5554/LAB2/devel/lib/python3/dist-packages/gpsrtk_driver")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/python3/dist-packages" TYPE DIRECTORY FILES "/home/aayush/catkin_ws/eece5554/LAB2/devel/lib/python3/dist-packages/gpsrtk_driver")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/pkgconfig" TYPE FILE FILES "/home/aayush/catkin_ws/eece5554/LAB2/build/gpsrtk_driver/catkin_generated/installspace/gpsrtk_driver.pc")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/gpsrtk_driver/cmake" TYPE FILE FILES "/home/aayush/catkin_ws/eece5554/LAB2/build/gpsrtk_driver/catkin_generated/installspace/gpsrtk_driver-msg-extras.cmake")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/gpsrtk_driver/cmake" TYPE FILE FILES
    "/home/aayush/catkin_ws/eece5554/LAB2/build/gpsrtk_driver/catkin_generated/installspace/gpsrtk_driverConfig.cmake"
    "/home/aayush/catkin_ws/eece5554/LAB2/build/gpsrtk_driver/catkin_generated/installspace/gpsrtk_driverConfig-version.cmake"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/gpsrtk_driver" TYPE FILE FILES "/home/aayush/catkin_ws/eece5554/LAB2/src/gpsrtk_driver/package.xml")
endif()

