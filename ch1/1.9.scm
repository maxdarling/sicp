(define (+ a b)
  (if (= a 0) b (inc (+ (dec a) b))))

;; using the substitution model, the above prodcedure's process for (+ 4 5) is:
;; (+ 4 5)
;; (inc (+ 3 5))
;; (inc (inc (+ 2 5)))
;; (inc (inc (inc (+ 1 5))))
;; (inc (inc (inc (inc (+ 0 5)))))
;; (inc (inc (inc (inc 5))))
;; (inc (inc (inc 6)))
;; (inc (inc 7))
;; (inc 8)
;; 9
;; this is a linear recursion, taking O(a) time and space


(define (+ a b)
  (if (= a 0) b (+ (dec a) (inc b))))

;; using the substitution model, the above prodcedure's process for (+ 4 5) is:
;; (+ 4 5)
;; (+ 3 6)
;; (+ 2 7)
;; (+ 1 8)
;; (+ 0 9)
;; 9
;; this is an iteration, taking O(a) time and O(1) space.

