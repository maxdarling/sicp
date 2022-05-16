;; cont-frac from 1.37
(define (cont-frac n d k)
  (define (cf-rec n d k i)
    (if (> i k)
	0
	(/ (n i) (+ (d i) (cf-rec n d k (+ i 1))))))
  (cf-rec n d k 1))


;; compute tan(x) where k is # of terms
(define (tan-x x k)
  (cont-frac (lambda (i)
	       (if (= i 1) x (- (* x x))))
	     (lambda (i)
	       (- (* 2 i) 1))
	     k))



(tan-x 0.0 40) ;; 0
(tan-x 3.1415 40) ;; 0
(tan-x 0.785375 40) ;; .9999
(tan-x 1.57075 40) ;; 21585 (should be inf. but ok)

