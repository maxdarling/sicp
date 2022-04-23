;; compute b^n iteratively

;; strategy: SICP requires a bottom-up iterative alg using successive squaring.
;; with successive squaring from b^0, each iter gives a perfect square
;; exponent. We can use these to build up to b^n. How? Using the binary
;; representation of n. E.g. for 3^5, we know 5 = 2^2 + 2^0 = 4 + 1. 
;; Thus 3^5 = 3^4 * 3^1. In this way, any b^n can be constructed up as
;; the product of all b^2^i for each binary digit i of n. This is easy to
;; implement iteratively + bottom-up by maintaining b^2^i at each iteration.
(define (exp-iter b n)
  (define (integer-div numerator denominator)
    (/ (- numerator (remainder numerator denominator)) denominator))
  (define (exp-iter-impl b n b_exp result)
    (cond ((= n 0) result)
	  (else (exp-iter-impl b
			       (integer-div n 2) ;; >> 1
			       (square b_exp)
			       (if (even? n) result (* b_exp result))))))
  (exp-iter-impl b n b 1))


;; the above solution is bottom-up. it actually doesn't have to be. I misunderstood
;; their usage of "iterative".

;; you can use a top-down approach with the rules:
;; b ^ n = b ^ 2 ^ (n / 2) if n is even
;; b ^ n = b * b ^ (n - 1) if n is odd

;; to solve, iteratively do one of the above based on parity of n.
;; if n is even, you're simply changing params b and n accordingly.
;; if n is odd, you need a separate counter to store the single powers of b.
;; at the end, you multiply the counter times b (n will be 0) and you're done!

;; note: the book formalizes this with an invariant where ab^n = b^n at each step,
;; and a = 1 to start. you pump the odd powers into a and powers of 2 into b.  


