(load "api")
(load "utils")
(load "cache")


(utils/url-encode '(:sidoCode "11"))

(utils/build-key-value-pair :sidoCode "11" :pair-delim "_")

(utils/string-join "&" "a" "b" "c")

(utils/name-code-result-to-alist
 (api/request-json "getGugunListAjax" :sidoCode "11"))

(api/url "getGugunListAjax" :sidoCode "11")

(api/request "getGugunListAjax" :sidoCode "11")

(api/request-json "getGugunListAjax" :sidoCode "11")

(cache/get-cache-key "getGugunListAjax" :sidoCode "11")

(cache/has-cache "data/getGugunListAjax-sidoCode_11.dat")

(cache/get-cache "data/getGugunListAjax-sidoCode_11.dat")

(cache/set-cache "data/getGugunListAjax-sidoCode_11.dat" "test1")
