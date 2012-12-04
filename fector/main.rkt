#lang racket/base
#|  _    ____  ___   ______________________  _   _____    __ 
   | |  / / / / / | / / ____/_  __/  _/ __ \/ | / /   |  / / 
   | | / / / / /  |/ / /     / /  / // / / /  |/ / /| | / /  
   | |/ / /_/ / /|  / /___  / / _/ // /_/ / /|  / ___ |/ /___
   |___/\____/_/ |_/\____/ /_/ /___/\____/_/ |_/_/  |_/_____/
       ____________________________  ____  _____
      / ____/ ____/ ____/_  __/ __ \/ __ \/ ___/
     / /_  / __/ / /     / / / / / / /_/ /\__ \ 
    / __/ / /___/ /___  / / / /_/ / _, _/___/ / 
   /_/   /_____/\____/ /_/  \____/_/ |_|/____/               
   Persistent Functional Vectors.

   Copyright (c) 2011 David Van Horn
   Licensed under the Academic Free License version 3.0
  
   (at dvanhorn (dot ccs neu edu))

   Vucking vast vunctional fectors.

   Based on Conchon and Filliaˆtre, ML Workshop 2007,
   which is based on Baker, CACM 1978.
|#

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

(include "fector.rktl")
