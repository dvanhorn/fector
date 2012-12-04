#lang racket
;; Assumed single threaded.
(define (atomic th) (th))
#| 
   Compared to main.rkt, this version of the library provides functional 
   vectors that:

      * are not interoperable with main.rkt fectors,
      * are not disjoint from other datatypes, 
      * are not thread safe,
      * do not extend equal? to implement extensional equality properly.
|#
(include "fector.rktl")
