;; rational package, modified to use generic ops, including generic reduction via 2.97
(define (install-rational-package)
  ;; internal procedures
  (define (numer x) (car x))
  (define (denom x) (cdr x))
  (define (make-rat n d)
    ;; (let ((g (gcd n d))) ;; original
    ;;   (cons (/ n g) (/ d g))))
    ;; (cons n d))
    (let ((reduced-n-d (reduce n d))) ;; 2.97
      (cons (car reduced-n-d) (cadr reduced-n-d))))
    
  (define (add-rat x y)
    (make-rat (add (mul (numer x) (denom y))
		   (mul (numer y) (denom x)))
	      (mul (denom x) (denom y))))
  (define (sub-rat x y)
    (make-rat (sub (mul (numer x) (denom y))
		   (mul (numer y) (denom x)))
	      (mul (denom x) (denom y))))
  (define (mul-rat x y)
    (make-rat (mul (numer x) (numer y))
	      (mul (denom x) (denom y))))
  (define (div-rat x y)
    (make-rat (mul (numer x) (denom y))
	      (mul (denom x) (numer y))))
  ;; interface to rest of the system
  (define (tag x) (attach-tag 'rational x))
  (put 'add '(rational rational)
       (lambda (x y) (tag (add-rat x y))))
  (put 'sub '(rational rational)
       (lambda (x y) (tag (sub-rat x y))))
  (put 'mul '(rational rational)
       (lambda (x y) (tag (mul-rat x y))))
  (put 'div '(rational rational)
       (lambda (x y) (tag (div-rat x y))))(put 'make 'rational
					       (lambda (n d) (tag (make-rat n d))))
       'done)

;; external use:
(define (make-rational n d)
  ((get 'make 'rational) n d))
