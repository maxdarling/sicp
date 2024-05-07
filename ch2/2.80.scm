(define (zero? x) (apply-generic 'zero x))

(define (install-generic-zero?)
  ;; bonus: again, using the generic zero? checker here for rational/complex to enable nesting.
  (put 'zero? 'scheme-number (lambda (x) (= x 0)))

  (put 'zero? 'rational (lambda (x) (zero? (numer x))))

  (put 'zero? 'complex (lambda (x) (zero? (magnitude x)))))

