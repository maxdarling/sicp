;; a)
(define (wave frame)
  ;; placeholder code for wave (I never implemented it...)
  (segments->painter (list
		      ;; start of existing segments...
		      (make-segment (make-vector 0.33 0) (make-vector 0.5 0.33))
		      ;; start of new segments...
		      (make-segment (make-vector 0.123 0) (make-vector 0.123 0.123)))))

;; b)
(define (corner-split painter n) 
  (if (= n 0) 
      painter 
      (beside (below painter (up-split painter (- n 1))) 
              (below (right-split painter (- n 1)) (corner-split painter (- n 1)))))) 

;; c)
(define (square-limit painter n)
  ;; change: flip everything horizontally
  (let ((combine4 (square-of-four identity flip-horiz
				  flip-vert rotate180)))
    (combine4 (corner-split painter n))))
