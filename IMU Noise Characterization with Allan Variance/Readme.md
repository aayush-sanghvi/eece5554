# IMU Noise Characterization with Allan Variance

To execute this code, download the src folder into your local repository and run
```
catkin_make
```
This will create two new folders, devel and build
```
source devel/setup.bash
```
To execute the code, execute the following command
```
roslaunch gpsrtk_driver driver.launch port:=”/dev/tty****
```
*Replace **** with USB port number on which GPS puck is connected*

This project collects and records data from Real Time Kinematics puck into a bag file, decodes the message header format to accept data of "$GNGGA" format only, assigns each data to a message variable, and finally publishes the message to gps node. Two sets of data are recorded.
GPS puck is stationary
GPS puck is moving

![image](https://github.com/aayush-sanghvi/robotics-sensing-and-navigation/assets/168468569/e3802b7e-62d2-4d24-a855-ad2fbb2f9902)





