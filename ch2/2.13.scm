;; Givens:
;; "p" and "q" are percentages, and are small.

;; (a ± ap) x (b ± bq) =
;; [a(1-p), a(1+p)] x [b(1-q), b(1+q)] = 
;; <assume all pos. nums>
;; [ab(1-p)(1-q), ab(1+p)(1+q)] =
;; [ab(1 - q - p -pq), ab(1 + q + p + pq)] =
;; <approximate: ignore pq terms cuz tiny>
;; [ab - ab(p+q), ab + ab(p+q)]

;; so, we see that for small percentage tolerances, the tolerance of the product of 
;; 2 intervals is approximately equal to the sum of the tolerances. 
