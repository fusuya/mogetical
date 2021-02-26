;;(eval-when (:compile-toplevel :load-toplevel :execute)
 (ql:quickload :ftw)

 (defpackage mogetical
   (:use #:cl #:ftw #:cffi))

;; (in-package mogetical)


(loop :for file :in '("define.lisp" "name.lisp" "item.lisp"  "save.lisp" "mci.lisp"
		       "stage.lisp" "stage-data.lisp"
		      "astar.lisp" "render.lisp" "mogetical.lisp")
     :do (load file :external-format :utf-8))

;; (load "define.lisp" :external-format :utf-8)
;; (load "name.lisp" :external-format :utf-8)

;; (load "save.lisp" :external-format :utf-8)
;; (load "mci.lisp" :external-format :utf-8)
;; (load "item.lisp" :external-format :utf-8)
;; (load "stage.lisp" :external-format :utf-8)
;; (load "stage-data.lisp" :external-format :utf-8)
;; (load "astar.lisp" :external-format :utf-8)
;; (load "render.lisp" :external-format :utf-8)
;; (load "mogetical.lisp" :external-format :utf-8)


#|
(sb-ext:save-lisp-and-die "mogerpg"
        :toplevel #'main
        :save-runtime-options t
        :executable t)
|#
