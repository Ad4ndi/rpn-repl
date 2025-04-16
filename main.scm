(use-modules 
  (ice-9 readline) 
  (ice-9 rdelim) 
  (srfi srfi-1) 
  (srfi srfi-13))

(load "stack.scm")
(load "interpret.scm")

(define (rpn-eval input)
  (let ((tokens (remove string-null? (string-split input #\space))))
    (for-each interpret tokens)))

(define (main)
  (let loop ()
    (let ((line (readline " => ")))
      (cond
        ((or (eof-object? line) (string=? line "exit")) (display "Bye!\n"))
        ((string=? (string-trim line) "") (loop))
        (else
         (catch #t
               (lambda ()
                 (rpn-eval line)
                 (format #t " :: ~a\n" (reverse stack)))
               (lambda (key . args)
                 (display "Error: ") (display args) (newline)))
         (loop))))))

(main)
