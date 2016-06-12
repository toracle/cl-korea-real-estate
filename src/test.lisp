(load "api")

(utils/name-code-result-to-alist
 (api/request-json "getGugunListAjax" :sidoCode "11"))

(api/url "getGugunListAjax" :sidoCode "11")

(api/request "getGugunListAjax" :sidoCode "11")

(api/request-json "getGugunListAjax" :sidoCode "11")
