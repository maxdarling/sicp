(load "2.28.scm")
(load "2.36.scm")
;; given
(define (dot-product v w)
  (accumulate + 0 (map * v w)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; problems
;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (matrix-*-vector m v)
  (map (lambda (row) (dot-product row v))
       m))


;; first attempt, no book look.
(define (transpose m)
  ;; strategy: first row becomes first column <-> first column becomes first row
  (if (null? (car m))
      '()
      (cons (map car m)
	    (transpose (map cdr m)))))

;; using book acc-n template. noice. should be the mental go-to for columnar operations.
(define (transpose m)
  (accumulate-n cons '() m))
  
(define (matrix-*-matrix m n)
  ;; strategy: use matrix-*-vector on m and each column of n

  ;; below was first attept, wrong. had to do it on paper.
  ;; this given a list of column vectors, should be a list of rows.
  ;; (map (lambda (col) (matrix-*-vector m col))
  ;;      (transpose n)))

  ;; we need a list of row vectors, which is kinda backwards. usually for matmul AB
  ;; = C you get the column vectors of C by doing A * col-of-b. But here we need the
  ;; row vectors of C. Well, that's just C^T, which is (AB)^T = B^TA^T. haha. I was
  ;; googling this a bit, it's been a while.
  ;; So, we need N^TM^T.
  ;; So lets map over rows of m like the solution says which is equivalent to the columns of M^T. and we
  ;; are doing matrix-*-vector on N^T and M^T columns. perfect.
  ;; what a nice little learing!
 (let ((N^T (transpose n)))
   (map (lambda (v) (matrix-*-vector N^T v))
	m)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; testing
;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 1 2 3 4
;; 4 5 6 6
;; 6 7 8 9
(define m (list (list 1 2 3 4)
		(list 4 5 6 6)
		(list 6 7 8 9)))

(matrix-*-vector m (list 1 1 1 2)) ;; -> (14 27 39)


(transpose m)


(matrix-*-matrix (list (list 1 2)
		       (list 3 4))
		 (list (list 1 1)
		       (list 1 2)))

(matrix-*-matrix (list (list 1 2 3)
		       (list 4 5 6))
		 (list (list 1 2)
		       (list 1 2)
		       (list 1 2)))
