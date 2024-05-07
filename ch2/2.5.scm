(define (cons a b)
  (* (expt 2 a)
     (expt 3 b)))

(define (car z)
  (if (not (= 0 (remainder z 2)))
      0
      (+ 1 (car (/ z 2)))))

(define (cdr z)
  (if (not (= 0 (remainder z 3)))
      0
      (+ 1 (cdr (/ z 3)))))


(car (cons 5 3))
(cdr (cons 5 7))


;; smarter way (from solutions)
(define (logb b n) (floor (/ (log n) (log b)))) 
;; Selectors 
(define (car x) (logb 2 (/ x (gcd x (expt 3 (logb 3 x)))))) 
(define (cdr x) (logb 3 (/ x (gcd x (expt 2(logb 2 x)))))) 

;; explanation: 
(define (car x)
  (logb 2
	(/ x
	   (gcd x
		(expt 3 (logb 3 x)))))) 

;; - given: x = (2^a)(3^b)
;; - find the biggest power of 3 that fits in x (expt 3 (logb 3 x))
;; - get the gcd of x and that. this will give you the largest power of 3 that
;;   is a factor of x (this is the crux!). ;; - divide x by that power of 3. based on x's factorization, we know it's just
;;   '2^a' left. so simply use logb2.

;; the crux makes sense because the gcd of any x
;; and some y = 3^b is going to be some 3^c. I.e. gcd of a number and a power
;; of some number will be (assuming divisible) a smaller power of the 2nd
;; number, since the 2nd number is only made up of those bases. It follows that any
;; 3^b > x would work for the gcd step, too. But it's risky if too small, e.g. if
;; x = (2^a)(3^b) and y = 3^c where c < b. Then (gcd x y) = y.

