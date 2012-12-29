
(defun roadmap-reload()
  (interactive)
  (shell-command "roadmap -u")
  (revert-buffer)
  )

(defun roadmap-go-home()
  (interactive)
  (if ())

(define-minor-mode roadmap-mode
    "Toggle roadmap mode.
  Interactively with no argument, this command toggles the mode.
  A positive prefix argument enables the mode, any other prefix
  argument disables it.  From Lisp, argument omitted or nil enables
  the mode, `toggle' toggles the state. "
        ;; The initial value.
   nil
   ;; The indicator for the mode line.
   " Rod"
   ;; The minor mode bindings.
   '(
     ([C-d r] . roadmap-reload)
     ([C-d h] . roadmap-go-home)
     )
   )
