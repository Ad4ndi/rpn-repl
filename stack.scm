(define stack '())

(define (push x)
  (set! stack (cons x stack)))

(define (pop)
  (if (null? stack)
      (error "Null stack")
      (let ((top (car stack)))
        (set! stack (cdr stack))
        top)))

(define (peek)
  (if (null? stack)
      (error "Null stack")
      (car stack)))

(define (1-arg fn)
  (if (< (length stack) 1)
      (error "Null stack")
      (let ((a (pop)))
        (push (fn a)))))

(define (2-arg fn)
  (if (< (length stack) 2)
      (error "Null stack")
      (let ((b (pop))
            (a (pop)))
        (push (fn a b)))))
