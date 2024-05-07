(load "2.67.scm")

;; given
(define (encode message tree)
  (if (null? message)
      '()
      (append (encode-symbol (car message) tree)
	      (encode (cdr message) tree))))

;; return the encoding for a symbol according to a given huffman tree. 
;; returns error if the symbol is not in the tree.
;; tree must be non-nil.
(define (encode-symbol symbol tree)
  (define (enc-symbol symbol tree)
    (cond ((not (memq symbol (symbols tree))) 'dead-end)
	  ((leaf? tree) '()) ;; nil is correct. think of the 2-symbol tree case.
	  (else
	   ;; recursive case: try encoding via both right and left branches (only one contains symbol)
	   (let ((left-encoding (enc-symbol symbol (left-branch tree)))
		 (right-encoding (enc-symbol symbol (right-branch tree))))
	     (cond ((not (eq? left-encoding 'dead-end)) (cons 0 left-encoding))
		   ((not (eq? right-encoding 'dead-end)) (cons 1 right-encoding))
		   (else (error "tree does not contain symbol" symbol)))))))

  (if (null? tree)
      (error "tree must be non-nil")
      (let ((result (enc-symbol symbol tree)))
	(if (eq? result 'dead-end)
	    (error "tree does not contain symbol" symbol)
	    result))))



;; testing (using 2.67 tree and message)
(define message '(a d a b b c a))
(equal? sample-message (encode message sample-tree)) ;; -> #t

;; post-solution notes:
;; - yes, the solutions are a bit cleaner. but, interestingly, it's because I decided I didn't want to
;; "arms-length" recursion by checking each child of the current node, i.e. searching their sets. but on
;; closer inspection that's dumb - you can't really get around doing that. I forced myself to recurse
;; on both sides and then compare/join the results. but in order to support that you have to introduce a
;; "dead-end" indicator value (since nil is taken). which is extra complexity!!
;; - usually avoiding "arms-length" is good on principle, but in this case it just doesn't work / make sense.
;; my favorite solution below. super simple:

(define (encode-symbol char tree) 
  (cond ((leaf? tree) '()) 
        ((memq char (symbols (left-branch tree))) 
         (cons 0 (encode-symbol char (left-branch tree)))) 
        ((memq char (symbols (right-branch tree))) 
         (cons 1 (encode-symbol char (right-branch tree)))) 
        (else (error "symbol not in tree" char)))) 
