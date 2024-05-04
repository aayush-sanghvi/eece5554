# GPS-Puck Data collection

To execute this code, download the src folder into your local repository and run
```
catkin_make
```
This will create two new folders. devel and build
```
source devel/setup.bash
```
To execute the code, execute the following command
```
roslaunch driver.launch port:=”/dev/tty****
```
*Replace **** with USB port number on which GPS puck is connected*

This project collects data from GNSS puck, decodes the message header format to accept data of "$GPGGA" format only.
![image](https://github.com/aayush-sanghvi/robotics-sensing-and-navigation/assets/168468569/fc3a4b9c-0a3f-4d6c-ab09-692da61136fc)

Data was then converted into UTM-Easting and UTM-Northing and plotted on a map. The plotted data on the map would display the path travelled and latitude longitude of the sensor.
![image](https://github.com/aayush-sanghvi/robotics-sensing-and-navigation/assets/168468569/2a6cba78-5061-44e1-995b-9e9542531702)
