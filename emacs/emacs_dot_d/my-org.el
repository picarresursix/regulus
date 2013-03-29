; -*-emacs-lisp-*- Time-stamp: <2013-03-14 21:43:29 leo>
; Several functions which should be useful with org-mode


(require 'org)

;; ======================== settings =========================


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
'((sequence "IDEA" "TODO" "CONTINUE" "TOCHECK" "POLISH"
            "|" "DONE" "ABANDONNED" "IRRELEVANT")))


;; ============= reftex related configuration ===============

; from [[http://tincman.wordpress.com/2011/01/04/research-paper-management-with-emacs-org-mode-and-reftex/] [the intertubz]]

(defun org-mode-reftex-search ()
  ;;jump to the notes for the paper pointed to at from reftex search
  (interactive)
  (org-open-link-from-string
   (format "[[notes:%s]]" (reftex-citation t))
   )
)

(defun org-mode-reftex-setup ()
  (load-library "reftex")
  (and (buffer-file-name) (file-exists-p (buffer-file-name))
       (progn
	 ;enable auto-revert-mode to update reftex when bibtex file changes on disk
	 (global-auto-revert-mode t)
	 (reftex-parse-all)
	 ;add a custom reftex cite format to insert links
	 (reftex-set-cite-format
	  '((?b . "[[bib:%l][%l-bib]]")
	    (?n . "[[notes:%l][%l-notes]]")
	    (?p . "[[papers:%l][%l-paper]]")
	    (?t . "%t")
	    (?h . "** %t\n:PROPERTIES:\n:Custom_ID: %l\n:END:\n[[papers:%l][%l-paper]]")))))
  (define-key org-mode-map (kbd "C-c )") 'reftex-citation)
  (define-key org-mode-map (kbd "C-c (") 'org-mode-reftex-search)
)

(setq org-link-abbrev-alist
      '(("bib" . "~/vault/bibliotheque/scientific_papers/exjobb/refs/biblio.bib::%s")
	("notes" . "~/vault/bibliotheque/scientific_papers/exjobb/refs/comments.org::#%s")
	("papers" . "~/vault/bibliotheque/scientific_papers/exjobb/%s.pdf"))
)

(add-hook 'org-mode-hook 'org-mode-reftex-setup)


;; ===================== Shortcuts ===========================



