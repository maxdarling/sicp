(load "2.7.scm")

;; revised procedure that checks for by an interval spanning 0
(define (div-interval x y)
  (if (and (<= (lower-bound y) 0) (>= (upper-bound y) 0))
      (error "interval div by 0!")
      (mul-interval
       x
       (make-interval (/ 1.0 (upper-bound y))
		      (/ 1.0 (lower-bound y))))))


(define a (make-interval 1 7))
(define b (make-interval (- 3) (- 5)))
(define c (make-interval (- 1) 1))

(display-interval (div-interval a b))
(display-interval (div-interval a c))
