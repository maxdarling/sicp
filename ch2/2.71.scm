;; (trees simplified to only include leaf weights)

;; n = 5
;;          /\
;;        16 /\
;;          8 /\
;;           4 /\
;;            2  1
;;             

;; n = 10
;;         /\
;;      512 /\
;;       256 /\
;;        128 /\
;;          64 /\
;;           32 /\
;;            16 /\
;;              8 /\
;;               4 /\
;;                2  1




;; in these kinds of trees, 1 bit is required for the most frequent sybmol, and 
;; n-1 bits are required to encode the least frequent symbol.
