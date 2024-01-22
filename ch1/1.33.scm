;; original
(define (accumulate combiner null-value term a next b)
  (if (> a b)
      null-value
      (combiner (term a)
		(accumulate combiner null-value term (next a) next b))))


;; accumulate, but only use the a'th term if (filter a) is true.
(define (filtered-accumulate combiner filter null-value term a next b)
  (if (> a b) null-value
      (combiner (filtered-accumulate combiner filter null-value term (next a) next b)
		(if (filter a) (term a) null-value))))


;; TESTING
(define (inc n) (+ n 1))
(define (identity n) n)
(define (prime? n)
  (define (smallest-divisor n) (find-divisor n 2))
  (define (find-divisor n test-divisor)
    (cond ((> (square test-divisor) n) n)
	  ((divides? test-divisor n) test-divisor)
	  (else (find-divisor n (+ test-divisor 1)))))
  (define (divides? a b) (= (remainder b a) 0))
  (if (= n 1) false
      (= n (smallest-divisor n))))
(define (gcd a b)
  (if (= b 0)
      a
      (gcd b (remainder a b))))

;; sum of squares of primes in [a, b]
(define (sum-of-prime-squares a b)
  (filtered-accumulate + prime? 0 square a inc b))

(sum-of-prime-squares 1 10) ;; = 2^2 + 3^2 + 5^2 + 7^2 = 87

;; product of all positive integers less than n that are relatively prime to n
(define (sum-of-relative-primes n)
  (define (rel-prime? a)
    (cond ((= 1 (gcd n a)) (display a) (newline) true)
	  (else false)))

  (filtered-accumulate + rel-prime? 0 identity 1 inc n))

(sum-of-relative-primes 100)
