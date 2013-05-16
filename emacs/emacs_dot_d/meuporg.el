;;; meuporg.el --- Provides shortcuts for easier use of meup!org.

;; Copyright (C) 2012 Leo Perrin
;;
;; Author: Leo "picarresursix" Perrin <leoperrin@picarresursix.fr>
;; Created: 2012-12-20
;; Version: 0.9
;; Keywords: project management, data centralisation
;; URL: https://github.com/picarresursix/meuporg
;; Compatibility:  GNU Emacs 24.x
;;
;; This file is NOT part of GNU Emacs.
;;
;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License
;; as published by the Free Software Foundation; either version 2
;; of the License, or (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.
;;

;;; Commentary:
;;
;; Move this file somewhere in your emacs load-path. Then, add the following
;; to your .emacs file:
;; 
;; (load-file meuporg.el)
;; 
;;; Issues:
;;
;;; TODO:
;; 
;;; Change Log:
;;
;;; Code:


; !SECTION! Item list (meuporg-item-list minor mode)
; ==================================================


; !SUBSECTION! Variables
; ----------------------

(defvar meuporg/font-faces
  "Defines how the different items should be displayed in the
  list of items.")
(setq meuporg/font-faces
      '(
        ; structural items
        ("line-index" . '(:slant italic :height 0.8))
        ("LEV1" . '(:height 1.1 :slant italic  :foreground "#5C5C5C"))
        ("SECTION" . '(:height 1.1 :slant italic  :foreground "#5C5C5C"))
        ("SUBSECTION" . '(:slant italic  :foreground "#9C9C9C"))
        ("LEV2" . '(:slant italic  :foreground "#9C9C9C"))
        ("SUBSUBSECTION" . '(:height 0.9 :slant italic  :foreground "#9C9C9C"))
        ("LEV3" . '(:height 0.9 :slant italic  :foreground "#9C9C9C"))
        ; action items
        ("CONTINUE" . (:weight bold :foreground "#880066"))
        ("TODO" . '(:foreground "#C00000"))
        ("FIXME" . '(:foreground "#E08040"))
        ("IMPROVE" . '(:foreground "#119922"))
        ("CHECK" . '(:foreground "#004488"))
        ; mode specific items
        ("FIXREF" . '(:foreground "#AA9900"))))

(defvar meuporg/indentation
  "Used by meuporg-list-mode to indent the items according to the
  section they are in.")
(setq meuporg/indentation "")


; !SUBSECTION! Creating the item list
; -----------------------------------


(defun meuporg/list-items ()
  "Returns a list containing all items in the current buffer.

Note that LaTeX style section (e.g. \section{bla bla}) are
considered like items with name '(SUB)*SECTION' and with the
content of {} as their description."
  (interactive)
  (save-excursion
    (setq result (list))
    (goto-char 1)
    (setq std-f-item-regex "\\(![A-Za-z0-9]+!\\)")
    (setq latex-f-item-regex "\\(^\\\\.*section{.*}$\\)")
    (setq std-p-item-regex "!\\([A-Za-z0-9]+\\)!\\(.*\\)$")
    (setq latex-p-item-regex "\\\\\\(.*section\\){\\(.*\\)}$")
    (setq item-regex (concat std-f-item-regex "\\|" latex-f-item-regex))
    (while (search-forward-regexp item-regex nil t)
      (if (match-string-no-properties 1)
          (setq parsing-regex std-p-item-regex)
        (setq parsing-regex latex-p-item-regex))
      (beginning-of-line)
      (search-forward-regexp parsing-regex)
      (setq result (cons (list
                          (line-number-at-pos)
                          (match-string-no-properties 1)
                          (match-string-no-properties 2))
                         result))))
  (reverse result))


(defun meuporg/print-list-item(item)
  "Inserts at point the the line of the item, its name and its
description using the correct faces from meuporg/font-faces"
; !IMPROVE! Instead of writing the name of the section/subsection,
; !write only a number to have a real structure: I- 1. a) i]
  (let (line-index name description face)
    (setq line-index (nth 0 item))
    (setq name (upcase (nth 1 item)))
    (setq description (nth 2 item))
    (setq face (assoc name meuporg/font-faces))
    (if (or (string= "SECTION" name) (string= "LEV1" name))
        (setq meuporg/indentation ""))
    (if (or (string= "SUBSECTION" name) (string="LEV2" name))
        (setq meuporg/indentation "  "))
    (if (or (string= "SUBSUBSECTION" name) (string="LEV3" name))
        (setq meuporg/indentation "    "))
    (insert (format "%s: %s%s %s\n"
                    (propertize (format "%4d" line-index) 'face '(:height 0.8))
                    meuporg/indentation
                    (propertize name 'face (cdr (assoc name meuporg/font-faces)))
                    description))
    (if (or (string= "SECTION" name) (string= "LEV1" name))
        (setq meuporg/indentation "  "))
    (if (or (string= "SUBSECTION" name) (string="LEV2" name))
        (setq meuporg/indentation "    "))
    (if (or (string= "SUBSUBSECTION" name) (string="LEV3" name))
        (setq meuporg/indentation "      "))))


(defun meuporg/show-items ()
  "Creates a new window containing an ordered list of the items
in this file and switches cursor to it."
  (interactive)
  (let (item-list)
    (setq item-list (meuporg/list-items))
    (delete-other-windows)
    (setq meuporg/base-buffer (current-buffer))
    (pop-to-buffer "*Item list*")
    (switch-to-buffer "*Item list*")
    (erase-buffer)
    (mapc 'meuporg/print-list-item item-list)
    (meuporg-item-list-mode)
    (goto-char 1)))


; !SUBSECTION! Interacting with the list of items
; -----------------------------------------------


(defun meuporg/show-item-in-file()
  "Displays the item the cursor is on in an item list."
  (beginning-of-line)
  (search-forward-regexp "\\([0-9]+\\):")
  (beginning-of-line)
  (setq line-index (string-to-int (match-string-no-properties 1)))
  (other-window 1 nil)
  (switch-to-buffer meuporg/base-buffer)
  (goto-char (point-min))
  (forward-line (- line-index 1))
  (recenter))

(defun meuporg/display-item-in-file()
  "In an item list, moves the cursor in the other file to the
line containing the item. Stays in the item list."
  (interactive)
  (meuporg/show-item-in-file)
  (other-window 1 nil))

(defun meuporg/go-to-item-in-file()
  "Kills the buffer and the window containing the item list after
moving to the location of the item."
  (interactive)
  (meuporg/display-item-in-file)
  (kill-buffer-and-window))

(defun meuporg/list-next-section()
  "Searches for the next section."
  (interactive)
  (search-forward " SECTION "))

(defun meuporg/list-previous-section()
  "Searches for the previous section."
  (interactive)
  (search-backward " SECTION "))


; !SUBSECTION! meuporg-item-list-mode
; -----------------------------------

(define-minor-mode meuporg-item-list-mode
    "Toggle meuporg-item-list mode.

  Interactively with no argument, this command toggles the mode.
  A positive prefix argument enables the mode, any other prefix
  argument disables it.  From Lisp, argument omitted or nil enables
  the mode, `toggle' toggles the state. "
   ;; The initial value.
   :init-value nil
   ;; The indicator for the mode line.
   :lighter " !List!"
   :keymap
   `(
     (,(kbd "<right>")   . meuporg/display-item-in-file)
     (,(kbd "<RET>")   . meuporg/go-to-item-in-file)
     (, "q"   . kill-buffer-and-window)
     (, "n"   . meuporg/list-next-section)
     (, "p"   . meuporg/list-previous-section)))

(add-hook 'meuporg-item-list-mode-hook
          (lambda()
            (read-only-mode)
            (hl-line-mode)
            (toggle-truncate-lines 1)))


; !SECTION! Meuporg minor mode
; ============================

; !SUBSECTION! Interacting with the main file
; -------------------------------------------

(defvar meuporg/command
  "The command running the python part of meuporg.")
(setq meuporg/command "python2.7 ~/.meuporg ")


(defun meuporg/update()
  "Reload the current meuporg main file after saving all buffers."
  (interactive)
  (save-some-buffers t)
  (shell-command (concat meuporg/command " -u"))
  (if (get-buffer "meup.*org.*")
      (revert-buffer "meup.*org.*" nil t)))

(defun meuporg/find-main()
  "Returns the path to meuporg of which the current file depends or an
empty string if there is no such meuporg."
  (setq old-buffer (current-buffer))
  (shell-command (concat meuporg/command " -f"))
  (switch-to-buffer "*Shell Command Output*")
  (setq path-to-main-meuporg
        (buffer-substring-no-properties (point-min) (- (point-max) 1)))
  (switch-to-buffer old-buffer)
  (kill-buffer "*Shell Command Output*")
  path-to-main-meuporg)

(defun meuporg/open-main()
  "Open the meuporg of which the current file depends (if any)."
  (interactive)
  (setq path-to-main-meuporg (meuporg/find-main))
  (if (< 2 (length path-to-main-meuporg))
      (progn
        (find-file path-to-main-meuporg)
        (message (concat "Opening " path-to-main-meuporg)))
      (message "No meuporg found.")))


; !SUBSECTION! Inserting items
; ----------------------------

(defun meuporg/insert-item(name)
  "Inserts an item with the given name in a new comment on a new
  indented line"
  (newline-and-indent)
  (insert (concat comment-start "!" name "!  " comment-end))
  (backward-char (+ 1 (length comment-end))))

(defun meuporg/insert-todo()
  "Inserts a TODO meuporg item."
  (interactive)
  (meuporg/insert-item "TODO"))

(defun meuporg/insert-continue()
  "Inserts a TOCHECK meuporg item."
  (interactive)
  (meuporg/insert-item "CONTINUE"))

(defun meuporg/insert-improve()
  "Inserts an IMPROVE meuporg item."
  (interactive)
  (meuporg/insert-item "IMPROVE"))

(defun meuporg/insert-check()
  "Inserts a CHECK meuporg item."
  (interactive)
  (meuporg/insert-item "CHECK"))

(defun meuporg/insert-fixme()
  "Inserts a FIXME meuporg item."
  (interactive)
  (meuporg/insert-item "FIXME"))

(defun meuporg/insert-section()
  "Inserts a SECTION meuporg item."
  (interactive)
  (meuporg/insert-item "SECTION"))

(defun meuporg/insert-subsection()
  "Inserts a SUBSECTION meuporg item."
  (interactive)
  (meuporg/insert-item "SUBSECTION"))

(defun meuporg/insert-subsubsection()
  "Inserts a SUBSUBSECTION meuporg item."
  (interactive)
  (meuporg/insert-item "SUBSUBSECTION"))

(defun meuporg/insert-fixref()
  "Inserts a FIXREF meuporg item.

Since this item is supposed to be inserted within a paragraph, no
new comment is created."
  (interactive)
  (insert "!FIXREF! "))


; !SUBSECTION! Navigating to items
; --------------------------------

(defun meuporg/go-to-next-item()
  "Moves cursor to the next item."
  (interactive)
  (condition-case ex
      (search-forward-regexp "\![a-zA-Z0-9_]*\!")
    ('error
     (message "No items after cursor."))))

(defun meuporg/go-to-previous-item()
  "Moves cursor to the previous item."
  (interactive)
  (condition-case ex
      (search-backward-regexp "\![a-zA-Z0-9_]*\!")
    ('error
     (message "No items before cursor."))))

(defun meuporg/go-to-next-section()
  "Moves cursor to the next highest level section."
  (interactive)
  (condition-case ex
      (search-forward-regexp "\\(!SECTION!\\)\\|\\(^\\\\section{.*}\\)")
    ('error
     (message "No section after cursor."))))

(defun meuporg/go-to-previous-section()
  "Moves cursor to the next highest level section."
  (interactive)
  (condition-case ex
      (search-backward-regexp "\\(!SECTION!\\)\\|\\(^\\\\section{.*}\\)")
    ('error
     (message "No section before cursor."))))



; !SUBSECTION! Minor mode declaration
; -----------------------------------

(define-minor-mode meuporg-mode
    "Toggle meuporg mode.

  Interactively with no argument, this command toggles the mode.
  A positive prefix argument enables the mode, any other prefix
  argument disables it.  From Lisp, argument omitted or nil enables
  the mode, `toggle' toggles the state. "
   ;; The initial value.
   :init-value nil
   ;; The indicator for the mode line.
   :lighter " !M!"
   :keymap
   `(
     (,(kbd "C-! u")   . meuporg/update)
     (,(kbd "C-! o")   . meuporg/open-main)
     (,(kbd "C-! n")   . meuporg/go-to-next-item)
     (,(kbd "C-! p")   . meuporg/go-to-previous-item)
     (,(kbd "C-! C-n")   . meuporg/go-to-next-section)
     (,(kbd "C-! C-p")   . meuporg/go-to-previous-section)
     (,(kbd "C-! l")   . meuporg/show-items)
     (,(kbd "C-! i s 1") . meuporg/insert-section)
     (,(kbd "C-! i s 2") . meuporg/insert-subsection)
     (,(kbd "C-! i s 3") . meuporg/insert-subsubsection)
     (,(kbd "C-! i i") . meuporg/insert-improve)
     (,(kbd "C-! i t") . meuporg/insert-todo)
     (,(kbd "C-! i c") . meuporg/insert-continue)
     (,(kbd "C-! i k") . meuporg/insert-check)
     (,(kbd "C-! i f") . meuporg/insert-fixme)
     (,(kbd "C-! i r") . meuporg/insert-fixref)))


(add-hook 'meuporg-mode-hook
          (lambda ()
            (font-lock-add-keywords
             nil
             '(("!\\([a-zA-Z0-9_]*\\)!" 1 font-lock-warning-face t)))))

(add-hook 'find-file-hook
          (lambda()
            (if (< 1 (length (meuporg/find-main)))
                (meuporg-mode))))
