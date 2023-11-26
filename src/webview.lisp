(defpackage webview
  (:use :cl :webview/ffi)
  (:export
   :*size-none*
   :*size-min*
   :*size-max*
   :*size-fixed*
   :webview
   :title
   :width
   :size-hint
   :url
   :run))
(in-package webview)

(defclass webview ()
  ((handle :accessor handle :initform nil :initarg :handle)
   (title :accessor title :initform nil :initarg :title)
   (width :accessor width :initform nil :initarg :width)
   (height :accessor height :initform nil :initarg :height)
   (size-hint :accessor size-hint :initform *size-none* :initarg :size-hint)
   (url :accessor url :initform nil :initarg :url)))

(defmethod ensure-handle ((w webview) &key debug)
  (with-slots (handle) w
    (when (null handle)
      (setf handle
            (webview-create (if debug 1 0)
                            (cffi:null-pointer))))))

(defmethod apply-title ((w webview))
  (with-slots (handle title) w
    (when title
      (cffi:with-foreign-string (title title)
        (webview-set-title handle title)))))

(defmethod apply-size ((w webview))
  (with-slots (handle width height size-hint) w
    (when (and width height size-hint)
      (webview-set-size handle
                        width
                        height
                        size-hint))))

(defmethod navigate ((w webview))
  (with-slots (handle url) w
    (cffi:with-foreign-string (url url)
      (webview-navigate handle url))))

(defmethod execute ((w webview))
  (with-slots (handle) w
    (webview-run handle)))

(defmethod terminate ((w webview))
  (with-slots (handle) w
    (webview-terminate handle)
    (webview-destroy handle)
    (setf handle nil)))

(defun run (webview &key debug)
  (ensure-handle webview :debug debug)
  (apply-title webview)
  (apply-size webview)
  (navigate webview)
  (execute webview)
  (terminate webview))

