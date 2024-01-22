;; notes:
;; - I got the lemma but got stuck on the bound and had to lookup answer. requires
;; insight to mess with √5 > 2 or √5 < 3. A bit of a jump if not expecting it. 
;; - I'm abbreviating the proofs heavily since writing is cumbersome.

;; Givens:
;; - Fib(n) = { 0 if n=0, 1 if n=1, Fib(n-1) + Fib(n-2) otherwise }
;; - φ + 1 = φ^2 (golden ratio property)
;; - ψ + 1 = ψ^2 (I derived it)

;; Proof:
;; prove that Fib(n) is the closest integer to (φ^n)/√5, where φ = (1 + √5)/2
;; hint: let ψ = (1 - √5)/2. use induction and the definition of the Fibonacci
;; numbers to prove that Fib(n) = (φ^n - ψ^n) / √5

;; lemma: Fib(n) = (φ^n - ψ^n) / √5
;; proof of lemma:
;; - induction. easy to show base case holds for n=0 and n=1.
;; - inductive step: we'll show Fib(k+1) = Fib(k) + Fib(k-1)
;;
;; - expand Fib(k) + Fib(k-1) to (φ^k - ψ^k)/√5 + (φ^k-1 - ψ^k-1)/√5
;; - factor out: (φ^k-1)(φ + 1)/√5 - (ψ^k-1)(ψ + 1)/√5 
;; - def of golden ratios (see givens): (φ^k-1)(φ^2)/√5 - (ψ^k-1)(ψ^2)/√5 
;; - done

;; proof (using lemma):
;; formally, closest integer means: |(φ^n)/√5 - Fib(n)| < 1/2.
;; - expand Fib(n) using lemma and cancel φ terms: |(ψ^n)/√5| < 1/2
;; - tangent: notice -1 < ψ < 0. so -1 < ψ^n < 1.
;; - also, √5 > 2. so -1/2 < -1/√5 < ψ^n/√5 < 1/√5 < 1/2
;; - so, |(ψ^n)/√5| < 1/2 is true!. QED.

