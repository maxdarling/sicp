;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; external procedures
;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; term procedures with representations abstracted. choices: 'dense or 'sparse.

;; constructors: explicitly choose dense
(define (make-term order coeff)
  ((get 'make-term 'dense) order coeff))
(define (the-empty-termlist)
  ((get 'the-empty-termlist 'dense)))

;; non-constructors: can be generic procedures, since we tagged all terms and term-lists
(define (adjoin-term term term-list)
  (apply-generic 'adjoin term term term-list))
(define (first-term term-list)
  (apply-generic 'first-term term-list))
(define (rest-terms term-list)
  (apply-generic 'rest-terms term-list))
(define (empty-termlist? term-list)
  (apply-generic 'empty-termlist? term-list))
(define (order term)
  (apply-generic 'order term))
(define (coeff term)
  (apply-generic 'coeff term))

;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Dense package
;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define (instal-dense-term-package)
  ;; (copied from 2.89)
  (define (adjoin-term term term-list)
    (cond ((=zero? (coeff term)) term-list)
          ((= (order term) (length term-list)) (cons (coeff term) term-list))
          (else (adjoin-term term (cons 0 term-list)))))

  (define (first-term term-list)
    (make-term (- (length term-list) 1) (car term-list)))

  (define (rest-terms term-list)
    (define (trim-leading-zeroes l)
      (cond ((null? l) '())
	    ((not (= 0 (car l))) l)
	    (else (trim-leading-zeroes (cdr l)))))
    (trim-leading-zeroes (cdr term-list)))

  (define (the-empty-termlist) '())
  (define (empty-termlist? term-list) (null? term-list))
  (define (make-term order coeff) (list order coeff))
  (define (order term) (car term))
  (define (coeff term) (cadr term))

  (define (tag x) (attach-tag 'dense))
  ;; tag everything that is dense-specific (i.e. terms and term-list return types)
  (put 'adjoin-term '(dense dense) (lambda (x y) (tag (adjoin-term x y))))
  (put 'the-empty-termlist '(dense) (lambda () (tag (the-empty-termlist))))
  (put 'first-term '(dense) (lambda (x) (tag (first-term x))))
  (put 'rest-terms '(dense) (lambda (x) (tag (rest-terms x))))
  (put 'empty-termlist? '(dense) (lambda (x) (tag (empty-termlist? x))))
  (put 'make-term '(dense dense) (lambda (x y) (tag (make-term x y))))
  (put 'order '(dense) order) ;; no tag needed
  (put 'coeff '(dense) coeff) ;; no tag needed
  'done)


;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Sparse package
;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define (install-sparse-term-package)
  ;; note: only difference with dense is the first 3 procedures.
  (define (adjoin-term term term-list) 
    (if (=zero? (coeff term)) 
        term-list  
        (cons (term term-list))))

  (define (first-term term-list) (car term-list)) 
  (define (rest-terms term-list) (cdr term-list)) 

  (define (the-empty-termlist) '())
  (define (empty-termlist? term-list) (null? term-list))
  (define (make-term order coeff) (list order coeff))
  (define (order term) (car term))
  (define (coeff term) (cadr term))

  (define (tag x) (attach-tag 'sparse))
  (put 'adjoin-term '(sparse sparse) (lambda (x y) (tag (adjoin-term x y))))
  (put 'the-empty-termlist '(sparse) (lambda () (tag (the-empty-termlist))))
  (put 'first-term '(sparse) (lambda (x) (tag (first-term x))))
  (put 'rest-terms '(sparse) (lambda (x) (tag (rest-terms x))))
  (put 'empty-termlist? '(sparse) (lambda (x) (tag (empty-termlist? x))))
  (put 'make-term '(sparse sparse) (lambda (x y) (tag (make-term x y))))
  (put 'order '(sparse) order)
  (put 'coeff '(sparse) coeff)
  'done)
)

;; post-solution notes:
;; - some noticed that all the procedures on terms use the same representation and implementation
;; in both dense and sparse (terms as a list of (coeff order)). so they made a geneirc 'term type
;; for all the term procedures, and 'dense and 'sparse only classify term lists. this is fine,
;; but I want true abstraction and option for these to change in future, so I don't do this.
;; - the complex number example in the book made smart choices about when to use which
;; representation. making a complex number from real and imaginary parts is more effecient
;; to construct using the rectanuglar representation, and vice-versa with magnitude+angle and
;; polar. can we do that in this case? I don't think so... we are representing term lists, which
;; can only be formed by successive calls to adjoin-term. I suppose when going from a len 1 to 2
;; term list, you can check the term to be adjoined. if it's within some order threshhold, e.g. 3,
;; you can use dense, otherwise use sparse. it's a pretty loose heuristic, but the best we can do?
;; - ADDENDUM: actually, I kinda change my mind about the generic term type. I just looked at
;; add-term and realized that with a generic term you can add term lists of different types
;; (since it's just a looping over list A and adjoining terms into list B). if you desired
;; different term lists being used simultaneously in your system, you'd need this.
