;; rudimentary prime test
(define (divides? a b) (= (remainder b a) 0))
(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
	((divides? test-divisor n) test-divisor)
	(else (find-divisor n (+ test-divisor 1)))))
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


;; RESULTS:
;; 3 next primes after 1000: 1009, 1013, 1019
;; 3 next primes after 10000: 10007, 10009, 10037 
;; 3 next primes after 100000: 100003, 100019, 100043
	
;; note: modern compture is too fast to get time diffs for the above.
;; using higher powers instead (see below)

;; TIMING GROWTH COMPARISONS:
;; (search-for-primes 10000000000 3) ;; 1e10 -> ~.07
;;(search-for-primes 100000000000 3)   ;; 1e11 -> ~.25 
;; (search-for-primes 1000000000000 3)   ;; 1e12 -> ~.72
;; (search-for-primes 10000000000000 3)   ;; 1e13 -> ~2.3

;; Yes, the O(√n) time bears out with the above computations. When we 10x n,
;; we see a ~3x increase in the time.
