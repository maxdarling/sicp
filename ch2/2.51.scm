(load "2.50.scm")

;; given
(define (beside painter1 painter2)
  (let ((split-point (make-vect 0.5 0.0)))
    (let ((paint-left
	   (transform-painter
	    painter1
	    (make-vect 0.0 0.0)
	    split-point
	    (make-vect 0.0 1.0)))
	  (paint-right
	   (transform-painter
	    painter2
	    split-point
	    (make-vect 1.0 0.0)
	    (make-vect 0.5 1.0))))
      (lambda (frame)
	(paint-left frame)
	(paint-right frame)))))



;; APPROACH 1: use transform-vector (like "beside" above)
(define (below painter1 painter2)
  (let ((split-point (make-vect 0.0 0.5)))
    (let ((paint-below
	   (transform-painter
	    painter1
	    (make-vect 0.0 0.0)
	    (make-vect 1.0 0.0)
	    split-point))
	  (paint-above
	   (transform-painter
	    painter2
	    split-point
	    (make-vect 1.0 0.5)
	    (make-vect 0 1.0))))
      (lambda (frame)
	(paint-below frame)
	(paint-above frame)))))


;; APPROACH 2: use "beside" and the rotations from 2.50
(define (below painter1 painter2)
 ;; a "below" is equal to a "beside" of 2 90°-clockwise rotated frames, all rotated
 ;; 90°-counterclockwise.
 ;; - 90°-clockwise is just 270°-counterclockwise, which we have from 2.50
 ;; - 90°-counterclockwise is a 180 rotation plus a 90°-clockwise.
  (define (rotate-90 painter)
    (rotate-270 (rotate-180 painter)))

  (rotate-90 (beside (rotate-270 painter1)
		     (rotate-270 painter2))))
