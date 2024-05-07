(load "2.7.scm")

(define (make-center-percent c p)
  (let ((width (* c p)))
    (make-interval (- c width) (+ c width))))

(define (center i)
  (/ (+ (upper-bound i) (lower-bound i))
     2))

(define (percent i)
  (let ((width (/ (- (upper-bound i) (lower-bound i))
		  2))
	(c (/ (+ (upper-bound i) (lower-bound i))
	      2)))
    (/ width c)))

(define (display-center-percent i)
  (newline)
  (display "[")
  (display (center i))
  (display ",")
  (display (percent i))
  (display "]"))


(define a (make-center-percent 3.5 0.1))
(display-interval a)
(percent a)
