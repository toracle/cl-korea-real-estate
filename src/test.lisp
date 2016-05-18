(load "api")

(setq result (api/request-json "getGugunListAjax" '(:sidoCode "11")))

(utils/name-code-result-to-alist result)
