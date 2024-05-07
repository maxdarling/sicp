(define x (list 1 2 3))
(define y (list 4 5 6))

(append x y) ;; -> (1 2 3 4 5 6)
(cons x y) ;;   -> ((1 2 3) 4 5 6)
(list x y) ;;   -> ((1 2 3) (4 5 6))

;; I got the 2nd one wrong (said ((1 2 3) . (4 5 6)), but it makes sense now.
;; Lists are (first-item . sublist) pairs, or nil/emptylist/'()

