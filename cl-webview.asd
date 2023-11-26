(defsystem "cl-webview"
  :version "0.10.0"
  :author "arlechann"
  :mailto "dragnov3728@gmail.com"
  :license "CC0-1.0"
  :depends-on ("cffi")
  :components ((:module "src"
                :components
                ((:file "ffi")
                 (:file "webview"))))
  :description ""
  :in-order-to ((test-op (test-op "cl-webview/tests"))))

(defsystem "cl-webview/tests"
  :author "arlechann"
  :license "MIT"
  :depends-on ("cl-webview"
               "rove")
  :components ((:module "tests"
                :components
                ((:file "main"))))
  :description "Test system for cl-webview"
  :perform (test-op (op c) (symbol-call :rove :run c)))

