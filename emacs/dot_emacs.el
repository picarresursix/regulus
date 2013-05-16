; -*-lisp-*- ; Time-stamp: <2013-05-06 12:01:38 leo>

; !SECTION! Variables set by the customize command.
; =================================================

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector ["#2e3436" "#a40000" "#4e9a06" "#c4a000" "#204a87" "#5c3566" "#729fcf" "#eeeeec"])
 '(blink nil)
 '(blink-cursor-mode 0)
 '(custom-enabled-themes (quote (regulus)))
 '(custom-safe-themes (quote ("549d4d26855b877e247fc0ee7ace427924ad0c191379694c9028fe34d5c5fbc7" "29bcb092e33973744b39f29d986600d8389548dc034f621489b1d669629a9c4a" "c3e30761e56ab59e9d9fda4933b768828d4c2f2ac83aed37022f30fcab55cf74" "f403e0697db23650ee5bf7b4eb72231e1633e76ddec3d12411e0cc65bf457a6e" "c0a2970e79f58efd1932ad570c0c163a08795aa86055d5b8c5c00234470f84e7" "9f2f08d535dddfd351c7f6b015e0276ab9e7d27ee5fa13d387d12a1fc391a1e1" "18d8e5ee382d4258cde745a33b9ebedafdc5f7b619a63af392ad637415261231" "a2758b42cf5a8dd3bfc6404e0d87ee5ace2d0e7bcfa72abb7473789993cfff07" "fc0c03c6ffc2545dbfff921ae2b2332616b63be1ae52c7ea0ce7548fba602637" "06aa24d9ad35e4ca590cbc8330d4d397a2fede1ea4e8940d0b4adeff206d6e8b" "5d190d63218cc024738dbc9918e8b3e6aab21b9646f79dfeb2f6b9466b3cca42" "b6f7795c2fbf75baf3419c60ef7625154c046fc2b10e3fdd188e5757e08ac0ec" "89f613708c8018d71d97e3da7a1e23c8963b798252f1ac2ab813ad63b7a4b341" "d921083fbcd13748dd1eb638f66563d564762606f6ea4389ea9328b6f92723b7" "72cc9ae08503b8e977801c6d6ec17043b55313cda34bcf0e6921f2f04cf2da56" "71b172ea4aad108801421cc5251edb6c792f3adbaecfa1c52e94e3d99634dee7" "5e1d1564b6a2435a2054aa345e81c89539a72c4cad8536cfe02583e0b7d5e2fa" "501caa208affa1145ccbb4b74b6cd66c3091e41c5bb66c677feda9def5eab19c" "d2622a2a2966905a5237b54f35996ca6fda2f79a9253d44793cfe31079e3c92b" "8b7221368020ebdf63bf464ea73e0a0e57953b710e1602e9c3a506d30226773d" "ebf6314f5c7c71034ffe2d67db489c6d868be3cf8cdba02e5a936808c5df75c8" "a8fc1fdda80ba5e1c4826ada861b435f925821d64fd629568949ec77907c69ed" "01ee89f1896f49acd06d123a24b13b75441ead9e403d9a18e6f003093367d68a" "9a5e4e08a54df15ebcb51be47725235b8750d766bf870b8adc6c62bc888feadc" "29e741f5b9aa5fefb23ef09c5003d77451ccdfd6a7672edce11e50ddeaa80d40" "b00a66a298e5d44177716355d913bea3800e16d063817844d686448840ddb860" "8fe9d28b73e603d93deb76d88c28acbdb6c0f8e7a75907395041e04a54911128" "67f0a818d19139ef8a698243253433fcaee9f46204a7dc29341d1fddf4edbc21" "c8abc1244cb812733e364c12c880fd69b3d4a25e5566b09c69bbfa93531bc592" "1fcfa39a64873fd915a27e523e0fa7cfb817c96391fcd461731ec82dffa1a08e" "539db3e3bb06406669e2a7b4a7c3ee7e52b588cc1bdc583a1d8f6e6f1a881797" "7128cde9218ae893852b289a60273a9193f8b30b90fc0b5cb14dc1740136ba17" default)))
 '(inhibit-startup-buffer-menu t)
 '(inhibit-startup-screen t)
 '(initial-buffer-choice "~/org/*todo.org")
 '(initial-scratch-message ";; Scratch buffer")
 '(org-agenda-files (quote ("~/org/*agenda.org")))
 '(org-hide-leading-stars t)
 '(org-link-frame-setup (quote ((vm . vm-visit-folder-other-frame) (gnus . org-gnus-no-new-news) (file . find-file) (wl . wl-other-frame))))
 '(safe-local-variable-values (quote ((class-name . 0)))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


