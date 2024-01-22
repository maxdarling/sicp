;; this is a hard problem to pin down exactly...

;; space is O(a) because the depth of the tree grows linearly with n, since the
;; deepest part of the tree is when you keep subtracting 1 from a.

;; time/steps is harder. wiki shows that it's O(a^n), where n is # of denominations.


;; I drew my tree on paper, but here's an ascii art version taken from the wiki:
;; http://community.schemewiki.org/?sicp-ex-1.14
;;
;; (count-change 11)
;; |
;; (cc 11 5)__
;; |          \
;; (cc 11 4)   (cc -39 5)
;; |       \___
;; |           \
;; (cc 11 3)   (cc -14 4)
;; |       \_______________________________________________________
;; |                                                               \
;; (cc 11 2)                                                      (cc 1 3)
;; |       \_________________________                              |     \__
;; |                                 \                             |        \
;; (cc 11 1)                        (cc 6 2)                      (cc 1 2) (cc -9 3)
;; |       \___                      |     \__                     |     \__
;; |           \                     |        \                    |        \
;; (cc 11 0)   (cc 10 1)            (cc 6 1) (cc 1 2)             (cc 1 1) (cc -4 2)
;;          __/ |                 __/ |       |     \__            |     \__
;;         /    |                /    |       |        \           |        \
;; (cc 10 0)   (cc 9 1)  (cc 6 0)   (cc 5 1) (cc 1 1) (cc -4 2)   (cc 1 0) (cc 0 1)
;;          __/ |                 __/ |       |     \__
;;         /    |                /    |       |        \
;; (cc 9 0)    (cc 8 1)  (cc 5 0)   (cc 4 1) (cc 1 0) (cc 0 1)
;;          __/ |                 __/ |
;;         /    |                /    |
;; (cc 8 0)    (cc 7 1)  (cc 4 0)   (cc 3 1)
;;          __/ |                 __/ |
;;         /    |                /    |
;; (cc 7 0)    (cc 6 1)  (cc 3 0)   (cc 2 1)
;;          __/ |                 __/ |
;;         /    |                /    |
;; (cc 6 0)    (cc 5 1)  (cc 2 0)   (cc 1 1)
;;          __/ |                 __/ |
;;         /    |                /    |
;; (cc 5 0)    (cc 4 1)  (cc 1 0)   (cc 0 1)
;;          __/ |
;;         /    |
;; (cc 4 0)    (cc 3 1)
;;          __/ |
;;         /    |
;; (cc 3 0)    (cc 2 1)
;;          __/ |
;;         /    |
;; (cc 2 0)    (cc 1 1)
;;          __/ |
;;         /    |
;; (cc 1 0)    (cc 0 1)
