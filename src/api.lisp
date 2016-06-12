(setf (readtable-case *readtable*) :invert)

(ql:quickload :dexador)
(ql:quickload :cl-json)

(load "code")
(load "utils")

(defvar *rtms-mobile-url* "http://rtmobile.molit.go.kr/app/main.jsp")

;; (defvar *rtms-mobile-base-url* "http://rtmobile.molit.go.kr/mobile.do")
(defvar *rtms-mobile-base-url* "http://rtmobile.molit.go.kr/srh/")

(defvar *rtms-url* "http://rt.molit.go.kr/rtApt.do?cmd=srhLocalView")

(defvar *api-cache-enabled* nil)

(defun api/url (cmd &rest kwargs)
  (let ((param (utils/url-encode kwargs)))
    (format nil "~a~a.do?~a" *rtms-mobile-base-url* cmd param)))

(defun api/request (cmd &rest kwargs)
  (let* ((args (cons cmd kwargs))
	 (url (apply #'api/url args))
	 (content (dex:get url)))
    content))

(defun api/content-provider (cmd &rest kwargs)
  (let ((args (cons cmd kwargs))
	(cache-key (cache/get-cache-key args)))
    (if *api-cache-enabled*
	(if (cache/has-cache cache-key)
	    (cache/get-cache cache-key)
	    (cache/set-cache cache-key (api/request args)))
	(api/request args))))

(defun api/request-json (cmd &rest kwargs)
  (let ((args (cons cmd kwargs)))
    (json:decode-json-from-string (apply #'api/request args))))
