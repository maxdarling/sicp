;; make a segment given points a and b
(define (make-segment a b) (cons a b))
(define (start-segment x) (car x))
(define (end-segment x) (cdr x))

(define (make-point x y) (cons x y))
(define (x-point p) (car p))
(define (y-point p) (cdr p))

(define (print-point p)
  (newline)
  (display "(")
  (display (x-point p))
  (display ",")
  (display (y-point p))
  (display ")"))


;; midpoint routine
(define (midpoint-segment s)
  (define (avg x y) (/ (+ x y) 2))
  (let ((a (start-segment s))
	(b (end-segment s)))
    (make-point (avg (x-point a) (x-point b))
		(avg (y-point a) (y-point b)))))


;; testing
(define u (make-segment (make-point 0 1)
			(make-point 10 11)))

(define v (make-segment (make-point 5 2)
			(make-point (- 3) (- 5))))


(print-point (midpoint-segment u))
(print-point (midpoint-segment v))
