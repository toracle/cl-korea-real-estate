(setf (readtable-case *readtable*) :invert)

(ql:quickload :dexador)
(ql:quickload :cl-json)

(load "code")
(load "utils")

(defvar *rtms-mobile-url* "http://rtmobile.molit.go.kr/app/main.jsp")

;; (defvar *rtms-mobile-base-url* "http://rtmobile.molit.go.kr/mobile.do")
(defvar *rtms-mobile-base-url* "http://rtmobile.molit.go.kr/srh/")

(defvar *rtms-url* "http://rt.molit.go.kr/rtApt.do?cmd=srhLocalView")

(defvar *api-cache-enabled* t)

(defun api/url (cmd &rest kwargs)
  (let ((param (utils/url-encode kwargs)))
    (format nil "~a~a.do?~a" *rtms-mobile-base-url* cmd param)))

(defun api/request (cmd &rest kwargs)
  (let* ((url (apply #'api/url (cons cmd kwargs)))
	 (content (dex:get url)))
    content))

(defun api/content-provider (cmd &rest kwargs)
  (if *api-cache-enabled*
      (if (cache/is-content-cached cmd kwargs)
	  (cache/get-cached-content kwargs)
	  (cace/cache-content '(api/request cmd kwargs)))
      (api/request cmd kwargs)))

(defun api/request-json (cmd &rest kwargs)
  (json:decode-json-from-string (apply #'api/request (cons cmd kwargs))))
