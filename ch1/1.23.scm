;; improve prime test from last exercise by iterating test divisors faster (2x)
(define (next n)
  (if (= n 2) 3 (+ n 2)))
(define (divides? a b) (= (remainder b a) 0))
(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
	((divides? test-divisor n) test-divisor)
	(else (find-divisor n (next test-divisor)))))
(define (smallest-divisor n) (find-divisor n 2))
(define (prime? n)
  (= n (smallest-divisor n)))

;; timing + printing
(define (timed-prime-test n)
  (newline)
  (display n)
  (start-prime-test n (runtime)))
(define (start-prime-test n start-time)
  (if (prime? n)
      (report-prime (- (runtime) start-time))))
(define (report-prime elapsed-time)
  (display " *** ")
  (display elapsed-time))


;; search for the first n primes in [start, ...)
;; prints the results
(define (search-for-primes start n)
  ;; start must be odd
  (define (sfp start n i)
    (cond ((= i n) #t) ;; arbitrary return val
	  ((prime? start) (timed-prime-test start) (sfp (+ start 2) n (+ i 1)))
	  (else (sfp (+ start 2) n i))))

  (if (= 0 (remainder start 2))
      (sfp (+ start 1) n 0)
      (sfp start n 0)))


;; TIMING GROWTH (prev exercise)
;; (search-for-primes 10000000000 3) ;; 1e10 -> ~.07
;;(search-for-primes 100000000000 3)   ;; 1e11 -> ~.25 
;; (search-for-primes 1000000000000 3)   ;; 1e12 -> ~.72
;; (search-for-primes 10000000000000 3)   ;; 1e13 -> ~2.3

;; TIMING GROWTH (improved)
(search-for-primes 10000000000 3) ;; 1e10 -> ~.05
(search-for-primes 100000000000 3)   ;; 1e11 -> ~.15
(search-for-primes 1000000000000 3)   ;; 1e12 -> ~.45
(search-for-primes 10000000000000 3)   ;; 1e13 -> ~1.45

;; Explanation: we are iterating next-divisor 2x as "quickly" which leads to
;; ~1/2 the number of next-divisor calls, which dominates the # of operations in
;; the 'prime?' test. however, we see a ~1.5x speedup instead of the expected 2x.
;; presumably this is because we've added some extra constant-time operations in
;; the 'next' procedure (this is what the wiki says and I guess there's no deeper
;; answer here. huh.)
