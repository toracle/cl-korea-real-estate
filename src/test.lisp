(load "api")
(load "utils")
(load "cache")
(load "code")


(utils/url-encode '(:sidoCode "11"))

(utils/build-key-value-pair :sidoCode "11" :pair-delim "_")

(utils/string-join "&" "a" "b" "c")

(utils/name-code-result-to-alist
 (api/request-json "getGugunListAjax" :sidoCode "11"))

(cache/get-cache-key "getGugunListAjax" :sidoCode "11")

(cache/has-cache "data/getGugunListAjax-sidoCode_11.dat")

(cache/get-cache "data/getGugunListAjax-sidoCode_11.dat")

(cache/set-cache "data/getGugunListAjax-sidoCode_11.dat" "test1")

(cache/set-cache "data/getGugunListAjax-sidoCode_11.dat" nil)

(cache/get-or-set-cache "data/getGugunListAjax-sidoCode_11.dat"
			(lambda () (format nil "aaa")))

(api/request-json "getGugunListAjax" :sidoCode "11")

(api/url "getGugunListAjax" :sidoCode "11")

(api/request "getGugunListAjax" :sidoCode "11")

(api/request-json "getGugunListAjax" :sidoCode "11")

(api/content-provider "getGugunListAjax" :sidoCode "11")

(api/request-json "getDongListAjax" :sidoCode "11" :gugunCode "11620")

(api/gugun-list :sidoCode "11")

(api/gugun-list)
