#lang racket

(define functions-table
  (make-hash
   (list
    (cons "+" (lambda (a b) (+ a b)))
    (cons "-" (lambda (a b) (- a b)))
    (cons "*" (lambda (a b) (* a b)))
    (cons "/" (lambda (a b) (if (zero? b) (error "division by zero") (/ a b))))
    (cons "^" (lambda (a b) (expt a b)))
    (cons "sqrt" (lambda (a) (sqrt a)))
    (cons "log" (lambda (a) (log a)))
    (cons "logb" (lambda (a b) (log a b)))
    (cons "%" (lambda (a b) (remainder a b)))
    (cons "round" (lambda (a) (round a)))
    (cons "inv" (lambda (a) (/ 1 a)))
    (cons "fact" (lambda (a) (let fact ((n a)) (if (< n 2) 1 (* n (fact (- n 1)))))))
    (cons "sfact" (lambda (n) (let loop ((n n) (acc 1) (acc2 0)) (cond ((= n 0) acc) ((= n 1) acc2) (else (loop (- n 1) (+ (* (- n 1) acc) acc2) acc))))))

    (cons "sum" (lambda (stack) (apply + stack)))
    (cons "prod" (lambda (stack) (apply * stack)))
    
    (cons "sin" (lambda (a) (sin a)))
    (cons "cos" (lambda (a) (cos a)))
    (cons "tan" (lambda (a) (tan a)))
    (cons "sec" (lambda (a) (if (zero? (cos a)) (error "undefined: secant undefined for 90 degrees") (/ 1 (cos a)))))
    (cons "csc" (lambda (a) (if (zero? (sin a)) (error "undefined: cosecant undefined for 0 degrees") (/ 1 (sin a)))))
    (cons "cot" (lambda (a) (if (zero? (tan a)) (error "undefined: cotangent undefined for 0 degrees") (/ 1 (tan a)))))
    
    (cons "asin" (lambda (a) (asin a)))
    (cons "acos" (lambda (a) (acos a)))
    (cons "atan" (lambda (a) (atan a)))
    (cons "asec" (lambda (a) (acos (/ 1 a))))
    (cons "acsc" (lambda (a) (asin (/ 1 a))))
    (cons "acot" (lambda (a) (atan (/ 1 a))))
    
    (cons "sinh" (lambda (a) (sinh a)))
    (cons "cosh" (lambda (a) (cosh a)))
    (cons "tanh" (lambda (a) (tanh a)))
    (cons "sech" (lambda (a) (/ 1 (cosh a))))
    (cons "csch" (lambda (a) (/ 1 (sinh a))))
    (cons "coth" (lambda (a) (/ 1 (tanh a))))
    
    (cons "asinh" (lambda (a) (log (+ a (sqrt (+ (* a a) 1))))))
    (cons "acosh" (lambda (a) (log (+ a (sqrt (- (* a a) 1))))))
    (cons "atanh" (lambda (a) (/ (log (/ (+ 1 a) (- 1 a))) 2)))
    (cons "asech" (lambda (a) (log (/ (+ (sqrt (- 1 (* a a))) 1) a))))
    (cons "acsch" (lambda (a) (log (/ (+ (if (> a 0) 1 -1) (sqrt (+ 1 (* a a)))) a))))
    (cons "acoth" (lambda (a) (/ (log (/ (+ a 1) (- a 1))) 2)))
    )))

(define (safe-pop stack)
  (if (null? stack)
      (error "stack underflow")
      (values (car stack) (cdr stack))))

(define (rpn-eval tokens)
  (let loop ((stack '()) (tokens tokens))
    (if (null? tokens)
        (if (= (length stack) 1)
            (car stack)
            (error "Error: leftover operands"))
        (let ((t (car tokens)) (r (cdr tokens)))
          (cond
            ((hash-has-key? functions-table t)
             (let ((func (hash-ref functions-table t)))
               (cond
                 ((member t '("+" "-" "*" "/" "^" "%" "logb"))
                  (let-values (((a rest1) (safe-pop stack)))
                    (let-values (((b rest2) (safe-pop rest1)))
                      (loop (cons (func b a) rest2) r))))
                 ((member t
                          '("sqrt" "log" "round" "inv" "fact" "sfact"
                            "sin" "cos" "tan" "sec" "csc" "cot"
                            "asin" "acos" "atan" "asec" "acsc" "acot"
                            "sinh" "cosh" "tanh" "coth" "sech" "csch"
                            "asinh" "acosh" "atanh" "acoth" "asech" "acsch"))
                  (let-values (((a rest) (safe-pop stack)))
                    (loop (cons (func a) rest) r)))
                 ((member t '("sum" "prod"))
                  (loop (list (func stack)) r)))))
            ((string->number t)
             (loop (cons (string->number t) stack) r))
            (else (error "Unknown operator" t)))))))

(define (rpn-repl)
  (display "RPN: ")
  (let ((input (read-line)))
    (unless (string=? input "exit")
      (with-handlers ((exn:fail? (lambda (e) (displayln (exn-message e)))))
        (display "= ")
        (displayln (rpn-eval (string-split input))))
      (rpn-repl))))

(rpn-repl)
