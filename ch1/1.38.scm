(define (cont-frac n d k)
  (define (cf-iter i)
    (if (= i k) 0.0
	(/ (n i) (+ (d i) (cf-iter (+ i 1))))))

  (cf-iter 1))


;; approximate e-2 (0.7182...) via the continued fraction expansion with
;; N_i = 1 and D_i... = 1, 2, 1, 1, 4, 1, 1, 6, 1, 1, 8, ...

(define (D_i i)
  (cond ((= (remainder i 3) 2) (* 2 (/ (+ i 1) 3)))
	(else 1)))

(cont-frac (lambda (x) 1) D_i 100) ;; -> 0.7182...
