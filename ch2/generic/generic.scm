;; ~all stuff needed for generic ops. using this specifically for testing 2.93 - 2.97

;; variable (pg. 200. needed by poly operations.)
(define (variable? x) (symbol? x))
(define (same-variable? v1 v2)
  (and (variable? v1) (variable? v2) (eq? v1 v2)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; type tags (ex 2.78 versions)
;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define (attach-tag type-tag contents)
  (if (number? contents)
      ;; nums don't get tagged
      contents
      (cons type-tag contents)))

(define (type-tag datum)
  (cond ((number? datum) 'scheme-number)
	((pair? datum) (car datum))
	(else (error "Bad tagged data..." datum))))

(define (contents datum)
  (cond ((number? datum) datum)
	((pair? datum) (cdr datum))
	(else (error "Bad tagged data..." datum))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; put/get
;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; source: https://stackoverflow.com/questions/5499005/how-do-i-get-the-functions-put-and-get-in-sicp-scheme-exercise-2-78-and-on
(define global-array '())

(define (make-entry k v) (list k v))
(define (key entry) (car entry))
(define (value entry) (cadr entry))

(define (put op type item)
  (define (put-helper k array)
    (cond ((null? array) (list(make-entry k item)))
          ((equal? (key (car array)) k) array)
          (else (cons (car array) (put-helper k (cdr array))))))
  (set! global-array (put-helper (list op type) global-array)))

(define (get op type)
  (define (get-helper k array)
    (cond ((null? array) #f)
          ((equal? (key (car array)) k) (value (car array)))
          (else (get-helper k (cdr array)))))
  (get-helper (list op type) global-array))

;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; apply-generic (page 247, vanilla (no coercion...?))
;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define (apply-generic op . args)
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
	  (apply proc (map contents args))
	  (error
	   "No method for these types: APPLY-GENERIC"
	   (list op type-tags))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; arithmetic
;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define (add x y) (apply-generic 'add x y))
(define (sub x y) (apply-generic 'sub x y))
(define (mul x y) (apply-generic 'mul x y))
(define (div x y) (apply-generic 'div x y))
(define (equ? x y) (apply-generic 'equ? x y)) ;; ?
(define (=zero? x) (apply-generic '=zero? x)) ;; ex. 2.80
(define (negate x) (apply-generic 'negate x)) ;; ex. 2.88
(define (greatest-common-divisor a b) (apply-generic 'greatest-common-divisor a b)) ;; 2.94
(define (reduce x y) (apply-generic 'reduce x y)) ;; 2.97

;; types of numbers:
;; - 'scheme-number
;; - 'rational
;; - 'real
;; - 'complex
;; - 'polynomial -- bonus

;; I'll install scheme numbers here as a default. other numbers will have their own files.
;; (note: scheme numbers need not be tagged, see tagging procedures above) 
(put 'add '(scheme-number scheme-number) +) 
(put 'mul '(scheme-number scheme-number) *) 
(put 'div '(scheme-number scheme-number) /) 
(put 'equ? '(scheme-number scheme-number) =) 
(put '=zero? '(scheme-number) (lambda (x) (= x 0)))
(put 'negate '(scheme-number) -) 
(put 'greatest-common-divisor '(scheme-number scheme-number) gcd)
(put 'reduce '(scheme-number scheme-number) (lambda (n d)
					      (let ((g (gcd n d)))
						(list (/ n g) (/ d g)))))
