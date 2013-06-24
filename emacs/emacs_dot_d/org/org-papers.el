; Time-stamp: <2013-06-24 10:53:20 leo>
; AUTHOR: Leo Perrin <leoperrin@picarresursix.fr>
; DESCRIPTION: Utils to easily insert links to papers in org files



(defun org-paper-open(path)
  "Opens the paper with the approximative name given.

The name must be a string whose letters and digit match an
  article in ~/Bibliotheque/scientific_papers"
  (setq approx-name (replace-regexp-in-string "[\.\+]" "\*" path))
  (setq command (concat "~/regulus/emacs/open-paper.sh -o \"" approx-name "\""))
  (call-process-shell-command command nil 0 nil))


; Explanations about this can be found [[http://stackoverflow.com/questions/14684263/how-to-org-mode-image-absolute-path-of-export-html][here]]
(defun org-paper-export(path desc format)
  "Returns a link to a paper correctly formatted."
  (cond
   ((eq format 'html)
    (format
     "<a href=\"/home/leo/doctoral_studies/ressources/papers/%s\">[%s]</a>"
     path
     (nth 1 (split-string desc ":"))))
   ((eq format 'latex)
    (format "\\cite{%s}" path))))

(org-add-link-type "paper" 'org-paper-open 'org-paper-export)
