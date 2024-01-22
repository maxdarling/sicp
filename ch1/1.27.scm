(define (expmod base exp m)
  (cond ((= exp 0) 1)
	((even? exp)
	 (remainder
	  (square (expmod base (/ exp 2) m))
	  m))
	(else
	 (remainder
	  (* base (expmod base (- exp 1) m))
	  m))))

;; need to use non-fermat prime to test carmichael numbers, duh :)
(define (prime? n)
  (define (smallest-divisor n) (find-divisor n 2))
  (define (find-divisor n test-divisor)
    (cond ((> (square test-divisor) n) n)
	  ((divides? test-divisor n) test-divisor)
	  (else (find-divisor n (+ test-divisor 1)))))
  (define (divides? a b) (= (remainder b a) 0))
  (= n (smallest-divisor n)))
 
;; -------------------
;; -- END OF GIVENS --
;; -------------------

(define (carmichael? n)
  (define (car-it a)
    (cond ((= a n) true)
	  ((not (= (expmod a n n) a)) false)
	  (else (car-it (+ a 1)))))

  (and (not (prime? n))
       (car-it 1)))

;; find carmichael numbers up to n
(define (enumerate-carmichael n)
  (define (print n)
    (newline)
    (display n))
  ;; start must be odd
  (define (search-iter i)
    (cond ((= i n) #t)
	  ((carmichael? i) (print i) (search-iter (+ i 1)))
	  (else (search-iter (+ i 1)))))

  (search-iter 2))

;; there are 255 carmichael numbers below 100,000,000, and the smallest few are:
;; 561, 1105, 1729, 2465, 2821, 6601.

(enumerate-carmichael 100000)
