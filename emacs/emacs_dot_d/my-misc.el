;; Time-stamp: <2013-01-02 22:14:05 leo>
;; Miscellaneous functions to be used in every buffers.
;; They are sorted by "theme":
;; - org-mode related functions (those that I use to always have 
;;   org-mode at hand
;; - functions to move easily within the file by going to the next '{'
;;   or '}'




; -------------------------------------------------- delimiters related

(defun my-insert-parenthesis()
  "Inserts () and moves the cursor in between."
  (interactive)
  (insert "()")
  (backward-char)
)

(defun my-insert-braces()
  "Inserts [] and moves the cursor in between."
  (interactive)
  (insert "[]")
  (backward-char)
)

(defun my-insert-curly-braces()
  "Inserts {} and moves the cursor in between."
  (interactive)
  (insert "{}")
  (backward-char)
)

(defun my-insert-backslashed-curly-braces()
  "Inserts \{\} and moves the cursor in between."
  (interactive)
  (insert "\\{\\}")
  (backward-char)
  (backward-char)
)

(defun my-insert-double-quotation-marks()
  "Inserts \"\" and moves the cursor in between."
  (interactive)
  (insert "\"\"")
  (backward-char)
)

(defun my-insert-quotation-marks()
  "Inserts '' and moves the cursor in between."
  (interactive)
  (insert "''")
  (backward-char)
)

(defun my-insert-dollars()
  "Inserts $$ and moves the cursor in between."
  (interactive)
  (insert "$$")
  (backward-char)
)

(defun my-insert-pipes()
  "Inserts $$ and moves the cursor in between."
  (interactive)
  (insert "||")
  (backward-char)
)


(global-set-key (kbd "C-)" ) 'my-insert-parenthesis)
(global-set-key (kbd "C-]" ) 'my-insert-braces)
(global-set-key (kbd "C-}" ) 'my-insert-curly-braces)
(global-set-key (kbd "C-{" ) 'my-insert-backslashed-curly-braces)
(global-set-key (kbd "C-\"") 'my-insert-double-quotation-marks)
(global-set-key (kbd "C-'")  'my-insert-quotation-marks)
(global-set-key (kbd "C-$" ) 'my-insert-dollars)
(global-set-key (kbd "C-|" ) 'my-insert-pipes)


; -------------------------------------------------- frame related

(defun larger-window ()
  "Makes the current window as tall as possible."
  (interactive)
  (enlarge-window 80)
)

(defun smaller-window ()
  "Makes the current window as small as possible."
  (interactive)
  (shrink-window 80)
)

; -------------------------------------------------- org-mode related

(defun goto-todo-list ()
  "Opens the todo list and, if it already is, switches to its buffer"
  (interactive)
  (setq l (buffer-list))
  (setq nofile t)
  (while (and l nofile)
    (setq buf (pop l))
    (when (string-equal (buffer-name buf) "todo.org")
         (setq nofile nil)
         (switch-to-buffer buf)
         )
    )
    (if nofile
        (find-file "~/org/todo.org")
      )
)


(defun get-link-to-current-file()
  "Inserts an empty link to the current file without the last ']'"
  (interactive)
  (insert " [[")
  (insert buffer-file-name)
  (insert "][")
  (insert (buffer-name))
  (insert "]] ")
)


; -------------------------------------------------- insertion related

(defun put-a-ring()
  "inserts the å character"
  (interactive)
  (insert "å")
)


(defun put-time-stamp()
  "Inserts an empty time-stamp mark"
  (interactive)
  (insert "Time-stamp: <>")
)


(defun put-mail-address()
  "Inserts my mail address between '<' and '>'."
  (interactive)
  (insert "<leoperrin@picarresursix.fr>")
)


; -------------------------------------------------- elisp related


(defun eval-and-replace ()
  "Replace the preceding sexp with its value."
  (interactive)
  (backward-kill-sexp)
  (condition-case nil
      (prin1 (eval (read (current-kill 0)))
             (current-buffer))
    (error (message "Invalid expression")
           (insert (current-kill 0)))))
