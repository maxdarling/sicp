(define (poly-zero? x)
  (define (all-coeffs-zero? terms)
    (cond ((null? terms) #t)
	  ((not (zero? (coeff (first-term terms)))) #f)
	  (else (all-coeffs-zero? (rest-terms terms)))))
  (all-coeffs-zero? (term-list x)))

(put 'zero 'polynomial poly-zero?)




;; post-solution update:
;; the chosen representation of term lists doesn't allow zero coeff terms (see adjoin-term), so
;; you can get away with:
 (define (zero-poly? p) 
    (empty-termlist? (term-list p))) 
;; however, a zero coeff term can sneak in there via the constructor, no?


;; also, one answer used 'or' to simplify my cond above. it works here since we're dealing with
;; boolean return type. very nice.
