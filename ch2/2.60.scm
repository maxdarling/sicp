;; representation of sets using unordered lists with *duplicate elements* permitted
;; e.g. {1, 2, 3} could be  (2 3 2 1 3 2 2)

(define (element-of-set? x set)
  (cond ((null? set) #f)
	((equal? x (car set)) #t)
	(else (element-of-set? x (cdr set)))))

;; easy
(define (adjoin-set x set)
  (cons x set))

(define (intersection-set set1 set2)
  (filter (lambda (x) (element-of-set? x set2))
	  set1))

;; easy
(define (union-set set1 set2)
  (append set1 set2))
  
  
	 
;; testing
(element-of-set? 1 '(2 2 3 4 5 1 5 0 3))
(element-of-set? 1 '(2 2 3 4 5 5 0 3))
(equal? '(1 1 2 3 4 5) (adjoin-set 1 '(1 2 3 4 5)))
(equal? '(3 4) (intersection-set '(1 2 3 4 5) '(0 3 4 3 99 0)))
(equal? '(1 1 1 2 3 4) (union-set '(1 1) '(1 2 3 4)))



;; analysis: compare duplicate vs. non-duplicate representations
;;
;; - let m be the # of total elements (dupes included) and n the # of unique elements in the set.
;; - intersection and element-of-set? are now O(m^2) and O(m) instead of O(n^2) and O(n), respectively.
;; - duplicate adjoin is O(1) vs. O(n) because it skips the membership check.
;; - duplicate union-set is O(m) vs. O(n^2) beacuse it skips the membership check for each elem.
;;
;; if m and n are similar, then the duplicate representation is very good, as it would approximately
;; save a factor of n for adjoin and union-set. or, if you are mostly doing adjoins then you could also
;; get some big savings, i.e. O(n) per call.
;;
;; on the other hand, if you're likely to have duplicate adjoins and/or use intersection
;; a lot (which costs big since it's O(m^2)), then you're likely better off using the non-duplicate rep.
;; example:
;; 1. 2n adjoin operations with n duplicates
;; 2. one intersection-set operation
;; - dupe total work:     2n*1 + (2n)^2 = 4n^2 + 2n
;; - non-dupe total work: 2n*n + n^2 = 3n^2
