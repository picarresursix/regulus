;; Time-stamp: <2013-05-08 21:13:24 leo>
;; Miscellaneous functions to be used in every buffers.


; !SECTION! Delimiters Related
; ============================


;   !SUBSECTION! Main function
;   --------------------------

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


;   !SUBSECTION! Delimiters dependent sub-functions
;   -----------------------------------------

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

(defun pi2-6/insert-backquotes()
  "Inserts `` and moves the cursor in between."
  (interactive)
  (pi2-6/insert-symmetric-symbols "`" "`"))


;   !SUBSECTION! Keyboard shortcuts
;   -------------------------------

(global-set-key (kbd "C-)" ) 'pi2-6/insert-parenthesis)
(global-set-key (kbd "C-]" ) 'pi2-6/insert-braces)
(global-set-key (kbd "C-}" ) 'pi2-6/insert-curly-braces)
(global-set-key (kbd "C-{" ) 'pi2-6/insert-backslashed-curly-braces)
(global-set-key (kbd "C-\"") 'pi2-6/insert-double-quotation-marks)
(global-set-key (kbd "C-'")  'pi2-6/insert-quotation-marks)
(global-set-key (kbd "C-$" ) 'pi2-6/insert-dollars)
(global-set-key (kbd "C-|" ) 'pi2-6/insert-pipes)
(global-set-key (kbd "C-`" ) 'pi2-6/insert-backquotes)



; !SECTION! Frame/Window Related
; =======================

(defun larger-window ()
  "Makes the current window as tall as possible."
  (interactive)
  (enlarge-window 80))

(defun smaller-window ()
  "Makes the current window as small as possible."
  (interactive)
  (shrink-window 80))

(global-set-key (kbd "M-é") 'kill-buffer-and-window)



; !SECTION! Org-Mode Related
; ==========================

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



; !SECTION! Insertion Related
; ===========================

(defun pi2-6/insert-a-ring()
  "Inserts the å character"
  (interactive)
  (insert "å"))


(defun pi2-6/insert-time-stamp()
  "Inserts an empty time-stamp mark"
  (interactive)
  (insert "Time-stamp: <>"))


(defun pi2-6/insert-mail-address()
  "Inserts my mail address between '<' and '>'."
  (interactive)
  (insert "<leoperrin@picarresursix.fr>"))


(defun pi2-6/insert-current-day()
  "Inserts the current day at point"
  (interactive)
  (insert (calendar-date-string (calendar-current-date) nil)))

(defun pi2-6/insert-current-hour()
  "Inserts a string made of the current hour and
  minute (local-time)"
  (interactive)
  (insert (format-time-string "[%H:%M]")))


; !SECTION! Web Related
; =====================

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

(defun search-word-at-point-wordreference()
  "Look up the word at point or the content of the current
selection on word reference (English to French)."
  (interactive)
  (search-word-at-point "http://www.wordreference.com/enfr/"))

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


; !SECTION! Mail Related
; ======================

(defun take-all()
  "Copies the whole current buffer to the clipboard."
  (interactive)
  (kill-ring-save 1 (buffer-size)))
