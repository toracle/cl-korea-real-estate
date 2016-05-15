(defun string-join (delim seq)
  (let
      ((f (concatenate 'string "~{" delim "~a~}")))
    (subseq (format nil f seq) 1)))

(defun convert-code (key value)
  (cond
    ((eq key :jongryuCode) (getf *jongryu-code* value))
    ((eq key :gubunCode) (getf *gubun-code* value))
    ((eq key :gubunCode2) (getf *gubun2-code* value))
    (t value)))

(defun build-key-value-pair (key value)
  (let
       ((_value (convert-code key value)))
    (format nil "~a=~a" key _value)))

(defun url-encode (kwargs)
  (string-join "&"
	       (loop for (key value) on kwargs by #'cddr
		  collect (build-key-value-pair key value))))
