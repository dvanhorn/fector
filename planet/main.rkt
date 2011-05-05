#lang racket/base
#|
   This library enjoys:

      * thread safety,
      * disjointness, and
      * extensional equality.
|#
(require racket/match
         racket/include)
(provide fector?)

(define s (make-semaphore 1))
(define (atomic th)
  (begin (semaphore-wait s)
         (begin0 (th)
                 (semaphore-post s))))

;; Like a box, but different.
(struct box (v) 
        #:mutable
        #:property prop:equal+hash
        (list
         (λ (f1 f2 equal?)
           (reroot! f1)
           (reroot! f2)
           (equal? (unbox f1) (unbox f2)))
         (λ (f equal-hash-code)
           (reroot! f)
           (equal-hash-code (unbox f)))
         (λ (f equal-hash-code)
           (reroot! f)
           (equal-hash-code (unbox f)))))

(define (set-box! fb x) (set-box-v! fb x))
(define (unbox fb) (box-v fb))

(define (fector? x) (box? x))

(include "fector.rkt")
