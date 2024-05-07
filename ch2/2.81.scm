;; a)
;; it will infinite loop: the call for '(complex complex) fails the lookup, then it coerces
;; the arguments to themself, i.e. '(complex complex), and then calls the procedure again, but this
;; is exactly where we started.

;; b)
;; no, his idea is fundamentally wrong. coercing to the same type is meaningless. the true issue
;; is that we're missing an function to dispatch to given the input type. coercing on yourself
;; doesn't change this fact.

;; c)
(define (apply-generic op . args)
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
	  (apply proc (map contents args))
	  (if (= (length args) 2)
	      (let ((type1 (car type-tags))
		    (type2 (cadr type-tags))
		    (a1 (car args))
		    (a2 (cadr args)))
		(if (eq? type1 type2) ;; new
		    (error "No method for these types" (list op type-tags)) ;; new
		    (let ((t1->t2 (get-coercion type1 type2))
			  (t2->t1 (get-coercion type2 type1)))
		      (cond (t1->t2
			     (apply-generic op (t1->t2 a1) a2))
			    (t2->t1
			     (apply-generic op a1 (t2->t1 a2)))
			    (else (error "No method for these types"
					 (list op type-tags))))))
		(error "No method for these types"
		       (list op type-tags))))))))
