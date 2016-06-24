(asdf:defsystem :cl-korea-real-estate
  :description "Korean real estate data crawler"
  :version "0.0.1"
  :depends-on (#:dexador
	       #:cl-json)
  :serial t
  :components ((:file "src/package")
	       (:file "src/code")
	       (:file "src/utils")
	       (:file "src/cache")
	       (:file "src/api")))))
