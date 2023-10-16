
(cl:in-package :asdf)

(defsystem "gpsrtk_driver-msg"
  :depends-on (:roslisp-msg-protocol :roslisp-utils :std_msgs-msg
)
  :components ((:file "_package")
    (:file "NavSatMsg" :depends-on ("_package_NavSatMsg"))
    (:file "_package_NavSatMsg" :depends-on ("_package"))
  ))