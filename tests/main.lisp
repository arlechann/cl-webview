(defpackage cffi-webview/tests/main
  (:use :cl
        :cffi-webview
        :rove))
(in-package :cffi-webview/tests/main)

;; NOTE: To run this test file, execute `(asdf:test-system :cffi-webview)' in your Lisp.

(deftest test-target-1
  (testing "should (= 1 1) to be true"
    (ok (= 1 1))))
