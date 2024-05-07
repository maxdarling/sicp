;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; given: 2 types of representation
;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define (make-frame origin edge1 edge2)
  (list origin edge1 edge2))
(define (make-frame origin edge1 edge2)
  (cons origin (cons edge1 edge2)))


;; the only change needed is to edge2-frame.


(define (origin-frame frame)
  (car frame))

(define (edge1-frame frame)
  (cadr frame))

;; for the "list" representation
(define (edge2-frame frame)
  (caddr frame))

;; for the pair representation
(define (edge2-frame frame)
  (cddr frame))


;; testing
(define f (make-frame 1 2 3))
(origin-frame f)
(edge1-frame f)
(edge2-frame f)
