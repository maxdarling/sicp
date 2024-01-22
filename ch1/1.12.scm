;; calculate a specific (row, idx) of the pascal triangle
;;   row 1:    1
;;   row 2:   1 1
;;   row 3:  1 2 1
;;   row 4: 1 3 3 1
;;
;; 1-indexed. e.g. (pascal-cord 3 2) -> 2
(define (pascal-cord row col)
  (cond ((or (< col 0) (> col row)) 0)
	((or (= row 1) (= col 1) (= row col)) 1)
	(else (+ (pascal-cord (- row 1) (- col 1))
		 (pascal-cord (- row 1) col)))))


;; BONUS: calculate rows of pascals triangle
;;   row 1:    1
;;   row 2:   1 1
;;   row 3:  1 2 1
;;   row 4: 1 3 3 1
;;   ..............
  
(define (pascal n)
  (if (= n 1)
      1
      (new-row (pascal (- n 1)))))


;; take a row of pascal and generate the next row
;; e.g.
;;  1 3 3 1
;; 1 4 6 4 1 
;;
;; true picture:
;; 0 1 3 3 1 0
;;  1 4 6 4 1
;;
;; "true picture" algorithm for r -> r': 
;; 0. start: r' = 0
;; 1. select rightmost pair of r. logical sum them.
;; 2. add 1. to "left" of r'
;; 3. select next pair from r
;; 5. repeat until no more pairs in r
;;
;; DISCLAIMER: only works for single-digits! (lol. since I'm operating on integers
;; and relying on modulo to pull off single digits. with a list it's generalizable,
;; but list has not been introduced yet).
(define (new-row r)
  (define (new-row-iter r rp l1 l2 s) ;; pair is (l1, l2). s is for r' "left" adds.
    (if (= r 0)
	(+ rp (* s 1))
	(new-row-iter (quotient r 10) ;; right-shift by 1
		      (+ rp (* s (+ l1 l2))) ;; left-add logical sum of pairs
		      (remainder(quotient r 10) x)
		      (remainder r 10)
		      (* s 10))))
  (new-row-iter r 0 1 0 1))
