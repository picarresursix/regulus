; Time-stamp: <2013-06-29 17:50:08 leo>
; AUTHOR: Leo Perrin <leoperrin@picarresursix.fr>
; DESCRIPTION: Some utilities I created to make a neater export from org to pdf


;!SECTION! Cross references within a file
;========================================

(defun strip-text-properties(txt)
  "Removes properties from a string."
  (set-text-properties 0 (length txt) nil txt)
      txt)

(defun org-ref-link-follow(path)
  "Finds the reference with the specified name."
  (goto-char 0)
  (search-forward-regexp (format "\\#\\+LABEL: *%s" (strip-text-properties path)))
  (recenter))


(defun org-ref-link-export (path desc format)
  "Exports cross references within a file correctly."
  (cond
   ((eq format 'html)
    (concat "[" (strip-text-properties path) "]"))
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


;!SUBSECTION! Appending the generation of the list of figures/tables and bibliography
(defadvice org-export-as-latex(after org-latex-add-tables activate)
"Appends LaTeX code to generate the list of figures, list of
tables and bibliography for the current file."
  (setq org-buffer-name (buffer-name (current-buffer)))
  (setq tex-buffer-name (replace-regexp-in-string "\.org$" ".tex" org-buffer-name))
  (switch-to-buffer tex-buffer-name)
  (end-of-buffer)
  (newline)
  (insert "\\listoffigures\n")
  (insert "\\listoftables\n")
  (insert "\\bibliographystyle{alpha}\n")
  (insert "\\bibliography{/home/leo/doctoral_studies/ressources/papers/biblio.bib}\n")
  (switch-to-buffer org-buffer-name))

(ad-activate 'org-export-as-latex)
; #+LATEX: \listoffigures
; #+LATEX: \listoftables
; #+LATEX: \bibliographystyle{alpha}
; #+LATEX: \bibliography{/home/leo/doctoral_studies/ressources/papers/biblio.bib}
 
