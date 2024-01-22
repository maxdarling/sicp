(define (improve guess x)
  (average guess (/ x guess)))

(define (average x y)
  (/ (+ x y) 2))

(define (good-enough? guess x)
  (< (abs (- (square guess) x)) 0.001))

(define (sqrt-iter guess x)
  (if (good-enough? guess x)
	  guess
	  (sqrt-iter (improve guess x) x)))

(define (sqrt x) (sqrt-iter 1.0 x))


;; very small numbers: the 'good-enough?' check never returns true because the
;; tolerance (0.001) is too large (larger than x or sqrt(x) themselves),
;; so the computation never converges.
;; (sqrt 0.0001)

;; very large numbers: the machine precision cannot represent small differences
;; between very large numbers (e.g. a tolerance of 0.001), so best-guess never
;; converges.
(sqrt 1000000000000) ;; works

;; (sqrt 10000000000000) ;; causes infinite loop

;; I can't get the below to work for some reason... despite these being the
;; answers.
(define (good-enough-v2? guess x)
  (= (improve guess x) guess))

(define (good-enough-v3? guess x)
  (< (abs(- (square guess) x))
     (* 0.0001 * guess)))
