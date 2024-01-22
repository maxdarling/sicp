(define (cont-frac n d k)
  (define (cf-iter i)
    (if (= i k) 0.0
	(/ (n i) (+ (d i) (cf-iter (+ i 1))))))

  (cf-iter 1))


;; compute an approximation to the tangent function according to Lambert's
;; continued fraction formula, where k is the number of terms.
(define (tan-cf x k)
  (cont-frac (lambda (i)
	       (if (= i 1) x (- (* x x))))
	     (lambda (i)
	       (- (* 2 i) 1))
	     k))

(define pi 3.14159)
(tan-cf pi 100) ;; -> ~0
(tan-cf (/ pi 4) 100) ;; -> ~1
(tan-cf (* pi 0.75) 100) ;; -> ~ -1
