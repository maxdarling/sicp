;; explicit dispatch:
;; - new type [BAD]: one must seek out all relevant generic functions and add
;; a specific case handling for the new type, which is hard/error-prone in large systems.
;; - new operation [GOOD]: you simply implement the new procedure and handle each possible type,
;; so it's all in one spot. (but you must copy-paste all the type case-handling into the new
;; procedure, which bloats the code).

;; data-directed dispatch:
;; - new type [GOOD]: in the "package installation" code for the type, one must provide
;; implementations for each operation into the operation-and-type table. your changes are
;; localized to just one spot. this is convenient, and error-free.
;; - new operation [BAD]: you must track down each type that you wish your new operation to work
;; for and implement the type-specific implementation. this shouldn't be too bad if the types are
;; well organized in the system, e.g. in the same file/folder.

;; message-passing:
;; - new-type [GOOD]: you implement the new type using message-passing, involving writing the
;; dispatch for each operation. like data-directed, all the changes are in one spot.
;; - new operation [BAD]: again, same as data-directed. you track down each type and add the
;; implementation for the new operation. hopefully the types are all easy to track down.



;; if you are adding lots of new types, data-directed and message-passing make that easy to do,
;; since the changes are localized to one spot.

;; if you are adding lots of new operations, you might consider explicit dispatch, given that
;; there are not too many types.



;; solution notes:
;; - I got data-directed wrong. it makes sense now. I was assuming that for each type, you could
;; only provide to the table on behalf of that type in a single spot, i.e. the "package
;; installation" code. but this is not the case. the table is global and just needs to have the
;; <op> <type> entries, so you can add them from anywhere (meaning, no need to track stuff down).
;; but then this creates "scattered" code. but no, it's just an option, you can still centralize
;; it. so is it the unnanimous winner? I'm curious.
;; - great explanation of this problem, the "expression problem" (https://wiki.c2.com/?ExpressionProblem)
;; - people in the solution using 2 evaluation criteria. 1: good/bad == are the required updates
;; *localized* or *spread out*. 2: bad/good == do you have to change *old code* or not.
;; - of course the amount of code that you write in each case is about the same.
