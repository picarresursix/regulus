;; Time-stamp: <2012-11-05 13:33:33 leo>

;; Miscellaneous shortcuts intended to improve the ergonomics of
;; emacs.

; -------------------------------------------------- moving

; moving one char

(global-unset-key (kbd "C-d"))
(global-set-key (kbd "C-d") 'forward-char)
(global-set-key (kbd "C-q") 'backward-char)
(global-set-key (kbd "C-z") 'previous-line)
(global-set-key (kbd "C-s") 'next-line)

; moving one word

(global-set-key (kbd "C-S-d") 'forward-word)
(global-set-key (kbd "C-S-q") 'backward-word)



; -------------------------------------------------- operations

(global-set-key (kbd "C-f") 'isearch-forward)
(global-set-key (kbd "C-p") 'kill-region)
(global-set-key (kbd "M-p") 'kill-ring-save)


; -------------------------------------------------- deleting

(global-set-key (kbd "C-ù") 'delete-backward-char)
(global-set-key (kbd "C-*") 'delete-forward-char)
(global-set-key (kbd "C-M-ù") 'backward-kill-word)
(global-set-key (kbd "C-M-*") 'kill-word)








