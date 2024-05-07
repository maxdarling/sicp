;; footnote 34 hints the behavior of the evaluator: '⟨expression⟩ == (quote ⟨expression⟩)
(car ''abracadabra)
;; -> 
(car '(quote abracadabra))
;; -> 
'quote
