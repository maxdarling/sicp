(define (enumerate-tree tree)
  (cond ((null? tree) tree)
	((not (pair? tree)) (list tree))
	(else (append (enumerate-tree (car tree))
		      (enumerate-tree (cdr tree))))))



;; this was my sol. but it's forcing the use of map with enumerate-tree. i looked at solutions and I suppose
;; the approach below is intended. 
(define (count-leaves tree)
  (accumulate (lambda (leaves sum) (+ (length leaves) sum))
	      0
	      (map enumerate-tree tree)))

;; wow, kinda hard. it makes sense though!
(define (count-leaves tree)
  (accumulate + 0 (map (lambda (subtree)
			 (cond ((null? subtree) 0)
			       ((not (pair? subtree)) 1)
			       (else (count-leaves subtree))))
		       tree)))

;; oh, a much easier way, also from solutions. this is probably intended...?
(define (count-leaves tree)
  (accumulate + 0 (map (lambda (x) 1)
		       (enumerate-tree tree))))



;; the most-direct way
;; (define (count-leaves tree)
;;   (length (enumerate-tree tree)))



(count-leaves (list 1 2 (list 3 4) (list 5 6)))
