; Auto-generated. Do not edit!


(cl:in-package gpsrtk_driver-msg)


;//! \htmlinclude NavSatMsg.msg.html

(cl:defclass <NavSatMsg> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (latitude
    :reader latitude
    :initarg :latitude
    :type cl:float
    :initform 0.0)
   (longitude
    :reader longitude
    :initarg :longitude
    :type cl:float
    :initform 0.0)
   (altitude
    :reader altitude
    :initarg :altitude
    :type cl:float
    :initform 0.0)
   (indicator
    :reader indicator
    :initarg :indicator
    :type cl:float
    :initform 0.0)
   (utm_easting
    :reader utm_easting
    :initarg :utm_easting
    :type cl:float
    :initform 0.0)
   (utm_northing
    :reader utm_northing
    :initarg :utm_northing
    :type cl:float
    :initform 0.0)
   (zone
    :reader zone
    :initarg :zone
    :type cl:float
    :initform 0.0)
   (letter
    :reader letter
    :initarg :letter
    :type cl:string
    :initform ""))
)

(cl:defclass NavSatMsg (<NavSatMsg>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <NavSatMsg>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'NavSatMsg)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name gpsrtk_driver-msg:<NavSatMsg> is deprecated: use gpsrtk_driver-msg:NavSatMsg instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <NavSatMsg>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader gpsrtk_driver-msg:header-val is deprecated.  Use gpsrtk_driver-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'latitude-val :lambda-list '(m))
(cl:defmethod latitude-val ((m <NavSatMsg>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader gpsrtk_driver-msg:latitude-val is deprecated.  Use gpsrtk_driver-msg:latitude instead.")
  (latitude m))

(cl:ensure-generic-function 'longitude-val :lambda-list '(m))
(cl:defmethod longitude-val ((m <NavSatMsg>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader gpsrtk_driver-msg:longitude-val is deprecated.  Use gpsrtk_driver-msg:longitude instead.")
  (longitude m))

(cl:ensure-generic-function 'altitude-val :lambda-list '(m))
(cl:defmethod altitude-val ((m <NavSatMsg>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader gpsrtk_driver-msg:altitude-val is deprecated.  Use gpsrtk_driver-msg:altitude instead.")
  (altitude m))

(cl:ensure-generic-function 'indicator-val :lambda-list '(m))
(cl:defmethod indicator-val ((m <NavSatMsg>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader gpsrtk_driver-msg:indicator-val is deprecated.  Use gpsrtk_driver-msg:indicator instead.")
  (indicator m))

(cl:ensure-generic-function 'utm_easting-val :lambda-list '(m))
(cl:defmethod utm_easting-val ((m <NavSatMsg>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader gpsrtk_driver-msg:utm_easting-val is deprecated.  Use gpsrtk_driver-msg:utm_easting instead.")
  (utm_easting m))

(cl:ensure-generic-function 'utm_northing-val :lambda-list '(m))
(cl:defmethod utm_northing-val ((m <NavSatMsg>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader gpsrtk_driver-msg:utm_northing-val is deprecated.  Use gpsrtk_driver-msg:utm_northing instead.")
  (utm_northing m))

(cl:ensure-generic-function 'zone-val :lambda-list '(m))
(cl:defmethod zone-val ((m <NavSatMsg>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader gpsrtk_driver-msg:zone-val is deprecated.  Use gpsrtk_driver-msg:zone instead.")
  (zone m))

(cl:ensure-generic-function 'letter-val :lambda-list '(m))
(cl:defmethod letter-val ((m <NavSatMsg>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader gpsrtk_driver-msg:letter-val is deprecated.  Use gpsrtk_driver-msg:letter instead.")
  (letter m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <NavSatMsg>) ostream)
  "Serializes a message object of type '<NavSatMsg>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'latitude))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'longitude))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'altitude))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'indicator))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'utm_easting))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'utm_northing))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'zone))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'letter))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'letter))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <NavSatMsg>) istream)
  "Deserializes a message object of type '<NavSatMsg>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'latitude) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'longitude) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'altitude) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'indicator) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'utm_easting) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'utm_northing) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'zone) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'letter) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'letter) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<NavSatMsg>)))
  "Returns string type for a message object of type '<NavSatMsg>"
  "gpsrtk_driver/NavSatMsg")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'NavSatMsg)))
  "Returns string type for a message object of type 'NavSatMsg"
  "gpsrtk_driver/NavSatMsg")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<NavSatMsg>)))
  "Returns md5sum for a message object of type '<NavSatMsg>"
  "3d7c2864efb8990ac4d0f6df54178d44")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'NavSatMsg)))
  "Returns md5sum for a message object of type 'NavSatMsg"
  "3d7c2864efb8990ac4d0f6df54178d44")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<NavSatMsg>)))
  "Returns full string definition for message of type '<NavSatMsg>"
  (cl:format cl:nil "Header header~%float32 latitude~%float32 longitude~%float32 altitude~%float32 indicator~%float32 utm_easting~%float32 utm_northing~%float32 zone~%string letter~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'NavSatMsg)))
  "Returns full string definition for message of type 'NavSatMsg"
  (cl:format cl:nil "Header header~%float32 latitude~%float32 longitude~%float32 altitude~%float32 indicator~%float32 utm_easting~%float32 utm_northing~%float32 zone~%string letter~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <NavSatMsg>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     4
     4
     4
     4
     4
     4
     4
     4 (cl:length (cl:slot-value msg 'letter))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <NavSatMsg>))
  "Converts a ROS message object to a list"
  (cl:list 'NavSatMsg
    (cl:cons ':header (header msg))
    (cl:cons ':latitude (latitude msg))
    (cl:cons ':longitude (longitude msg))
    (cl:cons ':altitude (altitude msg))
    (cl:cons ':indicator (indicator msg))
    (cl:cons ':utm_easting (utm_easting msg))
    (cl:cons ':utm_northing (utm_northing msg))
    (cl:cons ':zone (zone msg))
    (cl:cons ':letter (letter msg))
))
