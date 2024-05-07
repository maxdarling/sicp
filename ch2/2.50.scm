(define (flip-horiz painter)
  (transform-painter painter
		     (make-vector 1 0)
		     (make-vector 0 0)
		     (make-vector 1 1)))

(define (rotate-180 painter)
  (transform-painter painter
		     (make-vector 1 1)
		     (make-vector 0 1)
		     (make-vector 1 0)))

;; counterclockwise
(define (rotate-270 painter)
  (transform-painter painter
		     (make-vector 1 0)
		     (make-vector 1 1)
		     (make-vector 0 0)))
  
