;; Auto-generated. Do not edit!


(when (boundp 'gps_driver::gps_msg)
  (if (not (find-package "GPS_DRIVER"))
    (make-package "GPS_DRIVER"))
  (shadow 'gps_msg (find-package "GPS_DRIVER")))
(unless (find-package "GPS_DRIVER::GPS_MSG")
  (make-package "GPS_DRIVER::GPS_MSG"))

(in-package "ROS")
;;//! \htmlinclude gps_msg.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass gps_driver::gps_msg
  :super ros::object
  :slots (_header _latitude _longitude _altitude _utm_easting _utm_northing _zone _letter ))

(defmethod gps_driver::gps_msg
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:latitude __latitude) 0.0)
    ((:longitude __longitude) 0.0)
    ((:altitude __altitude) 0.0)
    ((:utm_easting __utm_easting) 0.0)
    ((:utm_northing __utm_northing) 0.0)
    ((:zone __zone) 0.0)
    ((:letter __letter) "")
    )
   (send-super :init)
   (setq _header __header)
   (setq _latitude (float __latitude))
   (setq _longitude (float __longitude))
   (setq _altitude (float __altitude))
   (setq _utm_easting (float __utm_easting))
   (setq _utm_northing (float __utm_northing))
   (setq _zone (float __zone))
   (setq _letter (string __letter))
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:latitude
   (&optional __latitude)
   (if __latitude (setq _latitude __latitude)) _latitude)
  (:longitude
   (&optional __longitude)
   (if __longitude (setq _longitude __longitude)) _longitude)
  (:altitude
   (&optional __altitude)
   (if __altitude (setq _altitude __altitude)) _altitude)
  (:utm_easting
   (&optional __utm_easting)
   (if __utm_easting (setq _utm_easting __utm_easting)) _utm_easting)
  (:utm_northing
   (&optional __utm_northing)
   (if __utm_northing (setq _utm_northing __utm_northing)) _utm_northing)
  (:zone
   (&optional __zone)
   (if __zone (setq _zone __zone)) _zone)
  (:letter
   (&optional __letter)
   (if __letter (setq _letter __letter)) _letter)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; float32 _latitude
    4
    ;; float32 _longitude
    4
    ;; float32 _altitude
    4
    ;; float32 _utm_easting
    4
    ;; float32 _utm_northing
    4
    ;; float32 _zone
    4
    ;; string _letter
    4 (length _letter)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; float32 _latitude
       (sys::poke _latitude (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _longitude
       (sys::poke _longitude (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _altitude
       (sys::poke _altitude (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _utm_easting
       (sys::poke _utm_easting (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _utm_northing
       (sys::poke _utm_northing (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _zone
       (sys::poke _zone (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; string _letter
       (write-long (length _letter) s) (princ _letter s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; float32 _latitude
     (setq _latitude (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _longitude
     (setq _longitude (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _altitude
     (setq _altitude (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _utm_easting
     (setq _utm_easting (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _utm_northing
     (setq _utm_northing (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _zone
     (setq _zone (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; string _letter
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _letter (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;;
   self)
  )

(setf (get gps_driver::gps_msg :md5sum-) "c70e0f2dca96931bbc59f77e1290a073")
(setf (get gps_driver::gps_msg :datatype-) "gps_driver/gps_msg")
(setf (get gps_driver::gps_msg :definition-)
      "Header header
float32 latitude
float32 longitude
float32 altitude
float32 utm_easting
float32 utm_northing
float32 zone
string letter

================================================================================
MSG: std_msgs/Header
# Standard metadata for higher-level stamped data types.
# This is generally used to communicate timestamped data 
# in a particular coordinate frame.
# 
# sequence ID: consecutively increasing ID 
uint32 seq
#Two-integer timestamp that is expressed as:
# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')
# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')
# time-handling sugar is provided by the client library
time stamp
#Frame this data is associated with
string frame_id

")



(provide :gps_driver/gps_msg "c70e0f2dca96931bbc59f77e1290a073")


