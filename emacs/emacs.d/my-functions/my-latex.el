
; Several functions which should be useful with latex


; ----------------------- functions --------------------------


(defun latex-big-parenthesis()
  "Inserts big parenthesis and moves the cursor in between them"
  (interactive)
  (insert "\\big(  \\big)")
  (backward-char 6)
)


(defun latex-very-big-parenthesis()
  "Inserts Big parenthesis and moves the cursor in between them"
  (interactive)
  (insert "\\Big(  \\Big)")
  (backward-char 6)
)



(defun latex-my-figure()
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
\\end{figure}")
)

(defun latex-my-table()
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
")
  )

; ------------------------ settings -----------------------------

(add-hook 'LaTeX-mode-hook
          (lambda ()
            (tex-interactive-mode)
            (reftex-mode)
            (local-set-key (kbd "C-l b") 'latex-big-parenthesis)
            (local-set-key (kbd "C-l B") 'latex-very-big-parenthesis)
            (local-set-key (kbd "C-l t") 'latex-my-table)
            )
          )
(setq TeX-PDF-mode t)
(setq latex-run-command "pdflatex")
(setq TeX-electric-sub-and-superscript t)



