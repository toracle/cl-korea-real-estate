(load "api")

(utils/name-code-result-to-alist
 (api/request-json "getGugunListAjax" '(:sidoCode "11")))
