;; the code
;;   (put 'real-part '(complex) real-part)
;;   (put 'imag-part '(complex) imag-part)
;;   (put 'magnitude '(complex) magnitude)
;;   (put 'angle '(complex) angle)
;; is a "pass-through". it's saying to take the magnitude of a complex number, defer to whatever
;; the representation underneath me does (e.g. rectangular or polar). 

;; the value of z is:
;; ('complex . ('rectangular . (3 . 4)))
;; This will result in 2 'apply-generic' calls being made, one for each tag.

;; "trace":
(magnitude z)
(apply-generic 'magnitude z)
(apply (get 'magnitude '(complex))
       ((contents z)))
(magnitude (rectangular . (3 . 4)))
(apply-generic 'rectangular (3 . 4))
(apply (get 'magnitude '(rectangular))
       ((3 . 4)))
(sqrt (+ (square (real-part (3 . 4)))
	 (square (imag-part (3 . 4)))))
