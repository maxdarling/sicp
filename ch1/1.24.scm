;; efficient prime test
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
(define (fermat-test n)
  (define (try-it a)
    (= (expmod a n n) a))
  (try-it (+ 1 (random (- n 1)))))
(define (fast-prime? n times)
  (cond ((= times 0) true)
	((fermat-test n) (fast-prime? n (- times 1)))
	(else false)))
(define (prime? n)
  (fast-prime? n 100))

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


;; TIMING GROWTH (ex 1.22, O(√n) growth)
;; (search-for-primes 10000000000 3) ;; 1e10 -> ~.07
;;(search-for-primes 100000000000 3)   ;; 1e11 -> ~.25 
;; (search-for-primes 1000000000000 3)   ;; 1e12 -> ~.72
;; (search-for-primes 10000000000000 3)   ;; 1e13 -> ~2.3

;; TIMING GROWTH (improved)
;; it's really fast! let's crank up the numbers (using fast-prime 100).
;; 1e50 -> ~0.03
(search-for-primes 100000000000000000000000000000000000000000000000000 3)
;; 1e100 -> ~0.08
(search-for-primes 10000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000 3)
;; 1e150 -> ~0.16
(search-for-primes 1000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000 3)
;; 1e200 -> ~0.27
(search-for-primes 100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000 3)

;; the time growth is a bit faster than logarithmic. e.g. you'de expect squaring
;; 1e50 to 1e100 would double the time - 0.03 to 0.06, but you get 0.08. close
;; enough. but then cubing and quarting 1e50 to 1e150 and 1e200, respectively, should
;; produce ~0.09 and ~0.12, but we get the significantly larger ~0.16 and ~0.27.
;; so not quite logarithmic with the size of the input n. as a wiki solution
;; suggested, this is very likely due to operations on huge numbers taking more
;; than constant time. this makes sense since my machine uses 64-bit registers,
;; capable only of representing up to 2^64 ~= 1e19, which is much smaller than what
;; we tested above.
