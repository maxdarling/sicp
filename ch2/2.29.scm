;; note: this problem assumes mobiles MUST have L/R branches. you can't have one or the other. and a
;; mobile with no branches is a "weight", which is distinct. therefore, roots are always mobiles, which
;; have 2 branches, and then branches can lead to either mobiles or weights.

(define (make-mobile left right)
  (list left right))

(define (make-branch length structure)
  (list length structure))

;; end of givens

;; a)
(define (left-branch mobile)
  (car mobile))

(define (right-branch mobile)
  (cadr mobile))

(define (branch-length branch)
  (car branch))

(define (branch-structure branch)
  (cadr branch))

;; b)
(define (total-weight mobile)
  ;; sum the values of the leafes
  (cond ((null? mobile) 0) ;; case: nil-mobile
	((not (pair? mobile)) mobile)  ;; case: a weight (leaf)
	(else
	 ;; total weight = total weight of the L/R branches' mobiles/weights. 
	 (+ (total-weight (branch-structure (left-branch mobile)))
	    (total-weight (branch-structure (right-branch mobile)))))))



;; c)
(define (is-balanced? mobile)
  ;; balanced = the left and right trees have equal torque, and the sub-mobiles (subtrees) are also
  ;; balanced
  (define (torque branch)
    (* (branch-length branch) (total-weight (branch-structure branch))))
  (cond ((null? mobile) #t)
	((not (pair? mobile)) #t)
	(else (and (= (torque (left-branch mobile)) (torque (right-branch mobile)))
		   (is-balanced? (branch-structure (left-branch mobile)))
		   (is-balanced? (branch-structure (right-branch mobile)))))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; testing
;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                      *
;;                   5 / \ 4
;;                   [2]  *
;;                     7 / \ 3
;;                     [1] [3]
(define x (make-mobile (make-branch 5 2)
		       (make-branch 4
				    (make-mobile (make-branch 7 1)
						 (make-branch 3 3)))))
;; a)
(left-branch x) ;; (5 2)
(left-branch (branch-structure (right-branch x))) ;; (7 1)
(branch-length (left-branch (branch-structure (right-branch x)))) ;; 7
(branch-length (right-branch (branch-structure (right-branch x)))) ;; 3

;; b)
(total-weight x) ;; 6

;; c)
;;                      *
;;                   4 / \ 2
;;                  [2]   *
;;                     9 / \ 3
;;                     [1] [3]
(define y (make-mobile (make-branch 4 2)
		       (make-branch 2
				    (make-mobile (make-branch 9 1)
						 (make-branch 3 3)))))

(is-balanced? x) ;; #f
(is-balanced? y) ;; #t

;; d)
;; changing the constructors in this way (lists to pairs) forces only a very small change: changing the
;; 2nd-elem selectors to use 'car' instead of 'cadr'. pretty easy! data abstraction on display! (we
;; didn't have to change our programs at all).
(define (make-mobile left right)
  (cons left right))

(define (make-branch length structure)
  (cons length structure))

(define (left-branch mobile)
  (car mobile))

(define (right-branch mobile)
  (cdr mobile))

(define (branch-length branch)
  (car branch))

(define (branch-structure branch)
  (cdr branch))

;; tests for d)
(define z (make-mobile (make-branch 5 2)
		       (make-branch 4
				    (make-mobile (make-branch 7 1)
						 (make-branch 3 3)))))
(left-branch z) ;; (5 2)
(left-branch (branch-structure (right-branch z))) ;; (7 1)
(branch-length (left-branch (branch-structure (right-branch z)))) ;; 7
(branch-length (right-branch (branch-structure (right-branch z)))) ;; 3
(total-weight z) ;; 6
(is-balanced? z) ;; #f
