(setf (readtable-case *readtable*) :invert)

(ql:quickload :dexador)
(ql:quickload :cl-json)

(load "code")
(load "utils")

(defvar *rtms-mobile-url* "http://rtmobile.molit.go.kr/app/main.jsp")

;; (defvar *rtms-mobile-base-url* "http://rtmobile.molit.go.kr/mobile.do")
(defvar *rtms-mobile-base-url* "http://rtmobile.molit.go.kr/srh/")

(defvar *rtms-url* "http://rt.molit.go.kr/rtApt.do?cmd=srhLocalView")

(defun api-url (cmd kwargs)
  (let ((param (url-encode kwargs)))
    (format nil "~a~a.do?~a" *rtms-mobile-base-url* cmd param)))

(defun api-request (cmd kwargs)
  (let* ((url (api-url cmd kwargs))
	 (content (dex:get url)))
    content))

(defun api-request-json (cmd kwargs)
  (json:decode-json-from-string (api-request cmd kwargs)))

(api-request-json "getGugunListAjax" '(:sidoCode "11"))
