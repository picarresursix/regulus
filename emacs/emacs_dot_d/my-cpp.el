; -*-emacs-lisp-*- Time-stamp: <2013-05-30 10:36:47 leo>
; Several functions which should be useful when coding in C++

;; ====================== Simple insertion  =========================

; ------ include related stuff

(defun cpp-insert-include(right-delimiter left-delimiter)
  "Inserts a #include and places the cursor between the delimiters."
  (interactive)
  (insert "\#include " right-delimiter left-delimiter)
  (backward-char)
  )

(defun cpp-insert-include-quote()
  "Inserts #include \"\""
  (interactive)
  (cpp-insert-include "\"" "\"")
  )

(defun cpp-insert-include-angle()
  "Inserts #include <>"
  (interactive)
  (cpp-insert-include "<" ">")
  )

; ------ loop related stuff

(defun cpp-insert-for()
  "Inserts the skeleton of a for loop."
  (interactive)
  (insert "for (unsigned int )")
  (backward-char)
)

(defun cpp-insert-braces()
  "Inserts indented braces and places cursor between them."
  (interactive)
  (insert "{")
  (indent-for-tab-command)
  (newline)
  (newline)
  (insert "}")
  (indent-for-tab-command)
  (previous-line)
  (indent-for-tab-command)
)

; ------ stl related stuff


(defun cpp-insert-std()
  "Inserts the string 'std::'."
  (interactive)
  (insert "std::")
)

(defun cpp-insert-std-vector()
  "Inserts the string 'std::vector'."
  (interactive)
  (insert "std::vector<>")
  (backward-char)
)

(defun cpp-insert-std-cout()
  "Inserts the string 'std::cout<<'."
  (interactive)
  (insert "std::cout<<")
)

(defun cpp-insert-std-endl()
  "Inserts the string '<<std::endl'."
  (interactive)
  (insert "<<std::endl")
)


;; ====================== Creating a new class ========================

(defun cpp-new-header-file(class-name)
  "Creates a new file containing the empty header of the class class-name."
  (doxymacs-insert-file-comment)
  (end-of-buffer)
  (newline)
  (newline)
  (insert "\#ifndef _" (upcase class-name) "_H_" "\n")
  (insert "\#define _" (upcase class-name) "_H_\n")
  (newline)
  (newline)
  (doxymacs-insert-blank-multiline-comment)
  (insert "\nclass " class-name)
  (newline)
  (cpp-insert-braces)
  (end-of-buffer)
  (insert ";")
  (newline)
  (newline)
  (insert "#endif")
)


(defun cpp-new-source-file(class-name)
  "Creates a new file containing a stubb of source code for the class class-name."
  (doxymacs-insert-file-comment)
  (end-of-buffer)
  (newline)
  (newline)
  (insert "\#include \"" (downcase class-name) ".hpp\"")
  (newline)
  (newline)
  (insert class-name "::")
)


(defun cpp-new-class(class-name)
  "Creates a header and a source code file for a new cpp class."
  (interactive "sClass name: ")
  (setq source-file (concat (downcase class-name) ".cpp"))
  (setq header-file (concat (downcase class-name) ".hpp"))
  ; create source source-file in the current folder
  (switch-to-buffer (create-file-buffer source-file))
  (write-file source-file)
  (cpp-new-source-file class-name)
  ; create header header-file in the current folder
  (switch-to-buffer (create-file-buffer header-file))
  (write-file header-file)
  (cpp-new-header-file class-name)
  )




;; =================== CEDET STUFF ====================

;; (semantic-mode)
;; (global-semantic-idle-completions-mode t)
;; (global-semantic-decoration-mode t)
;; (global-semantic-highlight-func-mode t)
;; (global-semantic-show-unmatched-syntax-mode t)


;; ====================== Settings ========================

;  Setting the coding style
(setq c-default-style "bsd")

;  Configures the cmake-mode
(add-to-list 'load-path "~/.emacs.d/elpa/cmake-mode-20110824")
(add-to-list 'auto-mode-alist '("CMakeLists\\.txt\\'" . cmake-mode))
(require 'cmake-mode)

;  Adding the doc-mode
(add-to-list 'load-path "~/.emacs.d/elpa/doc-mode-0.2")
(require 'doc-mode)

;  Adding te hooks
(add-hook 'c++-mode-hook
          '(lambda ()
             (doc-mode)
             (subword-mode 1)
             (highlight-parentheses-mode)))
(add-hook 'c-mode-hook
          '(lambda ()
             (doc-mode)))

;; ====================== Keyboard shorcuts ========================

(global-set-key (kbd "<f9> n") 'cpp-new-class)
(global-set-key (kbd "<f9> b") 'cpp-insert-braces)
(global-set-key (kbd "<f9> f") 'cpp-insert-for)
(global-set-key (kbd "<f9> i") 'cpp-insert-include-quote)
(global-set-key (kbd "<f9> j") 'cpp-insert-include-angle)
(global-set-key (kbd "<f9> s s") 'cpp-insert-std)
(global-set-key (kbd "<f9> s c") 'cpp-insert-std-cout)
(global-set-key (kbd "<f9> s e") 'cpp-insert-std-endl)
(global-set-key (kbd "<f9> s v") 'cpp-insert-std-vector)
