# GPS-Puck Data collection

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
roslaunch driver.launch port:=”/dev/tty****
```
*Replace **** with USB port number on which GPS puck is connected*

This project collects and records data from GNSS puck into a bag file, decodes the message header format to accept data of "$GPGGA" format only, assigns each data to a message variable, and finally publishes the message to gps node. 
Two sets of data are recorded,
1. GPS puck is stationary
2. GPS puck is moving

![image](https://github.com/aayush-sanghvi/robotics-sensing-and-navigation/assets/168468569/fc3a4b9c-0a3f-4d6c-ab09-692da61136fc)

For the analysis part, data was then converted into UTM-Easting and UTM-Northing and plotted against time and each other. UTM-Easting vs UTM-Northing graph would display the path travelled and latitude and the longitude of the sensor.
![image](https://github.com/aayush-sanghvi/robotics-sensing-and-navigation/assets/168468569/2a6cba78-5061-44e1-995b-9e9542531702)
