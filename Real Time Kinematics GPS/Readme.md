# Real time kinematics GPS

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
1. GPS puck is stationary
2. GPS puck is moving

![image](https://github.com/aayush-sanghvi/robotics-sensing-and-navigation/assets/168468569/e3802b7e-62d2-4d24-a855-ad2fbb2f9902)

For the analysis part, data was then converted into UTM-Easting and UTM-Northing and plotted against time and each other. UTM-Easting vs UTM-Northing graph would display the path travelled and latitude and the longitude of the sensor. You can witness the difference between stationary data and moving data. In stationary data, we can see deflection as low as 0.75mm in UTM-Easting and 0.4mm in UTM-Northing. 
![walking_data](https://github.com/aayush-sanghvi/robotics-sensing-and-navigation/assets/168468569/a1f09f24-bc56-43c2-ba8b-5f850ec05959)


And the walking data shows performance of sensor within occluded space and non occluded space. The lower right line shows sensor data within occluded space and rest of the path shows sensor data in non-occluded space
![walking_data_eastingvnorthing_o](https://github.com/aayush-sanghvi/robotics-sensing-and-navigation/assets/168468569/6713d877-961f-4174-a559-4dd7a04243e1)



