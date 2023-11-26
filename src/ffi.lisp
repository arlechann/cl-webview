(defpackage webview/ffi
  (:use :cl :cffi)
  (:export
   :*size-none*
   :*size-min*
   :*size-max*
   :*size-fixed*
   :webview-t
   :webview_version_t
   :webview_version_info_t
   :webview-create
   :webview-destroy
   :webview-run
   :webview-terminate
   :webview-dispatch
   :webview-get-window
   :webview-set-title
   :webview-set-size
   :webview-navigate
   :webview-set-html
   :webview-init
   :webview-eval
   :webview-bind
   :webview-unbind
   :webview-return
   :webview-version))
(in-package :webview/ffi)

(push #P"." *foreign-library-directories*)

(define-foreign-library webview
  (:windows #P"webview.dll"))

(use-foreign-library webview)

(defvar *size-none* 0)
(defvar *size-min* 1)
(defvar *size-max* 2)
(defvar *size-fixed* 3)

(defctype webview-t (:pointer :void))

(defcfun "webview_create" webview-t
  (debug :int)
  (window (:pointer :void)))

(defcfun "webview_destroy" :void
  (webview webview-t))

(defcfun "webview_run" :void
  (webview webview-t))

(defcfun "webview_terminate" :void
  (webview webview-t))

(defcfun "webview_dispatch" :void
  (webview webview-t)
  (fn :pointer)
  (arg (:pointer :void)))

(defcfun "webview_get_window" (:pointer :void)
  (webview webview-t))

(defcfun "webview_set_title" :void
  (webview webview-t)
  (title (:pointer :char)))

(defcfun "webview_set_size" :void
  (webview webview-t)
  (width :int)
  (height :int)
  (hint :int))

(defcfun "webview_navigate" :void
  (webview webview-t)
  (url (:pointer :char)))

(defcfun "webview_set_html" :void
  (webview webview-t)
  (html (:pointer :char)))

(defcfun "webview_init" :void
  (webview webview-t)
  (js (:pointer :char)))

(defcfun "webview_eval" :void
  (webview webview-t)
  (js (:pointer :char)))

(defcfun "webview_bind" :void
  (webview webview-t)
  (name (:pointer :char))
  (fn :pointer)
  (arg (:pointer :void)))

(defcfun "webview_unbind" :void
  (webview webview-t)
  (name (:pointer :char)))

(defcfun "webview_return" :void
  (webview webview-t)
  (seq (:pointer :char))
  (status :int)
  (result (:pointer :char)))

(defcstruct webview_version_t
  (major :unsigned-int)
  (minor :unsigned-int)
  (patch :unsigned-int))

(defcstruct webview_version_info_t
  (version (:struct webview_version_t))
  (version_number :char :count 32)
  (pre_release :char :count 48)
  (build_metadata :char :count 48))

(defcfun "webview_version" (:pointer (:struct webview_version_t)))

