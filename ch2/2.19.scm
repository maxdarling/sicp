(define us-coins (list 50 25 10 5 1))
(define uk-coins (list 100 50 20 10 5 2 1 0.5))

;; count # of ways to make change for some amount given a list of coin values
(define (cc amount coins)
  ;; base case: there are 0 ways to make change for a negative amount or with no coins
  (if (or (<= amount 0) (null? coins))
      0
      (let ((curr-coin (car coins)))
	(if (= amount curr-coin)
	    1
	    (+
	     (cc (- amount curr-coin) coins) ;; # of ways to make change using this coin
	     (cc amount (cdr coins)))))))    ;; # of ways to make change NOT using this coin


;; testing
(cc 13 us-coins) ;; 4 = 10 + 1x3 | 5 + 5 + 1x3 | 5 + 1x8 | 1x13
(cc (- 5) us-coins) ;; 0
(cc (- 5) '()) ;; 0


;; BOOK METHOD:
(define no-more? null?)
(define except-first-denomination cdr)
(define first-denomination car)

(define (cc amount coin-values)
  (cond ((= amount 0) 1)
	((or (< amount 0) (no-more? coin-values)) 0)
	(else
	 (+ (cc amount
		(except-first-denomination
		 coin-values))
	    (cc (- amount
		   (first-denomination
		    coin-values))
		coin-values)))))

;; testing
(cc 9 us-coins) ;; 2 = 5 + 1x4 | 1x9


;; the order of the coin values list does not affect the result.
;; reason:
;; the # of ways to make change for some amount X with some items I is equal
;; to the subproblem on amount X - e and items I plus the subproblem on amount X and items I - {e}.
;; i.e., the total # of solutions = the solutions that use 'e' and those that don't. the choice of
;; element 'e' is arbitrary, though, so order doesn't matter.
