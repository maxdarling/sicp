;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Helpers
;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define (enumerate-tree tree)
  (cond ((null? tree) tree)
	((not (pair? tree)) (list tree))
	(else (append (enumerate-tree (car tree))
		      (enumerate-tree (cdr tree))))))

(define (zip seq1 seq2)
  (cond ((null? seq2) seq1)
	((null? seq1) seq2)
	(else (cons (list (car seq1) (car seq2))
		    (zip (cdr seq1) (cdr seq2))))))

(zip (list 1 2 3) (list 4 5 6)) ;; -> ((1 4) (2 5) (3 6))

(define (zip-n seqs)
  (let ((nested-pairs (accumulate zip '() seqs)))
    ;; flatten
    (map enumerate-tree nested-pairs)))

(zip-n (list (list 1  2  3)
	     (list 4  5  6)
	     (list 7  8  9)
	     (list 10 11 12))) ;; -> ((1 4 7 10) (2 5 8 11) (3 6 9 12))

;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Problem
;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; "column" approach: if we zip up all the first elements, second elements, etc. into their
;; own lists, or "columns", the problem becomes very easy: we can run an accumulate on each column.
(define (accumulate-n op init seqs)
  (map (lambda (column) (accumulate op init column))
       (zip-n seqs)))


;; "row" approach: take the recursive leap of faith to end up with : ((1 2 3) (x y z))
;; we want ((op 1 x) (op 2 y) (op 3 z))
(define (accumulate-n op init seqs)
  ;; same problem, but with a "list-wise" init value.
  (define (recursive-acc-n op init seqs)
    (if (null? seqs)
	init ;; e.g. (0 0 0)
	;; e.g. (
	(map (lambda (pair) (op (car pair) (cadr pair)))
	     (zip (car seqs) 
		  (recursive-acc-n op init (cdr seqs))))))
  (if (null? seqs)
      '()
      (recursive-acc-n op
		       (map (lambda (x) init) (car seqs)) ;; "list-wise" init value
		       seqs)))


;; book starter-code approach (I did the above without looking at it). I did initally have the idea of
;; recursing on "first-column":"rest-of-columns" but I went for the direct columnar map
;; approach in the end because implementing zip-f seemed fun.
;;
;; but damn that's really nice and clean...!!!
(define (accumulate-n op init seqs)
  (if (null? (car seqs))
      '()
      (cons (accumulate op init (map car seqs))
	    (accumulate-n op init (map cdr seqs)))))




;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Testing
;;;;;;;;;;;;;;;;;;;;;;;;;;;
(accumulate-n + 0 (list (list 1  2  3)
			(list 4  5  6)
			(list 7  8  9)
			(list 10 11 12))) ;; -> (22 26 30)

;; alt. version of zip-n based on insight from the solution. not bad.
(define (zip-n seqs)
  (if (null? (car seqs))
      '()
      (cons (map car seqs)
	    (zip-n (map cdr seqs)))))
