(setf (readtable-case *readtable*) :invert)

(load "utils")
(load "code")

(defvar *rtms-mobile-url* "http://rtmobile.molit.go.kr/app/main.jsp")

(defvar *rtms-mobile-base-url* "http://rtmobile.molit.go.kr/mobile.do")

(defvar *rtms-url* "http://rt.molit.go.kr/rtApt.do?cmd=srhLocalView")

(defun convert-code (key value)
  (cond
    ((eq key :jongryuCode) (getf *jongryu-code* value))
    ((eq key :gubunCode) (getf *gubun-code* value))
    ((eq key :gubunCode2) (getf *gubun2-code* value))
    (t value)))

(defun build-key-value-pair (pair)
  (let*
      ((key (car pair))
       (value (cdr pair))
       (_value (convert-code key value)))
    (format nil "~a=~a" key _value)))

(defun url-encode (kwargs)
  (string/join "&"
	       (map 'list #'build-key-value-pair kwargs)))

(defun api-url (kwargs)
  (let ((param (build-url-param kwargs)))
    (format nil "~a?~a" *rtms-mobile-base-url* param)))

(api-url '((:cmd . "getDanjiInfoAjax")
	   (:jongryuCode . 1)))

