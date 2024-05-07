(define a (list 1 3 (list 5 7) 9)) ;; -> (1 3 (5 7) 9)
;;                 *
;;            /   /  \   \
;;           1   3    *   9
;;                   / \
;;                  5   7
(car (cdr (car (cdr (cdr a))))) ;; -> 7


(define b (list (list 7))) ;; -> ((7))
;;                   *
;;                  /
;;                 *
;;                /
;;               7
(car (car b)) ;; -> 7


(define c (list 1 (list 2 (list 3 (list 4 (list 5 (list 6 7))))))) ;; -> (1 (2 (3 (4 (5 (6 7))))))
;;          *
;;         / \
;;        1   *
;;           / \
;;          2   *
;;             / \
;;            3   *
;;               / \
;;              4   *
;;                 / \
;;                5   *
;;                   / \
;;                  6   7
(car (cdr (car (cdr (car (cdr (car (cdr (car (cdr (car (cdr c)))))))))))) ;; -> 7
;; note: this one confused me for a sec, but the box diagram says it all. when you take
;; (cdr (list 1 (list 2 3))) you're getting ((2 3)) which is odd at first, but makes sense, since
;; cdr'ing a list gives you a sublist. I was thinking it was (1 . X) when it's actually (1 (X)) ==
;; (1 . (X . nil)).
;; i.e.:
(cons 1 (list 2 3))
;; vs.
(cons 1 (cons (cons 2 (cons 3 '())) '())) ;; ==
(list 1 (list 2 3))
