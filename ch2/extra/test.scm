(define (the-empty-termlist) '())
(define (rest-terms term-list) (cdr term-list))
(define (empty-termlist? term-list) (null? term-list))
(define (make-term order coeff) (list order coeff))
(define (order term) (car term))
(define (coeff term) (cadr term))
(define (first-term term-list) 
  (make-term (- (length term-list) 1) (car term-list))) 

(define (adjoin-term term term-list) 
  (cond ((=zero? (coeff term)) term-list) 
        ((= (order term) (length term-list)) (cons (coeff term) term-list)) 
        (else (adjoin-term term (cons 0 term-list))))) 



;; (first-term (rest-terms '((3 1) (1 1))))
(first-term (rest-terms '(1 0 1 0)))
