#lang setup/infotab
(define name "Persistent Functional Vectors.")
;(define scribblings '(("scribblings/fector.scrbl" (multi-page))))
(define categories '(datastructures))
(define required-core-version "5.1.1")
(define repositories (list "4.x"))
(define primary-file 
  '("main.rkt"))
(define blurb
  (list '(div "Persistent Functional Vectors.")))
(define release-notes 
  (list
   '(div "Now with two flavors: thread-safe and disjoint or fast(er).")))
