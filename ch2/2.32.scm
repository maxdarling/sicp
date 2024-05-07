;; my first attempt without looking at book starter-code

;; i had the idea that we can iteratively go through the list of candidates and make a binary choice
;; to either USE this element or NOT use this element. reminiscent of the change counting problem.
;; and then I wrote out a binary tree, where left branch is to not use and right branch is to use, and
;; got the same sequence as the book: (() (3) (2) (2 3) (1) (1 3) (1 2) (1 2 3)). pretty cool.
;; but it was still unclear how to formulate so I thought a bit and came up with this:
;;
;; SoS = set of subsets
;;
;; SoS(using, candidates) = SoS(using, candidates - {i_next}) U
;;                          SoS(using U {i_next}, candidates - {i_next})

;; the starting case is Sos({}, {1 2 3}), i.e. we're trying to enumerate the set of subsets
;; with choices 1 2 3 and nothing committed so far. kinda makes sense. 
;; SoS({1, 2}, {3}) will lead to {{1, 2}, {1, 2, 3}}. That's clear.
;; and SoS(using, {}) = using. That's clear too.

;; given a set (list of distinct items), generate a list of all possible subsets of s.
(define (enumerate-subsets s)
  (define (helper using candidates)
    (if (null? candidates)
	(list using)
	(append (helper using                         (cdr candidates))
		(helper (cons (car candidates) using) (cdr candidates)))))
  (helper '() s))

;; testing
(enumerate-subsets (list 1 2 3))

;; yay! works like a charm



;; recursive solution
;; thought process:
;; SoS{1, 2, 3} = SoS{2, 3} + SoS{2, 3}(with 1 appended to each elem)
;; this is the same using + not-using idea. but instead of passing forward the 1 immediately in a "using"
;; variable, you let the result of the subproblem come back, then augment it. this is more abstract.
(define (subsets s)
  (if (null? s)
      (list '())
      (let ((first-elem (car s))
	    (subsets-without-first-elem (subsets (cdr s))))
	(append subsets-without-first-elem
		(map (lambda (set) (cons first-elem set))
		     subsets-without-first-elem)))))

(subsets (list 1 2 3))


;; writing the shapes of the computations for each of these is very interesting. the
;; top is tree-recursive, and the bottom is linear recursive.

;; what a fantastic problem.
