;; Time-stamp: <2013-05-06 11:30:12 leo>
;; AUTHOR: Leo "picarresursix" Perrin, <leoperrin@picarresursix.fr>
;; 
;; Helpers when programming. They are usually bound to C-l <something>
;; and are usually mode-dependent.



; !SECTION! List tags
; ===================


(defun pi2-6/list-C-functions()
  "Displays only the lines corresponding to a function
declaration in a C file."
  (let (function-name current-extension)
    (setq current-extension (file-name-extension (buffer-name (current-buffer))))
    (if (or (string= current-extension "hpp")
            (string= current-extension "h"))
        (loccur-no-highlight "^ *[^/ \*]+[a-zA-Z0-9_]+")
      (loccur-no-highlight "[A-Za-z0-9_:\* ]*[A-Za-z0-9_:]+(.*)$"))))

(defun pi2-6/list-Python-functions()
  "Displays only the lines corresponding to functions or class
declarations in a python file."
  (loccur-no-highlight "\\(^ *class \\)\\|\\(^ *def \\)\\|\\(__main__\\)"))

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


; !SECTION! Switch between definition and implementation
; ======================================================


(defun pi2-6/find-def-or-implementation()
  "Jump between the definition and the implementation of a
  function according to the major-mode."
  (interactive)
  (let (current-major-mode)
    (setq current-major-mode (with-current-buffer (current-buffer) major-mode))
    (if (or (string= current-major-mode "c-mode")
            (string= current-major-mode "c++-mode"))
        (pi2-6/find-def-or-implementation-c)
      (message "Unsupported mode."))))
  
(defun pi2-6/find-def-or-implementation-c()
  "Jump between the definition and the implementation of a
  function."
  (let (function-name current-extension)
    (setq current-extension (file-name-extension (buffer-name (current-buffer))))
    (if (or (string= current-extension "hpp")
            (string= current-extension "h"))
        (progn
          (beginning-of-line)
          (re-search-forward "^ *[^/\*].* \\([a-ZA-Z0-9_]+\\) *(")
          (setq function-name (match-string-no-properties 1))
          (message function-name)
          (ff-find-other-file)
          (beginning-of-buffer)
          (search-forward function-name))
      (progn
        (setq function-name (which-function))
        (ff-find-other-file)
        (beginning-of-buffer)
        (re-search-forward (concat "^ *[^/\*].* " function-name "("))))
    (recenter)))


; !SECTION! Inserting stuff
; ================================

(defun insert-dot ()
  "Inserts a simple dot at point."
  (interactive)
  (insert "."))

(defun pi2-6/insert-block-braces()
  "Inserts indented braces and places cursor between them."
  (interactive)
  (insert "{")
  (indent-for-tab-command)
  (newline)
  (newline)
  (insert "}")
  (indent-for-tab-command)
  (previous-line)
  (indent-for-tab-command))

(defun pi2-6/python-insert-braces()
  "Inserts two braces '{}' and places cursor /after/ them."
  (interactive)
  (insert "{}"))


; !SECTION! Setting up the different modes
; ========================================


;   !SUBSECTION! Common stuff
;   -------------------------

(add-hook 'prog-mode-hook
          (lambda()
            (highlight-parentheses-mode)
;            (which-function-mode)
            (local-set-key (kbd "ù") 'insert-dot)
            (local-set-key (kbd "C-l t") 'pi2-6/list-tags)))


;   !SUBSECTION! C-like modes
;   -------------------------

(add-hook 'c-mode-common-hook
          (lambda()
            (local-set-key (kbd "C-l j") 'pi2-6/find-def-or-implementation)
            (local-set-key (kbd "C-l b") 'pi2-6/insert-block-braces)))


;   !SUBSECTION! Python mode
;   -------------------------

(add-hook 'python-mode-hook
          (lambda()
            (local-set-key (kbd "C-l b") 'pi2-6/python-insert-braces)))
