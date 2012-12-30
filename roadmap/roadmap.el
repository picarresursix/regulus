
(defun roadmap-reload()
  "Reload the current roadmap."
  (interactive)
  (shell-command "roadmap -u")
  (revert-buffer)
  )

(defun roadmap-find-main()
  "Returns the path to roadmap of which the current file depends or an
empty string if there is no such roadmap."
  (setq old-buffer (current-buffer))
  (shell-command "roadmap -h")
  (switch-to-buffer "*Shell Command Output*")
  (setq path-to-main-roadmap
        (buffer-substring-no-properties (point-min) (- (point-max) 1))
        )
  (switch-to-buffer old-buffer)
  path-to-main-roadmap
  )

(defun roadmap-open-main()
  "Open the roadmap of which the current file depends (if any)."
  (interactive)
  (setq path-to-main-roadmap (roadmap-find-main))
  (if (< 2 (length path-to-main-roadmap))
      (progn
        (find-file path-to-main-roadmap)
        (message (concat "Opening " path-to-main-roadmap))
        )
      (message "No roadmap found.")
      )
  )

(defun roadmap-insert-todo()
  "Inserts a TODO roadmap item."
  (interactive)
  (insert (concat "!" "TODO! "))
  )

(defun roadmap-insert-idea()
  "Inserts a TODO roadmap item."
  (interactive)
  (insert (concat "!" "IDEA! "))
  )

(defun roadmap-go-to-next-item()
  (interactive)
  (search-forward-regexp "\![^ ]*\!")
  )

(defun roadmap-go-to-previous-item()
  (interactive)
  (search-backward-regexp "\![^ ]*\!")
  )

(define-minor-mode roadmap-mode
    "Toggle roadmap mode.

  Interactively with no argument, this command toggles the mode.
  A positive prefix argument enables the mode, any other prefix
  argument disables it.  From Lisp, argument omitted or nil enables
  the mode, `toggle' toggles the state. "
   ;; The initial value.
   :init-value nil
   ;; The indicator for the mode line.
   :lighter " Rod"
   :keymap
   `(
     (,(kbd "C-d r")   . roadmap-reload)
     (,(kbd "C-d h")   . roadmap-open-main)
     (,(kbd "C-d i t") . roadmap-insert-todo)
     (,(kbd "C-d i i") . roadmap-insert-idea)
     (,(kbd "C-d n")   . roadmap-go-to-next-item)
     (,(kbd "C-d p")   . roadmap-go-to-previous-item)
     )
   )

(add-hook 'roadmap-mode-hook
         (lambda ()
           (font-lock-add-keywords nil '(("!\\([^ ]*\\)!" 1 font-lock-warning-face t)))
           )
         )

(add-hook 'find-file-hook
          (lambda()
            (if (< 1 (length (roadmap-find-main)))
                (roadmap-mode)
              )
            )
          )
