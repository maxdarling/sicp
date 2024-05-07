;; (sadly i'm going to skip this one. i'll jot some thoughts down. but it's hard and I want to
;; keep speeding ahead.)


;; problem: modify make-poly so that (make-poly 'x terms) ensures that the poly is rearranged
;; in canonical form
;; e.g. given that variable y is canonically "higher" than x, the polynomial
;;     yx^2 + x + 1     -- representation: ('x (y 1 1))
;; would become 
;;     (x^2)y + (x + 1) -- representation: ('y (x^2 x+1))
;;
;; converting to canonical form like this makes easy to, say, add mixed polynomials like the above
;; to y^3 + zy, for example.



;; strategy: update make-poly to force the input to canonical form
;; steps (assuming some poly in variable x):
;;
;; 1. recursively find the max canonical polynomial variable in all terms. i.e.
;; max-var-rec(poly) =
;;   max-canonical-var(max-var-rec(poly.firstTerm.coeff), max-var-rec(poly.restTerms))
;;
;; where base case is if poly.firstTerm.coeff is not a poly, then return poly.var. i.e.
;; the max canonical var of a non-recursive poly is just the original var.
;;
;; note: max-canonical-var can simply work by comparing the string value of the variable symbols
;; using the function symbol->string and comparator string<?
;;
;; 2. rearrange/extract each term with new highest var 'y. each term will produce a new poly in
;; terms of 'y. to finish, combine each of these polys (via add-poly will work).

;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; code
;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define (max-canonical-var v1 v2)
  (if (string<? (symbol->string v1) (symbol->string v2))
      v2
      v1))

;; step 1
(define (max-canonical-var-in-poly poly)
  (if (empty-termlist? poly)
      (variable poly)
      (let ((first (first-term (term-list poly)))
	    (rest (rest-terms (term-list poly))))
	(if (not (= (type-tag (coeff first-term)) 'polynomial)) ;; doesn't handle nesting, see below
	    (variable poly)
	    ;; recursive-case
	    (max-canonical-var
	     (max-canonical-var-in-poly (make-poly (variable poly)
						   (make-term (order first-term) (coeff first-term))))
	     (max-canonical-var-in-poly (make-poly (variable-poly)
						   (rest-terms))))))))

;; I now realize this is hard. what if 'y > 'x and you have a term:
;;    (2*(y + i) / 10) * x
;; the y is nested inside a complex number inside a rational! essentially, if you have a
;; nested type you have to search in each of its components (real part, imag part, numer,
;; denom, etc). you can only stop on non-nested types that are not polys, e.g. 'scheme-number
;; but how to do this generically? because we want to do it generically rather than add
;; case-handling for each type - that will be too hard to maintain. so, we could imagine
;; a 'components' procedure that returns a list of the component parts of a nested type.
;; a bit odd? maybe not. it would solve this immediate issue at least.

;; step 2
(define (rearrange-single-term-poly poly new-var)
  ;; returns the poly resulting from rearranging a single-term polynomial in terms of a new var
  ;; example: (y^2 + y + 2 + z)x -> xy^2 + xy + (2x + xz)
  ;; - note: this has same issue with nesting as above.

  ;; base case 1: nil -> error, empty poly -> empty poly
  ;; base case 2: poly's var == new-var -> poly
  ;; recursive case: return new poly with current poly term multiplied by each term of new poly
  ;; - note: using poly-mul would be cyclical. instead, we use poly-make on each term. e.g.
  ;; if we have the above poly in terms of y and the var x, each of y's terms becomes a poly
  ;; of x with the term as the coeff.
  )
  



;; note: I just realized that changing make-poly is not enough. my example at the top
;; worked when adding a mixed poly in x+y to a poly in y. but how to get the x+y poly in the
;; first place? i.e. right now I can't add a poly in x to one in y. but this is core.
;;
;; I think you would want the canonicalization in make-poly (what I have above), as well as
;; a small bit of logic for different-poly operations (like x + y) to choose the higher var to base
;; the poly on, and then add the lower var poly as a scalar (e.g. mul each term for mul, or add
;; to zero'th power term for addition).

;; another thing I'm worried about is buried polynomials. e.g. (2 * (2 / y) / 4) * y^2, which
;; is a y term with a coeff of a rational whose numer is a rational with y in its denom. I am
;; worried that things will break if you don't extract out the nested y term. So perhaps
;; the only change is to rearrange-single-term-poly: don't early exit when you find the new-var,
;; but search the entire expression tree for all y terms. so you can combine them.
;; (there's also the added complexity of dealing with rational polynomials, but I think that's
;; addressed in the next section)

;; I'm packing up here. fun to spend a couple hours thinking about it! I got what I came for.
  
