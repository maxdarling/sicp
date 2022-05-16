;; from 1.37
(define (cont-frac n d k)
  (define (cf-rec n d k i)
    (if (> i k)
	0
	(/ (n i) (+ (d i) (cf-rec n d k (+ i 1))))))
  (cf-rec n d k 1))

;; 1.38: approx e-2 via special continued fraction
(define (euler-n i) 1.0)
(define (euler-d i)
  (cond ((= i 1) 1)
	((= i 2) 2)
	((= (remainder (- i 2) 3) 0) (* 2/3 (+ i 1)))
	(else 1)))
  

;; test
(cont-frac (lambda (x) 1.0) 
	   (lambda (x) 1.0)
	   30)

(cont-frac euler-n euler-d 40) ;;.7182818284590453 ~= e-2

(euler-d 1) ;; 1
(euler-d 2) ;; 2
(euler-d 3) ;; 1
(euler-d 4) ;; 1
(euler-d 5) ;; 4
(euler-d 6) ;; 1
(euler-d 7) ;; 1
(euler-d 8) ;; 6


