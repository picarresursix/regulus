; Time-stamp: <2013-04-29 19:02:37 leo>
; Several functions which should be useful with latex and beamer tex
; files.


; !SECTION! Easy insertion
; =====================


(defun pi2-6/latex-big-parenthesis()
  "Inserts big parenthesis and moves the cursor in between them"
  (interactive)
  (pi2-6/insert-symmetric-symbols "\\big( " " \\big)"))


(defun pi2-6/latex-very-big-parenthesis()
  "Inserts Big parenthesis and moves the cursor in between them"
  (interactive)
  (pi2-6/insert-symmetric-symbols "\\Big( " " \\Big)"))

(defun pi2-6/latex-previous-math-thing ()
  "Inserts the content of the previous dollars (if any) at
point."
  (interactive)
  (let (previous-math-thing)
    (save-excursion
      (search-backward-regexp "\\$\\(.+\\)\\$")
      (setq previous-math-thing (match-string 1)))
    (insert previous-math-thing)))


; !SECTION! Environments
; ======================


(defun pi2-6/latex-figure()
  "Inserts a figure environment with centered graphics, label and caption"
  (interactive)
  (insert "
\\begin{figure}[ht]
  \\begin{center}
    \\includegraphics[width=70mm]{}
  \\end{center}
  \\centering
  \\caption{}
  \\label{fig:}
\\end{figure}"))

(defun pi2-6/latex-table()
  "Inserts an empty table with two columns and one line"
  (interactive)
  (insert "
\\begin{table}[h]
  \\centering
  \\begin{tabular}{c|c}
   & \\\\ \\hline
  \\end{tabular}
  \\caption{}
  \\label{tab:}
\\end{table}
"))


; !SECTION! Beamer
; ================

(defun pi2-6/latex-beamer-list-frames()
  "Displays only the lines corresponding to frame titles."
  (interactive)
  (loccur-no-highlight "\\frametitle"))


(defun pi2-6/latex-renumber-frames ()
  "Looks for all the 'Frame No: ' in current buffer and
renumbers-them."
  (interactive)
  (save-excursion
    (let (index)
      (beginning-of-buffer)
      (setq index 0)
      (while (re-search-forward "Frame No:.*$" nil t)
        (replace-match
         (concat "Frame No: " (int-to-string (setq index (+ index 1))))
         nil nil)))
    (message "Renumbering done.")))



; !SECTION! Settings
; ==================

(add-hook 'LaTeX-mode-hook
          (lambda ()
            (tex-interactive-mode)
            (reftex-mode)
            (local-set-key (kbd "C-l b") 'pi2-6/latex-big-parenthesis)
            (local-set-key (kbd "C-l $") 'pi2-6/latex-previous-math-thing)
            (local-set-key (kbd "C-l B") 'pi2-6/latex-very-big-parenthesis)
            (local-set-key (kbd "C-l t") 'pi2-6/latex-table)
            (local-set-key (kbd "C-l f") 'pi2-6/latex-beamer-list-frames)
            (local-set-key (kbd "C-l r") 'pi2-6/latex-renumber-frames)
            (setq latex-pause-on t)))
(setq TeX-PDF-mode t)
(setq latex-run-command "pdflatex")
(setq TeX-electric-sub-and-superscript t)



