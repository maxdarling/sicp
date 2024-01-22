(define (sum-square x y) (+ (* x x) (* y y)))

(define (sum-square-larger-two a b c)
  (cond ((and (>= a b) (>= b c)) (sum-square a b))
	((and (>= a b) (>= c b)) (sum-square a c))
	(else (sum-square b c))))
