; Time-stamp: <2013-03-31 13:14:06 leo>
; Several functions which should be useful with latex and beamer tex
; files.


; ----------------------- Parenthesis --------------------------


(defun pi2-6/latex-big-parenthesis()
  "Inserts big parenthesis and moves the cursor in between them"
  (interactive)
  (pi2-6/insert-symmetric-symbols "\\big( " " \\big)"))


(defun pi2-6/latex-very-big-parenthesis()
  "Inserts Big parenthesis and moves the cursor in between them"
  (interactive)
  (pi2-6/insert-symmetric-symbols "\\Big( " " \\Big)"))


; ----------------------- Environments --------------------------


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


; ------------------------- Beamer ------------------------------

(defun pi2-6/latex-beamer-list-frames()
  "Displays only the lines corresponding to frame titles."
  (interactive)
  (loccur-no-highlight "\\frametitle"))

; ------------------------ settings -----------------------------

(add-hook 'LaTeX-mode-hook
          (lambda ()
            (tex-interactive-mode)
            (reftex-mode)
            (local-set-key (kbd "C-l b") 'pi2-6/latex-big-parenthesis)
            (local-set-key (kbd "C-l B") 'pi2-6/latex-very-big-parenthesis)
            (local-set-key (kbd "C-l t") 'pi2-6/latex-table)
            (local-set-key (kbd "C-l f") 'pi2-6/latex-beamer-list-frames)
            (setq latex-pause-on t)))
(setq TeX-PDF-mode t)
(setq latex-run-command "pdflatex")
(setq TeX-electric-sub-and-superscript t)



