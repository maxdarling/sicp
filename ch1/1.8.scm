(define (good-enough? guess x)
  (< (abs (- x (* guess guess guess)))
     (abs (* 0.0001 x))))

;; newton's method for cube roots
(define (improve-guess guess x)
  (/ (+ (/ x (* guess guess))
	(* 2 guess))
     3))

(define (cube-root-iter guess x)
  (if (good-enough? guess x)
      guess
      (cube-root-iter (improve-guess guess x) x)))

(define (cube-root x)
  (cube-root-iter 1.0 x))


(cube-root 8)

(cube-root (- 8))

(cube-root 256)
