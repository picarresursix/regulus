; -*-emacs-lisp-*- Time-stamp: <2013-06-17 21:48:40 leo>
; Several functions which should be useful with org-mode


(require 'org)


;!SECTION! Settings
;===================


(require 'org-install)
(setq ac-modes (append '(org-mode) ac-modes))
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(setq org-log-done t)

;  Have two spaces of indentation and turning off auto-fill
(add-hook 'org-mode-hook
          'turn-off-auto-fill
          'org-indent-mode)

;  Open pdf with evince [[http://stackoverflow.com/a/8836108/789593]]
(add-hook 'org-mode-hook
      '(lambda ()
         (delete '("\\.pdf\\'" . default) org-file-apps)
         (add-to-list 'org-file-apps '("\\.pdf\\'" . "evince %s"))))
(setq org-return-follows-link t)


;  Using my own keywords
(setq org-todo-keywords
'((sequence "TODO" "CONTINUE" "IMPROVE" "CHECK" "FIXME"
            "|" "DONE" "ABANDONNED")))



;!SECTION! Loading files
;=======================
 
(load-file "~/regulus/emacs/emacs_dot_d/org/org-2-pdf.el")
(load-file "~/regulus/emacs/emacs_dot_d/org/org-papers.el")



;!SECTION!  reftex related configuration
;=======================================

; from [[http://tincman.wordpress.com/2011/01/04/research-paper-management-with-emacs-org-mode-and-reftex/] [the intertubz]]

;; (defun org-mode-reftex-search ()
;;   ;;jump to the notes for the paper pointed to at from reftex search
;;   (interactive)
;;   (org-open-link-from-string
;;    (format "[[notes:%s]]" (reftex-citation t))
;;    )
;; )

;; (defun org-mode-reftex-setup ()
;;   (load-library "reftex")
;;   (and (buffer-file-name) (file-exists-p (buffer-file-name))
;;        (progn
;; 	 ;enable auto-revert-mode to update reftex when bibtex file changes on disk
;; 	 (global-auto-revert-mode t)
;; 	 (reftex-parse-all)
;; 	 ;add a custom reftex cite format to insert links
;; 	 (reftex-set-cite-format
;; 	  '((?b . "[[bib:%l][%l-bib]]")
;; 	    (?n . "[[notes:%l][%l-notes]]")
;; 	    (?p . "[[papers:%l][%l-paper]]")
;; 	    (?t . "%t")
;; 	    (?h . "** %t\n:PROPERTIES:\n:Custom_ID: %l\n:END:\n[[papers:%l][%l-paper]]")))))
;;   (define-key org-mode-map (kbd "C-c )") 'reftex-citation)
;;   (define-key org-mode-map (kbd "C-c (") 'org-mode-reftex-search)
;; )

;; (setq org-link-abbrev-alist
;;       '(("bib" . "~/vault/bibliotheque/scientific_papers/exjobb/refs/biblio.bib::%s")
;; 	("notes" . "~/vault/bibliotheque/scientific_papers/exjobb/refs/comments.org::#%s")
;; 	("papers" . "~/vault/bibliotheque/scientific_papers/exjobb/%s.pdf"))
;; )

;; (add-hook 'org-mode-hook 'org-mode-reftex-setup)



;!SECTION! Org presentation
;===========================


(add-to-list 'load-path "~/regulus/emacs/emacs_dot_d/org/org-present.el")
(autoload 'org-present "~/regulus/emacs/emacs_dot_d/org/org-present.el" nil t)

(add-hook 'org-present-mode-hook
          (lambda ()
            (org-present-big)
            (org-display-inline-images)))

(add-hook 'org-present-mode-quit-hook
          (lambda ()
            (org-present-small)
            (org-remove-inline-images)))




