(defun string/join (delim seq)
  (let
      ((f (concatenate 'string "~{" delim "~a~}")))
    (subseq (format nil f seq) 1)))

(provide 'utils)

