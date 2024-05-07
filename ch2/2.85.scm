(load "2.79.scm") ;; for equ?
(load "2.84.scm") ;; for raise-args

(define (install-project)
  (put 'project 'complex (lambda (x) (make-real (real-part x)))) ;; is there a 'make-real'?
  (put 'project 'real (lambda (x) (make-rat (round x) 1)))
  (put 'project 'rational (lambda (x) (make-scheme-number (round (/ (numer x) (denom x)))))))

(define (project x) (apply-generic 'project x))

;; maximally drop x. i.e. the complex 1 + 0i becomes the integer 1, and 1 + 2i stays complex.
(define (drop x)
  (if (equ? x (raise (project x)))
      (drop (project x))
      x))

;; simple rewrite to apply-generic. must avoid infinite loops by not attempting to 'drop' during
;; a 'raise' or 'project'.
(define (apply-generic op . args)
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
	  (let ((res (apply proc (map contents args)))) ;; new. 
            (if (or (eq? op 'raise) (eq? op 'project)) res (drop res))) ;; new
	  (let ((raised-args (raise-args args)))
	    (if raised-args
		(apply-generic op raised-args)
		(error "No method for these types" (list op type-tags))))))))
