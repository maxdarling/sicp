(load "2.7.scm")

;; smallest possible value: smallest of a minus largest of b
;; largest possible value: largest of a minus smallest of b
(define (sub-interval a b)
  (make-interval (- (lower-bound a) (upper-bound b))
		 (- (upper-bound a) (lower-bound b))))

;; better: subtracting is the same as adding a negated interval
(define (negate-interval i)
  ;; e.g. [1, 3] becomes [-3, -1]
  (make-interval (- (lower-bound i))
		 (- (upper-bound i))))
(define (sub-interval a b)
  (add-interval
   a
   (negate-interval b)))


(define a (make-interval 1 2))
(define b (make-interval 3 5))
(define c (sub-interval a b))

(display-interval a)
(display-interval c)
