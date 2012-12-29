
(defun roadmap-reload()
  (interactive)
  (shell-command "roadmap -u")
  (revert-buffer)
  )

(defun roadmap-go-home()
  (interactive)
  (setq old-buffer (current-buffer))
  (shell-command "roadmap -h")
  (switch-to-buffer "*Shell Command Output*")
  (setq cont (buffer-substring-no-properties (point-min) (- (point-max) 1)))
  (message (number-to-string (length cont)))
  (if (< 2 (length cont))
      (progn
        (find-file cont)
        (message (concat "Opening " cont))
        )
    (progn
      (message "No roadmap found.")
      (switch-to-buffer old-buffer)
      )
    )
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
     (,(kbd "C-d r") . roadmap-reload)
     (,(kbd "C-d h") . roadmap-go-home)
     )
   )
