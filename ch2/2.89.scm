;; idea: represent terms as a list of coefficients for all orders, from highest order to lowest
;; e.g. x^3 + 2x + 5 => (1 0 2 5)

;;
;; invariant: first term of a term-list is non-zero
;;

;; (assumes term is higher order than any in term list - see footnote 59)
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

;; post-solution note:
;; - I assumed the invariant in order to achieve parity with the sparse code. Nobody else did.
;; I'm a beast! See wiki for my writeup.
