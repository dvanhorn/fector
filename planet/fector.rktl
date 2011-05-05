(provide make-fector fector fector-length 
         build-fector fector-ref fector-set)

;; An [Fector X] is a (fox [Data X])
;; A [Data X] is one of:
;; - [Vector X]
;; - (list Nat X [Fector X])

(provide make-fector fector fector-length 
         build-fector fector-ref fector-set)

;; An [Fector X] is a (box [Data X])
;; A [Data X] is one of:
;; - [Vector X]
;; - (list Nat X [Fector X])

(define (make-fector n x)
  (box (make-vector n x)))

(define (fector . xs)
  (box (apply vector xs)))
  
(define (fector-length fv)
  (atomic 
   (λ ()
     (reroot! fv)
     (vector-length (unbox fv)))))
   
(define (build-fector n f)
  (box (build-vector n f)))

(define (fector-ref fv i)
  (atomic
   (λ ()
     (let ((v (unbox fv)))
       (cond 
         [(pair? v)
          (reroot! fv)
          (vector-ref (unbox fv) i)]
         [else
          (vector-ref v i)])))))
   
(define (fector-set fv i x)
  (atomic 
   (λ ()
     (reroot! fv)
     (let ((v (unbox fv)))
       (let ((old (vector-ref v i)))
         (vector-set! v i x)
         (let ((res (box v)))
           (set-box! fv (list i old res))
           res))))))

(define (reroot! fv)
  (match (unbox fv)
    [(list i x fv*)
     (reroot! fv*)     
     (let ((v (unbox fv*)))
       (let ((x* (vector-ref v i)))         
         (vector-set! v i x)
         (set-box! fv v)
         (set-box! fv* (list i x* fv))))]
    [_ (void)]))
