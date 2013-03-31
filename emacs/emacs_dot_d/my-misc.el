;; Time-stamp: <2013-03-31 00:04:09 leo>
;; Miscellaneous functions to be used in every buffers.


; -------------------------------------------------- List tags


(defun pi2-6/list-C-functions()
  "Displays only the lines corresponding to a function
declaration in a C file."
  (loccur-no-highlight "[A-Za-z0-9_:\*]+ +[A-Za-z0-9_:]+(.*)$"))

(defun pi2-6/list-Python-functions()
  "Displays only the lines corresponding to functions or class
declarations in a python file."
  (loccur-no-highlight "\\(^ *class \\)\\|\\(^ *def \\)"))

(defun pi2-6/list-LaTeX-sections()
  "Displays only the lines corresponding to
section/subsection/subsubsubsection headings."
  (loccur-no-highlight "\\.*section\{.*\}"))

(defun pi2-6/list-elisp-tags()
  "Displays only the lines corresponding to
function definition in an elisp file"
  (loccur-no-highlight "(def"))

(defun pi2-6/list-tags()
  "Calls the function listing the tags corresponding to the
current mode; displays an error message if there is not any."
  (interactive)
  (let (current-major-mode)
    (setq current-major-mode (with-current-buffer (current-buffer) major-mode))
    (if (string= current-major-mode "c-mode")
        (pi2-6/list-C-functions))

    (if (string= current-major-mode "c++-mode")
        (pi2-6/list-C-functions))

    (if (string= current-major-mode "python-mode")
        (pi2-6/list-Python-functions))

    (if (string= current-major-mode "latex-mode")
        (pi2-6/list-LaTeX-sections))

    (if (string= current-major-mode "emacs-lisp-mode")
        (pi2-6/list-elisp-tags))))



; -------------------------------------------------- delimiters related

(defun pi2-6/insert-symmetric-symbols(left right)
  "Inserts a pair of symbol and moves cursor between them or, if
  a region is selected, puts them around it."
  (if (region-active-p)
      (progn
        (setq begin (region-beginning) end (region-end))
        (goto-char end)
        (insert right)
        (goto-char begin)
        (insert left))
    (progn
      (insert left right)
      (backward-char (length right)))))

(defun pi2-6/insert-parenthesis()
  "Inserts () and) moves the cursor in between."
  (interactive)
  (pi2-6/insert-symmetric-symbols "(" ")"))

(defun pi2-6/insert-braces()
  "Inserts [] and moves the cursor in between."
  (interactive)
  (pi2-6/insert-symmetric-symbols "[" "]"))

(defun pi2-6/insert-curly-braces()
  "Inserts {} and moves the cursor in between."
  (interactive)
  (pi2-6/insert-symmetric-symbols "{" "}"))

(defun pi2-6/insert-backslashed-curly-braces()
  "Inserts \{\} and moves the cursor in between."
  (interactive)
  (pi2-6/insert-symmetric-symbols "\\{ " " \\}"))

(defun pi2-6/insert-double-quotation-marks()
  "Inserts \"\" and moves the cursor in between."
  (interactive)
  (pi2-6/insert-symmetric-symbols "\"" "\""))

(defun pi2-6/insert-quotation-marks()
  "Inserts '' and moves the cursor in between."
  (interactive)
  (pi2-6/insert-symmetric-symbols "'" "'"))

(defun pi2-6/insert-dollars()
  "Inserts $$ and moves the cursor in between."
  (interactive)
  (pi2-6/insert-symmetric-symbols "$" "$"))

(defun pi2-6/insert-pipes()
  "Inserts $$ and moves the cursor in between."
  (interactive)
  (pi2-6/insert-symmetric-symbols "| " " |"))


(global-set-key (kbd "C-)" ) 'pi2-6/insert-parenthesis)
(global-set-key (kbd "C-]" ) 'pi2-6/insert-braces)
(global-set-key (kbd "C-}" ) 'pi2-6/insert-curly-braces)
(global-set-key (kbd "C-{" ) 'pi2-6/insert-backslashed-curly-braces)
(global-set-key (kbd "C-\"") 'pi2-6/insert-double-quotation-marks)
(global-set-key (kbd "C-'")  'pi2-6/insert-quotation-marks)
(global-set-key (kbd "C-$" ) 'pi2-6/insert-dollars)
(global-set-key (kbd "C-|" ) 'pi2-6/insert-pipes)



; -------------------------------------------------- frame related

(defun larger-window ()
  "Makes the current window as tall as possible."
  (interactive)
  (enlarge-window 80))

(defun smaller-window ()
  "Makes the current window as small as possible."
  (interactive)
  (shrink-window 80))

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
         (switch-to-buffer buf)))
    (if nofile
        (find-file "~/org/todo.org")))


(defun get-link-to-current-file()
  "Inserts an empty link to the current file without the last ']'"
  (interactive)
  (insert " [[")
  (insert buffer-file-name)
  (insert "][")
  (insert (buffer-name))
  (insert "]] "))


; -------------------------------------------------- insertion related

(defun put-a-ring()
  "Inserts the å character"
  (interactive)
  (insert "å"))


(defun put-time-stamp()
  "Inserts an empty time-stamp mark"
  (interactive)
  (insert "Time-stamp: <>"))


(defun put-mail-address()
  "Inserts my mail address between '<' and '>'."
  (interactive)
  (insert "<leoperrin@picarresursix.fr>"))


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


; -------------------------------------------------- web related

; source: www.ergoemacs.org/emacs/elisp_examples2.html
(defun search-word-at-point(search-url)
  "Browse the url search-url concatenated wuth the content of the
selection or the word at point"
  (let (myWord myUrl)
    (setq myWord
          (if (region-active-p)
              (buffer-substring-no-properties (region-beginning) (region-end))
            (thing-at-point 'symbol)))
    (setq myWord (replace-regexp-in-string " " "%20" myWord))
    (setq myUrl (concat search-url myWord))
    (browse-url myUrl)))

(defun search-word-at-point-wikipedia-en()
  "Look up the word at point or the content of the current
selection on wikipedia (english)."
  (interactive)
  (search-word-at-point "http://en.wikipedia.org/wiki/"))

(defun search-word-at-point-wikipedia-fr()
  "Look up the word at point or the content of the current
selection on wikipedia (french)."
  (interactive)
  (search-word-at-point "http://fr.wikipedia.org/wiki/"))

(defun search-word-at-point-google()
  "Look up the word at point or the content of the current
selection on google."
  (interactive)
  (search-word-at-point "http://www.google.fr/search?hl=fr&q="))

(defun search-word-at-point-image()
  "Look up the word at point or the content of the current
selection on google image."
  (interactive)
  (search-word-at-point "http://www.google.fr/search?tbm=isch&hl=fr&q="))


; -------------------------------------------------- mail related

(defun take-all()
  "Copies the whole current buffer to the clipboard."
  (interactive)
  (kill-ring-save 1 (buffer-size)))
