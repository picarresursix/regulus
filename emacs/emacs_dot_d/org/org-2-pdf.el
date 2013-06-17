; Time-stamp: <2013-06-17 14:40:57 leo>
; AUTHOR: Leo Perrin <leoperrin@picarresursix.fr>
; DESCRIPTION: Some utilities I created to make a neater export from org to pdf


;!SECTION! Cross references within a file
;========================================

(defun strip-text-properties(txt)
  (set-text-properties 0 (length txt) nil txt)
      txt)

(defun org-ref-link-follow(path)
  "Finds the reference with the specified name."
  (goto-char 0)
  (search-forward-regexp (format "\\#\\+LABEL: *%s" (strip-text-properties path)))
  (recenter))


(defun org-ref-link-export (path desc format)
  (cond
   ((eq format 'latex)
    (concat "\\ref{" (strip-text-properties path) "}"))
   ((eq format 'pdf)
    (concat "\\ref{" (strip-text-properties path) "}"))))

(org-add-link-type "ref" 'org-ref-link-follow 'org-ref-link-export)



;!SECTION! Configuring the export itself
;======================================= 


;!SUBSECTION! Export command 
(setq org-latex-to-pdf-process '("pdflatex %f" "pdflatex %f" "pdflatex %f"))


;!SUBSECTION! Support for code listings
; source: http://lists.gnu.org/archive/html/emacs-orgmode/2010-07/msg00379.html
(add-to-list 'org-export-latex-packages-alist '("" "listings"))
(add-to-list 'org-export-latex-packages-alist '("" "color"))
(setq org-export-latex-listings t)
