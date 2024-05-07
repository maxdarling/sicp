(define (equ? x y) (apply-generic 'equ? x y))


(define (install-generic-equ?)
  ;; bonus: using generic 'equ?' instead of '=' for the rational and complex functions is 
  ;; best, since it allows nesting, e.g. a rational number with complex numerator. 

  ;; ordinary numbers
  (put 'equ? '(scheme-number scheme-number) =)
  ;; rational numbers
  (put 'equ? '(rational rational) (lambda (x y) (and (equ? (numer x) (numer y))
						     (equ? (denom x) (denom y)))))
  ;; complex numbers
  (put 'equ? '(complex complex) (lambda (x y) (and (equ? (real-part x) (real-part y))
						   (equ? (imag-part x) (imag-part y))))))
  
