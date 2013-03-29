
; Several functions which should be useful with latex


; ----------------------- Parenthesis --------------------------


(defun latex-big-parenthesis()
  "Inserts big parenthesis and moves the cursor in between them"
  (interactive)
  (my-insert-symmetric-symbols "\\big( " " \\big)")
)


(defun latex-very-big-parenthesis()
  "Inserts Big parenthesis and moves the cursor in between them"
  (interactive)
  (my-insert-symmetric-symbols "\\Big( " " \\Big)")
)


; ----------------------- Environments --------------------------


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


; ------------------------- Beamer ------------------------------

(defun latex-beamer-toggle-pause()
  "Replaces '\pause' by '% \pause' and sets latex-pause-on to
nil if latex-pause-on is t, replaces '% \pause' by '\pause'
and sets latex-pause-on to t otherwise."
  ; !TODO! Modify latex-beamer-toggle-pause to check if there is a '%
  ; !\pause' instead of using the global variable.
  (interactive)
  (if latex-pause-on
      (progn
        (replace-string "\pause" "% \pause")
        (setq late-pause-on nil)
        )
    (progn
      (replace-string "% \pause" "\pause")
      (setq late-pause-on t)
      )
    )
  )

; ------------------------ settings -----------------------------

(add-hook 'LaTeX-mode-hook
          (lambda ()
            (tex-interactive-mode)
            (reftex-mode)
            (local-set-key (kbd "C-l b") 'latex-big-parenthesis)
            (local-set-key (kbd "C-l B") 'latex-very-big-parenthesis)
            (local-set-key (kbd "C-l t") 'latex-my-table)
            (local-set-key (kbd "C-l p") 'latex-beamer-toggle-pause)
            (setq latex-pause-on t)
            )
          )
(setq TeX-PDF-mode t)
(setq latex-run-command "pdflatex")
(setq TeX-electric-sub-and-superscript t)



