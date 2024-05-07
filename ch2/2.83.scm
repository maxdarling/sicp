(define (raise x) (apply-generic 'raise x))

(define (install-raisers-for-integer-tower)
  (define (integer->rational x) (make-rat x 1))
  (define (rational->real x) (* 1.0 (/ (numer x) (denom x))))
  (define (real->complex x) (make-complex-real-imag x 0))

  (put 'raise '(integer) integer->rational)
  (put 'raise '(rational) rational->real)
  (put 'raise '(real) real->complex))
  
