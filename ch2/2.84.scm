;; idea: use numbers to represent the "height" or "level" of types in the tower.
;; this will be used to determine the relative position of the types. this works additively
;; if new types are added to the bottom or top of the tower.

;; tower: supertypes are low, subtypes are high
(put 'tower-height 'complex  (lambda (x) 4))
(put 'tower-height 'real     (lambda (x) 3))
(put 'tower-height 'rational (lambda (x) 2))
(put 'tower-height 'integer  (lambda (x) 1))
(define (lower-type? type1 type2) (< (apply-generic 'tower-height x)
                                     (apply-generic 'tower-height y)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; helpers
;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; find the max in a list of items, based on the given less-than predicate.
(define (max lt? items)
  (cond ((null? items) '())
	((= (length items) 1) (car items))
	(else
	 (let ((first (car items))
	       (max-of-rest (max lt? (cdr items))))
	   (if (lt? first max-of-rest)
	       max-of-rest
	       first)))))

;; raise all args to the same level
(define (raise-args args)
  (define (raise-to x type)
    (if (lower-type? (type-tag x) type)
        (raise-to (raise x) type)
        x))
  (let ((highest-type (max lower-type? (map type-tag args))))
    (map (lambda (x) (raise-to x highest-type)) args)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; solution
;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define (apply-generic op . args)
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
	  (apply proc (map contents args))
	  (let ((raised-args (raise-args args))) ;; same structure as 2.82
	    (if raised-args
		(apply-generic op raised-args)
		(error "No method for these types" (list op type-tags))))))))
