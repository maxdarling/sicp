;; a. 5 times. see model evaluation below:
;;
;;  (sine 12.15) 
;;  (p (sine 4.05)) 
;;  (p (p (sine 1.35))) 
;;  (p (p (p (sine 0.45)))) 
;;  (p (p (p (p (sine 0.15))))) 
;;  (p (p (p (p (p (sine 0.05)))))) 
;;  (p (p (p (p (p 0.05))))) 

;; b. this is a linear recursion.
;; tripling 'a' adds 1 recursion. so space and time are O(log_3(a)).
