(define (filter-accumulate filter combiner null-value term a next b)
  (cond ((> a b) null-value)
	(else (combiner
	       (if (filter a) (term a) null-value)
	       (filter-accumulate
		filter
		combiner
		null-value
		term
		(next a)
		next
		b)))))


;; helpers
(define (inc x) (+ x 1))
(define (identity x) x)
(define (T x) #t)
(define (prime? n)
  ;; naive prime sieve
  (define (p-sieve i n)
    (cond ((>= i n) #t)
	  ((= 0 (remainder n i)) #f)
	  (else (p-sieve (+ i 1) n))))
  (p-sieve 2 n))

(define (gcd a b)
  (if (= b 0)
      a
      (gcd b (remainder a b))))
  
(define (rel-prime-6 a)
  (= 1 (gcd a 6)))
    

;; test 0: factorial
(filter-accumulate T * 1 identity 1 inc 5) ;; 120

;; test 1: sum of squares of primes in [a,b]
(filter-accumulate prime? * 1 identity 1 inc 5) ;; 1 * 2 * 3 * 5 = 30

;; test 2: product of all pos. integers less than 6 that are relatively prime to 6
(filter-accumulate rel-prime-6 * 1 identity 1 inc 6) ;; 1 * 5 = 5
