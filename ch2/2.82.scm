(define (none predicate elems)
  (null? (filter predicate elems)))

;; attempt to coerce all args to the same type, or nil if not possible.
;; uses a naive algorithm (try to coerce all args to type of the first arg, then second, etc.)
(define (coerce-args args)
  (define (iter type-tags)
    (if (null? type-tags)
	'()
	(let* ((target-type (car type-tags))
	       (coercions (map (lambda (type)
				 (if (eq? type target-type)
				     (lambda (x) x)
				     (get-coercion type target-type)))
			       type-tags)))
	  ;; did we find a coercion for all args?
	  (if (none null? coercions)
	      (map (lambda (coerce arg) (coerce arg)) coercions args)
	      (iter (cdr type-tags))))))
  (iter (map type-tag args)))

(define (apply-generic op . args)
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
	  (apply proc (map contents args))
	  (let ((coerced-args (coerce-args args)))
	    (if coerced-args
		(apply-generic op coerced-args)
		(error "No method for these types" (list op type-tags))))))))


;; Additional question:
;; "Give an example of a situation where this strategy (and likewise the two-argument version
;; given above) is not sufficiently general. (Hint: Consider the case where there are some
;; suitable mixed-type operations present in the table that will not be tried.)

;; Answer:
;; (I had to look at solution for this, I couldn't come up with one).

;; Imagine the following. You have types:
;;
;;        C         (subtype)
;;       / \
;;      A   B       (supertypes)

;; and a function defined for A C C. You can coerce upwards but not downwards, as usual.

;; if we have arguments A B C, our algorithm will try A B C and then CCC via coercion, and then
;; fail. However, simply coercing the second argument B->C works!
