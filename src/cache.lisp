(load "utils")

(defun cache/get-cache-key (cmd &rest kwargs)
  (let* ((key (utils/url-encode kwargs
				:delim "-"
				:pair-delim "_"))
	 (filename (format nil "~a-~a" cmd key)))
    (namestring (make-pathname :directory "data"
			       :name filename
			       :type "dat"))))

(defun cache/has-cache (cache-key)
  (if (probe-file cache-key)
      t
      nil))

(defun cache/get-cache (cache-key)
  (when (cache/has-cache cache-key)
    (with-open-file (stream cache-key)
      (let ((data (make-string (file-length stream))))
	(read-sequence data stream)
	data))))

(defun cache/set-cache (cache-key content)
  (if content
      (let ((parent-dir (pathname cache-key)))
	(ensure-directories-exist parent-dir)
	(with-open-file (stream cache-key
				:direction :output
				:if-exists :supersede)
	  (format stream content)
	  content))
      (delete-file cache-key)))

(defun cache/get-or-set-cache (cache-key content-func)
  (if (cache/has-cache cache-key)
      (cache/get-cache cache-key)
      (cache/set-cache cache-key (funcall content-func))))
