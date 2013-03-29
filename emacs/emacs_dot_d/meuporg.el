
(setq meuporg-command "python2.7 ~/.meuporg ")

(defun meuporg-reload()
  "Reload the current meuporg."
  (interactive)
  (save-buffer)
  (shell-command (concat meuporg-command " -u"))
  )

(defun meuporg-find-main()
  "Returns the path to meuporg of which the current file depends or an
empty string if there is no such meuporg."
  (setq old-buffer (current-buffer))
  (shell-command (concat meuporg-command " -f"))
  (switch-to-buffer "*Shell Command Output*")
  (setq path-to-main-meuporg
        (buffer-substring-no-properties (point-min) (- (point-max) 1))
        )
  (switch-to-buffer old-buffer)
  path-to-main-meuporg
  )

(defun meuporg-open-main()
  "Open the meuporg of which the current file depends (if any)."
  (interactive)
  (setq path-to-main-meuporg (meuporg-find-main))
  (if (< 2 (length path-to-main-meuporg))
      (progn
        (find-file path-to-main-meuporg)
        (message (concat "Opening " path-to-main-meuporg))
        )
      (message "No meuporg found.")
      )
  )

(defun meuporg-insert-idea()
  "Inserts an IDEA meuporg item."
  (interactive)
  (insert "!IDEA! ")
  )

(defun meuporg-insert-todo()
  "Inserts a TODO meuporg item."
  (interactive)
  (insert "!TODO! ")
  )

(defun meuporg-insert-continue()
  "Inserts a TOCHECK meuporg item."
  (interactive)
  (insert "!CONTINUE! ")
  )

(defun meuporg-insert-tocheck()
  "Inserts a TOCHECK meuporg item."
  (interactive)
  (insert "!TOCHECK! ")
  )

(defun meuporg-insert-polish()
  "Inserts a TOCHECK meuporg item."
  (interactive)
  (insert "!POLISH! ")
  )

(defun meuporg-insert-fixref()
  "Inserts a FIXREF meuporg item."
  (interactive)
  (insert "!FIXREF! ")
  )

(defun meuporg-go-to-next-item()
  (interactive)
  (condition-case ex
      (search-forward-regexp "\![a-zA-Z0-9_]*\!")
    ('error
     (message "No items after cursor.")
     )
    )
  )

(defun meuporg-go-to-previous-item()
  (interactive)
  (condition-case ex
      (search-backward-regexp "\![a-zA-Z0-9_]*\!")
    ('error
     (message "No items before cursor.")
     )
    )
  )

(defun meuporg-list-next-item()
  "Move to the next item in the meuporg list"
  (interactive)
  (if (string= (buffer-name) "!List!")
      (progn
        (occur-next)
        (occur-mode-goto-occurrence)
        (recenter)
        (other-window 1)
      )
    )
  )

(defun meuporg-list-previous-item()
  "Move to the previous item in the meuporg list"
  (interactive)
  (if (string= (buffer-name) "!List!")
      (progn
        (occur-prev)
        (occur-mode-goto-occurrence)
        (recenter)
        (other-window 1)
      )
    )
  )

(defun meuporg-list-patterns-in-buffer(pattern)
  "Lists all the strings matching a given pattern and display them in
a new buffer."
  (setq meuporg-listed-buffer (current-buffer))
  (meuporg-kill-item-list)
  (delete-other-windows)
  (occur pattern)
  (switch-to-buffer "*Occur*")
  (rename-buffer "!List!")
  (beginning-of-buffer)
  (setq inhibit-read-only t)
  (kill-line)
  (insert "[up] move to previous occurrence; [down] move to next one\n")
  (setq inhibit-read-only nil)
  (setq read-only t)
  (meuporg-list-mode)
  (occur-next)
  (switch-to-buffer meuporg-listed-buffer)
  (highlight-lines-matching-regexp pattern)
  (other-window 1)
  (next-line)
  )

(defun meuporg-list-items-in-buffer()
  "Lists the items in the current buffer and displays them in a new
buffer."
  (interactive)
  (meuporg-list-patterns-in-buffer "![A-Za-z0-9_]+!")
  )

(defun meuporg-list-specific-items-in-buffer()
  "Prompts for a string and lists all the items in the file whose name
contains the said string"
  (interactive)
  (setq pattern
        (read-from-minibuffer "Search for items whose names contain: "))
  (meuporg-list-patterns-in-buffer (concat "![A-zA-Z0-9]*" pattern "[A-zA-Z0-9]*!"))
  )

(defun meuporg-kill-item-list()
  "Kills the buffer containing the item list and turns off line
highlighting."
  (interactive)
  (switch-to-buffer meuporg-listed-buffer)
  (hi-lock-mode -1)
  (if (get-buffer "!List!")
      (progn
        (switch-to-buffer "!List!")
        (quit-window t)
        )
    )
  (delete-other-windows)
  )

(define-minor-mode meuporg-list-mode
    "Toggle meuporg-list mode.

  Interactively with no argument, this command toggles the mode.
  A positive prefix argument enables the mode, any other prefix
  argument disables it.  From Lisp, argument omitted or nil enables
  the mode, `toggle' toggles the state. "
   ;; The initial value.
   :init-value nil
   ;; The indicator for the mode line.
   :lighter " !L!"
   :keymap
   `(
     (,(kbd "<down>")   . meuporg-list-next-item)
     (,(kbd "<up>")     . meuporg-list-previous-item)
     )
   )

(global-unset-key (kbd "C-!"))

(define-minor-mode meuporg-mode
    "Toggle meuporg mode.

  Interactively with no argument, this command toggles the mode.
  A positive prefix argument enables the mode, any other prefix
  argument disables it.  From Lisp, argument omitted or nil enables
  the mode, `toggle' toggles the state. "
   ;; The initial value.
   :init-value nil
   ;; The indicator for the mode line.
   :lighter " !M!"
   :keymap
   `(
     (,(kbd "C-! u")   . meuporg-reload)
     (,(kbd "C-! m")   . meuporg-open-main)
     (,(kbd "C-! n")   . meuporg-go-to-next-item)
     (,(kbd "C-! p")   . meuporg-go-to-previous-item)
     (,(kbd "C-! l")   . meuporg-list-items-in-buffer)
     (,(kbd "C-! s")   . meuporg-list-specific-items-in-buffer)
     (,(kbd "C-! q")   . meuporg-kill-item-list)
     (,(kbd "C-! i i") . meuporg-insert-idea)
     (,(kbd "C-! i t") . meuporg-insert-todo)
     (,(kbd "C-! i c") . meuporg-insert-continue)
     (,(kbd "C-! i h") . meuporg-insert-tocheck)
     (,(kbd "C-! i p") . meuporg-insert-polish)
     (,(kbd "C-! i f") . meuporg-insert-fixref)
     )
   )

(add-hook 'meuporg-mode-hook
         (lambda ()
           (font-lock-add-keywords nil '(("!\\([a-zA-Z0-9_]*\\)!" 1 font-lock-warning-face t)))
           )
         )

(add-hook 'find-file-hook
          (lambda()
            (if (< 1 (length (meuporg-find-main)))
                (meuporg-mode)
              )
            )
          )
