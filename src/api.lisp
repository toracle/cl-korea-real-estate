(setf (readtable-case *readtable*) :invert)

(ql:quickload :dexador)
(ql:quickload :cl-json)

(load "code")
(load "utils")

(defparameter *rtms-mobile-url* "http://rtmobile.molit.go.kr/app/main.jsp")

(defparameter *rtms-mobile-base-url* "http://rtmobile.molit.go.kr/srh/")

(defparameter *rtms-url* "http://rt.molit.go.kr/rtApt.do?cmd=srhLocalView")

(defparameter *api-cache-enabled* t)

(defun api/url (cmd &rest kwargs)
  (let ((param (utils/url-encode kwargs)))
    (format nil "~a~a.do?~a" *rtms-mobile-base-url* cmd param)))

(defun api/request (cmd &rest kwargs)
  (let* ((args (cons cmd kwargs))
	 (url (apply #'api/url args))
	 (content (dex:get url)))
    content))

(defun api/content-provider (cmd &rest kwargs)
  (let* ((args (cons cmd kwargs))
	 (cache-key (apply #'cache/get-cache-key args)))
    (if *api-cache-enabled*
	(json:decode-json-from-string (cache/get-or-set-cache cache-key
							      (lambda () (apply #'api/request args))))
	(apply #'api/request-json args))))

(defun api/request-json (cmd &rest kwargs)
  (let ((args (cons cmd kwargs)))
    (json:decode-json-from-string (apply #'api/request args))))

(defun api/gugun-list (&key sidoCode)
  (if sidoCode
      (utils/name-code-result-to-alist (api/content-provider "getGugunListAjax" :sidoCode sidoCode))
      (map 'list
	   #'(lambda (elem) (api/gugun-list :sidoCode (getf elem :sido-code)))
	   *code/sido-list*)))