;  Load emacs.d
(add-to-list 'load-path "~/.emacs.d")
(add-to-list 'load-path "~/.emacs.d/elpa")

;  Remove the tool-bar
(tool-bar-mode -1)

;  Show the column-number in the mode line
(column-number-mode)

;  Default mode is text mode
(setq default-major-mode 'text-mode)

;  Activate the use of abbreviation
(setq-default abbrev-mode t)
(read-abbrev-file "~/.abrev")
(setq save-abbrevs t)

;  Activate auto-fill by default
(add-hook 'text-mode-hook 'turn-on-auto-fill)

;  To have nice rainbow parenthesis and know in which function we are
(add-hook 'prog-mode-hook
          (lambda ()
            (highlight-parentheses-mode)
            (which-function-mode)
            ))

;  Typing "y" or "n" instead of "yes" or "no"
(fset 'yes-or-no-p 'y-or-n-p)

;  Replace tabs with spaces
(setq-default indent-tabs-mode nil)

;  Split the window horizontally instead of vertically
(setq split-height-threshold nil)
(setq split-width-threshold 0)

;  Prevent the cursor from jumping around
(setq scroll-step 1)

;  Modify the timestamp wherever needed in the file when closing
(add-hook 'before-save-hook 'time-stamp)

;  Remove scroll-bar
(scroll-bar-mode -1)
(menu-bar-mode -1)

;  Activate loccur
(load "~/.emacs.d/elpa/loccur-1.1.1/loccur")

;  Activate smart auto-completion when switching buffer
(iswitchb-mode 1)

;  Kill the window when done with it (even when using the emacs server).
(add-hook 'server-done-hook (lambda nil (kill-buffer nil)))


;  Configures the auto-complete mode
(add-to-list 'load-path "~/.emacs.d/elpa/auto-complete-1.4")
(load "auto-complete.el")
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories
             "~/.emacs.d/elpa/auto-complete-1.4/dict")
(setq ac-comphist-file "~/.emacs.d/ac-comphist.dat")
(ac-config-default)
(add-hook 'text-mode-hook 'auto-complete-mode)
(setq ac-modes (append '(LaTeX-mode latex-mode) ac-modes))

;  Sets up the package repositories to take into account
(require 'package)
(add-to-list 'package-archives
             '("marmalade" .  "http://marmalade-repo.org/packages/")
             )

;  Yasnippet
(load-file "~/.emacs.d/elpa/yasnippet-0.8.0/yasnippet.el")
(yas/global-mode 1)
(define-key yas-minor-mode-map [(tab)] nil)
(define-key yas-minor-mode-map (kbd "TAB") nil)
(setq yas/trigger-key (kbd "C-_"))



;  Loads my custom files in .emacs.d/my-functions.
(load "meuporg.el")
(load "my-prog.el")
(load "my-cpp.el")
(load "my-latex.el")
(load "my-org.el")
(load "my-misc.el")



;; ========================= SHORTCUTS =============================


;  Sets up ergoemacs.
(setenv "ERGOEMACS_KEYBOARD_LAYOUT" "us") ; US
(load "~/.emacs.d/ergoemacs-keybindings-5.3.9/ergoemacs-mode")
(ergoemacs-mode 1)

;  Adds shortcus used to enlarge to the max (or shrink to the
;  min) the current frame.
(global-set-key (kbd "C-x w +"    ) 'larger-window)
(global-set-key (kbd "C-x w -"    ) 'smaller-window)

;  Adds shortcut to be able to perform a command n times
(global-set-key (kbd "C-0") 'digit-argument)
(global-set-key (kbd "C-1") 'digit-argument)
(global-set-key (kbd "C-2") 'digit-argument)
(global-set-key (kbd "C-3") 'digit-argument)
(global-set-key (kbd "C-4") 'digit-argument)
(global-set-key (kbd "C-5") 'digit-argument)
(global-set-key (kbd "C-6") 'digit-argument)
(global-set-key (kbd "C-7") 'digit-argument)
(global-set-key (kbd "C-8") 'digit-argument)
(global-set-key (kbd "C-9") 'digit-argument)


;  Adds shortcuts consistent with ergoemacs to deal with rectangles.
(global-set-key (kbd "C-x r x") 'kill-rectangle)
(global-set-key (kbd "C-x r v") 'yank-rectangle)
(global-set-key (kbd "C-x r n") 'rectangle-number-lines)
(global-set-key (kbd "C-x r i") 'string-insert-rectangle)

;  Cryptography related shortcuts.
(global-set-key (kbd "<f7> e") 'epa-encrypt-region)
(global-set-key (kbd "<f7> d") 'epa-decrypt-armor-in-region)
(global-set-key (kbd "<f7> s") 'epa-sign-region)
(global-set-key (kbd "<f7> v") 'epa-verify-region)

;  Programming shortcuts (semantic, etc).
(global-set-key (kbd "<f5>" ) 'compile)
;; (global-set-key (kbd "C-à p") 'semantic-analyze-possible-completions)
;; (global-set-key (kbd "C-à a") 'semantic-analyze-current-context)
;; (global-set-key (kbd "C-à r") 'semantic-force-refresh)

;   Adds some shortcuts that are not part of ergoemacs and do not
; fit in any particular category.
(global-set-key (kbd "C-t") 'transpose-chars)
(global-set-key (kbd "C-k") 'kill-line)
(global-set-key (kbd "M-y") 'back-to-indentation)
(global-set-key (kbd "C-j") 'newline-and-indent)
(global-set-key (kbd "C-S-j") 'indent-new-comment-line)
(global-set-key (kbd "M-m") 'end-of-line)
(global-set-key (kbd "C-x x e") 'eval-and-replace)

;  Define org-mode shorctus available in every modes.
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)

(global-unset-key (kbd "M-\""))
(global-set-key (kbd "M-\" c") 'org-store-link)
(global-set-key (kbd "M-\" v") 'org-insert-link-global)
(global-set-key (kbd "M-\" o") 'org-open-at-point-global)

; external search
(global-set-key (kbd "M-\" s f") 'search-word-at-point-wikipedia-fr)  ; fr
(global-set-key (kbd "M-\" s w") 'search-word-at-point-wikipedia-en)  ; wikipedia
(global-set-key (kbd "M-\" s t") 'search-word-at-point-wordreference) ; translate
(global-set-key (kbd "M-\" s g") 'search-word-at-point-google)        ; google
(global-set-key (kbd "M-\" s i") 'search-word-at-point-image)         ; image

; insertion
(global-set-key (kbd "M-\" i a") 'pi2-6/insert-a-ring)
(global-set-key (kbd "M-\" i t") 'pi2-6/insert-time-stamp)
(global-set-key (kbd "M-\" i m") 'pi2-6/insert-mail-address)
(global-set-key (kbd "M-\" i d") 'pi2-6/insert-current-day)
(global-set-key (kbd "M-\" i h") 'pi2-6/insert-current-hour)

; loccur
(global-set-key (kbd "M-\" t") 'pi2-6/list-tags)
(global-set-key (kbd "M-\" l") 'loccur)
(global-set-key (kbd "M-\" C-l") 'loccur-current)

;  miscellaneous
(global-set-key (kbd "M-\" a") 'take-all)
(global-set-key (kbd "M-\" g") 'goto-line)
(global-set-key (kbd "M-\" f") 'ffap)
(global-set-key (kbd "M-\" n") 'open-in-desktop)
(global-set-key (kbd "M-\" m") 'goto-todo-list)
(global-set-key (kbd "M-\" j") 'ace-jump-mode)
