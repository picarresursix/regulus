(deftheme regulus
  "A color theme with a light background going easy on the number
  of color used.")

(blink-cursor-mode 0)
(custom-theme-set-variables
 'regulus
 '(ansi-color-names-vector ["#2e3436" "#a40000" "#4e9a06" "#c4a000" "#204a87" "#5c3566" "#729fcf" "#eeeeec"])
 '(custom-safe-themes (quote ("5e1d1564b6a2435a2054aa345e81c89539a72c4cad8536cfe02583e0b7d5e2fa" "72cc9ae08503b8e977801c6d6ec17043b55313cda34bcf0e6921f2f04cf2da56" "501caa208affa1145ccbb4b74b6cd66c3091e41c5bb66c677feda9def5eab19c" "d2622a2a2966905a5237b54f35996ca6fda2f79a9253d44793cfe31079e3c92b" "5c79498491a4e6218a1961ab331afc97f2939ac63dc8181d847f195fda82e2fa" "71b172ea4aad108801421cc5251edb6c792f3adbaecfa1c52e94e3d99634dee7" "6cfe5b2f818c7b52723f3e121d1157cf9d95ed8923dbc1b47f392da80ef7495d" default)))
 '(inhibit-startup-buffer-menu t)
 '(inhibit-startup-screen t)
 '(initial-buffer-choice "~/org/todo.org")
 '(initial-scratch-message ";; Scratch buffer")
 '(safe-local-variable-values (quote ((class-name . 0)))))



; defining the color-theme
(let ((class '((class color) (min-colors 89))))
  (custom-theme-set-faces
   'regulus
   `(cursor ((,class (:background "#C4A000"))))
   `(border-color ((,class (:background "#F4F4F4"))))
   `(default ((,class (:background "#F4F4F4" :foreground "#0E0E0E"))))
   `(fringe ((,class (:background "#F4F4F4"))))
   `(mode-line ((,class (:box (:line-width -1 :style released-button)
			 :background "#555555" :foreground "#BBBBBB"))))
   `(mode-line-inactive ((,class (:foreground "#C6C6C6" :background ,"white"))))
   `(header-line ((,class (:foreground "#CCCCCC" :background "black"))))

   `(minibuffer-prompt ((,class (:foreground "#844000" :bold t))))
   `(region ((,class (:foreground unspecified :background "#f0d040"))))
   `(dired-header ((,class (:bold t :foreground "#0084C8"))))
   `(widget-button ((,class (:bold t :foreground "#0084C8"))))

   `(success ((,class (:bold t :foreground "#4E9A06"))))
   `(warning ((,class (:foreground "#CE5C00"))))
   `(error ((,class (:foreground "#B50000"))))

   `(font-lock-builtin-face ((,class (:foreground "#555555" :bold t))))
   `(font-lock-constant-face ((,class (:foreground "#0E0E0E" :bold t :italic t))))
   `(font-lock-type-face ((,class (:foreground "#0E0E0E" :bold t :italic t))))
   `(font-lock-comment-face ((,class (:foreground "#A00000"))))
   `(font-lock-function-name-face ((,class (:foreground "#004488" :bold t))))
   `(font-lock-keyword-face ((,class (:foreground "#000000" :bold t))))
   `(font-lock-string-face ((,class (:foreground "#004488"))))
   `(font-lock-variable-name-face ((,class (:foreground "#844000" :bold t))))
   `(font-lock-warning-face ((,class (:foreground "#FF0000" :bold t))))

   `(link ((,class (:underline t :foreground "#0066CC"))))
   `(link-visited ((,class (:underline t :foreground "#6799CC"))))
   `(highlight ((,class (:foreground "white" :background "#4A90D9"))))
   `(isearch ((,class (:foreground "white" :background "#77A4DD"))))

   `(erc-action-face ((,class (:foreground "#F5666D"))))
   `(erc-button ((,class (:foreground "#A8799C"))))
   `(erc-current-nick-face ((,class (:bold t :foreground "#FF7092"))))
   `(erc-error-face ((,class (:foreground "#F5666D" :bold t))))
   `(erc-input-face ((,class (:foreground "black"))))
   `(erc-keyword-face ((,class (:foreground "#F5666D"))))
   `(erc-my-nick-face ((,class (:bold t :foreground "#FF8CA7"))))
   `(erc-nick-default-face ((,class (:bold t :foreground "#0084C8"))))
   `(erc-notice-face ((,class (:foreground "#0084C8"))))
   `(erc-prompt-face ((,class (:foreground "black"))))
   `(erc-timestamp-face ((,class (:foreground ,"#4CB64A"))))

   `(magit-log-sha1 ((,class (:foreground "#FF7092"))))
   `(magit-log-head-label-local ((,class (:foreground "#4F78B5"))))
   `(magit-log-head-label-remote ((,class (:foreground ,"#4CB64A"))))
   `(magit-branch ((,class (:bold t :foreground "#0084C8"))))
   `(magit-section-title ((,class (:bold t :foreground "#00578E"))))
   `(magit-item-highlight ((,class (:background "#FEFFBF"))))
   `(magit-diff-add ((,class (:bold t :foreground "#4CB64A"))))
   `(magit-diff-del ((,class (:bold nil :foreground "#F5666D"))))

   `(gnus-group-mail-1-empty ((,class (:foreground "#00578E"))))
   `(gnus-group-mail-1 ((,class (:bold t :foreground "#4F78B5"))))
   `(gnus-group-mail-3-empty ((,class (:foreground "#00578E"))))
   `(gnus-group-mail-3 ((,class (:bold t :foreground "#9CBB43"))))
   `(gnus-group-news-3-empty ((,class (:foreground "#00578E"))))
   `(gnus-group-news-3 ((,class (:bold t :foreground "#9CBB43"))))
   `(gnus-header-name ((,class (:bold t :foreground "#0084C8"))))
   `(gnus-header-subject ((,class (:bold t :foreground "#FF7092"))))
   `(gnus-header-content ((,class (:foreground "#FF7092"))))
   `(gnus-button ((,class (:bold t :foreground "#00578E"))))
   `(gnus-cite-1 ((,class (:foreground "#00578E"))))
   `(gnus-cite-2 ((,class (:foreground "#0084C8"))))

   `(diff-added ((,class (:bold t :foreground "#4E9A06"))))
   `(diff-removed ((,class (:bold t :foreground "#F5666D"))))))

;; Local Variables:
;; no-byte-compile: t
;; End:
(provide-theme 'regulus)
