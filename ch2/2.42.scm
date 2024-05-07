;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; givens/helpers
;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (enumerate-interval lo hi)
  (if (> lo hi)
      '()
      (cons lo (enumerate-interval (+ 1 lo) hi))))

;; helper. get kth elem (1-indexed) in the sequence, or '() if it doesn't exist.
(define (get-elem k sequence)
  (cond ((null? sequence) '())
	((= k 1) (car sequence))
	(else (get-elem (- k 1) (cdr sequence)))))

;; helper. set kth elem (1-indexed) in the sequence to newval.
(define (set-elem k newval sequence)
  (if (= k 1)
      (cons newval (cdr sequence))
      (cons (car sequence) (set-elem (- k 1) newval (cdr sequence)))))

;; helper. return index (1-indexed) of first occurrence of elem in sequence
(define (find-elem elem sequence)
  (define (iter i sequence)
    (cond ((null? sequence) (- 1))
	  ((= elem (car sequence)) i)
	  (else (iter (+ i 1) (cdr sequence)))))
  (iter 1 sequence))

;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Problem
;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (queens board-size)
  ;; terms:
  ;; - board: a list of columns. (note: # of cols can vary, but # of rows doesn't)
  ;; - column: a list whose elements indicate a vacant square (0) or a queen (1) for each row.
  ;; - empty board: a board with no columns.
  ;; - position: a board. (authors use "positions" to refer to same thing. I have made it singular below.)

  (define empty-board '())

  ;; determine whether the queen in the kth column of the position is safe from checks.
  (define (safe? k position)
    (define (queens-to-left? row col)
      (cond ((< col 1) #f)
	    ((= 1 (get-elem row (get-elem col position))) #t)
	    (else (queens-to-left? row (- col 1)))))

    (define (queens-on-up-left-diag? row col)
      (cond ((or (< row 1) (< col 1)) #f)
	    ((= 1 (get-elem row (get-elem col position))) #t)
	    (else (queens-on-up-left-diag? (- row 1) (- col 1)))))

    (define (queens-on-down-left-diag? row col)
      (cond ((or (> row board-size) (< col 1)) #f)
	    ((= 1 (get-elem row (get-elem col position))) #t)
	    (else (queens-on-down-left-diag? (+ row 1) (- col 1)))))

    (let ((col k)
	  (row (find-elem 1 (get-elem k position))))
      (and (not (queens-to-left? row (- col 1)))
	   (not (queens-on-up-left-diag? (- row 1) (- col 1)))
	   (not (queens-on-down-left-diag? (+ row 1) (- col 1))))))


  ;; given a position, insert a kth column with a queen on row 'new-row'
  (define (adjoin-position new-row k position)
    ;; assumption: k is always the last column. too lazy to splice it in.
    (append position
	    (list (set-elem new-row
			    1
			    (map (lambda (x) 0) (enumerate-interval 1 board-size))))))
  
  (define (queen-cols k)
    (if (= k 0)
	(list empty-board)
	(filter
	 (lambda (position) (safe? k position))
	 (flatmap
	  (lambda (rest-of-queens)
	    (map (lambda (new-row)
		   (adjoin-position
		    new-row k rest-of-queens))
		 (enumerate-interval 1 board-size)))
	  (queen-cols (- k 1))))))
  (queen-cols board-size))


;; testing. works!
(queens 4)
(length (queens 8)) ;; -> 92




;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Note: alternative approach
;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; above I did totally the wrong approach. I assumed we wanted to generate all possible positions, meaning
;; "boards", meaning NxN matrices of piece configurations. Oh well. I still got it to work. But looking at
;; the solutions, it seems the authors were driving at positions meaning just the coordinates of the n
;; queens, or even just a list of row positions where the column is implied from the position in the
;; sequence. interesting.
;;
;; I'm too lazy to reimplement this. Moving on...
