(defmacro utils/loop-plist-collect (key-value-variable plist &rest body)
  `(loop for ,key-value-variable on ,plist by #'cddr
      collect ,@body))

(defun utils/string-join (delim &rest seq)
  (let
      ((f (concatenate 'string "~{" delim "~a~}")))
    (subseq (format nil f seq) 1)))

(defun utils/convert-code (key value)
  (cond
    ((eq key :jongryuCode) (getf *code/jongryu-code* value))
    ((eq key :gubunCode) (getf *code/gubun-code* value))
    ((eq key :gubunCode2) (getf *code/gubun2-code* value))
    (t value)))

(defun utils/build-key-value-pair (key value &key (pair-delim "="))
  (let
       ((_value (utils/convert-code key value)))
    (format nil "~a~a~a" key pair-delim _value)))

(defun utils/url-encode (kwargs &key (delim "&") (pair-delim "="))
  (apply #'utils/string-join
	 (cons delim
	       (loop for (key value) on kwargs by #'cddr
		  collect (utils/build-key-value-pair key value :pair-delim pair-delim)))))

(defun utils/name-code-to-alist-item (elem)
  (cons
   (cdr (assoc :+name+ elem))
   (cdr (assoc :+code+ elem))))

(defun utils/name-code-result-to-alist (result)
  (map 'list
       #'utils/name-code-to-alist-item
       (cdr (car result))))
