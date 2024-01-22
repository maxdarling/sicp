;; compute the k-term finite continued fraction where (n i) = N_i and (d i) = D_i
(define (cont-frac n d k)
  (define (cf-iter i)
    (if (= i k) 0.0
	(/ (n i) (+ (d i) (cf-iter (+ i 1))))))

  (cf-iter 1))

;; iterative version
(define (cont-frac n d k)
  (define (cf-iter k res)
    (if (= k 0) res
	(cf-iter (- k 1) (/ (n k) (+ (d k) res)))))

  (cf-iter k 0.0))


;; approximate 1/φ = 0.6180 to 4 decimal places
(cont-frac (lambda (x) 1) (lambda (x) 1) 11) ;; -> 0.6179
(cont-frac (lambda (x) 1) (lambda (x) 1) 12) ;; -> 0.6180
