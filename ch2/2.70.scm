(load "2.68.scm")
(load "2.69.scm")

(define message '(Get a job
		  Sha na na na na na na na na
		  Get a job
		  Sha na na na na na na na na
		  Wah yip yip yip yip yip yip yip yip yip
		  Sha boom))
(define freq-pairs '((A 2) (GET 2) (SHA 3) (WAH 1) (BOOM 1) (JOB 2) (NA 16) (YIP 9)))

(define tree (generate-huffman-tree freq-pairs))

(define encoded-message (encode message tree))
encoded-message ;; (1 1 1 1 1 1 1 0 0 1 1 1 1 0 1 1 1 0 0 0 0 0 0 0 0 0 1 1 1 1 1 1 1 0 0 1 1 1 1 0 1 1 1 0 0 0 0 0 0 0 0 0 1 1 0 1 1 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 1 1 0 1 1 0 1 0)
(length encoded-message) ;; -> 84

;; solution
;; - length is 84
;; - fixed-length for 8-symbol alphabet results is log_2(8) = 3 bits per symbol. the message is 36
;; symbols, so 3*36 = 108.
