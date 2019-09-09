;;; init.el: emacs initial file
;; -*- mode: elisp -*-
;;; Package setting
;; load emacs 24's package system. Add MELPA repository.
;; (when (>= emacs-major-version 24)
;; )
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives
 	     '("melpa-stable" . "http://melpa-stable.milkbox.net/packages/"))
;;(setq package-archive-priorities '(("melpa-stable" . 1)))
(setq package-enable-at-startup nil)
(package-initialize)
(when (not package-archive-contents) (package-refresh-contents))
(defvar my_packages
  '(
    use-package
    material-theme
    ))
(mapc #'(lambda (package)
    (unless (package-installed-p package)
      (package-install package)))
      my_packages)
(setq use-package-verbose t)
(setq use-package-always-bin "melpa")
(eval-when-compile
  (require 'use-package))
;;;
;;;
;;; UI setting
(setq visible-bell 1)
(set-scroll-bar-mode 'right)
(setq inhibit-startup-message t)
(fset 'yes-orno-p 'y-or-n-p)
(setq kill-whole-line t)
(setq frame-resize-pixelwise t)
(toggle-frame-maximized)
(setq inhibit-startup-message t) ;; hide the startup message
(setq x-alt-keysym 'meta)
(setq cua-keep-region-after-copy t) ;; Standard Windows behaviour
(global-linum-mode 1)

;;;
;;; Keysetting
(global-set-key [?\C-x return] 'compile)
(global-set-key [C-tab] 'other-window) ;forward reference
(global-set-key (kbd "M-`") 'other-window) ;forward reference
(global-set-key (kbd "C-j") 'find-file)
(global-set-key (kbd "C-S-j") 'find-file-at-point)
(global-set-key (kbd "M-j") 'switch-to-buffer)
(global-set-key (kbd "C-S-s") 'isearch-forward-symbol-at-point)
(global-set-key [?\S- ] 'toggle-korean-input-method)
(global-set-key (kbd "<f2>") 'apply-macro-to-region-lines)
(global-set-key (kbd "<f5>") (kbd "C-u C-c C-c"))
(global-set-key (kbd "C-/") 'comment-or-uncomment-region)
(define-key key-translation-map (kbd "<f1>") (kbd "C-h"))
(define-key key-translation-map (kbd "C-h") (kbd "M-%"))
(define-key key-translation-map (kbd "ESC") (kbd "C-g"))
(define-key key-translation-map (kbd "C-<escape>") (kbd "ESC"))
(defun duplicate-line()
  (interactive)
  (move-beginning-of-line 1)
  (kill-line)
  (yank)
  (yank) 
  )
(global-set-key (kbd "C-S-d") 'duplicate-line)
;;;
;;
(defun eshell/clear ()
  "Clear the eshell buffer."
  (interactive)
  (let ((inhibit-read-only t))
    (erase-buffer)))
;;
(defun eshell-new()
  "Open a new instance of eshell."
  (interactive)
  (eshell 'N))
;;;
(use-package expand-region
  :ensure t
  :bind (([(insert)] . er/expand-region)
	 ([(meta insert)] . overwrite-mode)))
(use-package multiple-cursors
  :ensure t
  :bind (("C->" . mc/mark-next-like-this)
	 ("C-<" . mc/mark-previous-like-this)
	 ("C-*" . mc/mark-all-like-this)))
(use-package neotree
  :ensure t
  :bind ([f8] . neotree-toggle))
;; (use-package ido
;;   :ensure t
;;   :init
;;   (setq ido-enable-flex-matching t)
;;   (setq ido-everywhere t)
;;   (setq ido-use-filename-at-point 'guess)
;;   (ido-mode t)
;;   )
(use-package helm
  ;; :init
  :config
  (helm-mode 1)
  (setq
   ;; helm-scroll-amount 4 ; scroll 4 lines other window using M-<next>/M-<prior>
   ;; helm-quick-update t ; do not display invisible candidates
   ;; helm-idle-delay 0.01 ; be idle for this many seconds, before updating in delayed sources.
   ;; helm-input-idle-delay 0.01 ; be idle for this many seconds, before updating candidate buffer
   ;; helm-split-window-default-side 'other ;; open helm buffer in another window
   helm-split-window-in-side-p t ;; open helm buffer inside current window, not occupy whole other window
   ;; helm-candidate-number-limit 256 ; limit the number of displayed canidates
   ;; helm-move-to-line-cycle-in-source nil ; move to end or beginning of source when reaching top or bottom of source.
   ;; helm-command
   ;; helm-M-x-requires-pattern 0     ; show all candidates when set to 0
   helm-mode-fuzzy-match t
   helm-completion-in-region-fuzzy-match t
   )
  (bind-keys ("M-x" . helm-M-x)
             ("M-y" . helm-show-kill-ring)
             ("M-j" . helm-mini)
	     ("C-j" . helm-find-files)
 	     )
  )
(use-package avy
  :ensure t
  :bind
  ("C-;" . avy-goto-char-timer))
(use-package flycheck
  :ensure t
  :diminish flycheck-mode
  :commands flycheck-mode
  :init (global-flycheck-mode)
  :config
  (setq flycheck-check-syntax-automatically '(save idle-change mode-enabled)))
(use-package avy-flycheck
  :bind
  ("C-c '" . avy-flychck-goto-error))
(use-package org
  :mode (("\\.org$" . org-mode))
  :ensure t
  :config
  (progn
    ;; config stuff
    ))
(use-package verilog-mode
  :load-path "elisp/verilog-mode"
  :mode (("\\.[st]*v[hp]*\\'" . verilog-mode) ;.v, .sv, .svh, .tv, .vp
         ("\\.f\\'"         . verilog-mode)   ;verilog file lists
         ("\\.psl\\'"         . verilog-mode)
         ("\\.vams\\'"        . verilog-mode)
         ("\\.vinc\\'"        . verilog-mode))
  :config
  (progn
    ;; config stuff
    (setq flycheck-verilog-verilator-executable "verilator_bin")
    ))
(use-package markdown-mode
  :ensure t
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "multimarkdown"))
(use-package yaml-mode
  :ensure t
  :init
  (add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode))
  (add-to-list 'auto-mode-alist '("\\.yaml\\'" . yaml-mode)))
(use-package elpy
  :ensure t
  :init
  (elpy-enable)
  (add-hook 'python-mode-hook 'anaconda-mode)
  (when (require 'flycheck nil t)
    (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
    (add-hook 'elpy-mode-hook 'flycheck-mode)))
(use-package py-autopep8
  :after python
  :init
  (add-hook 'python-mode-hook 'py-autopep8-enable-on-save))
(use-package ensime
  :ensure t
  :pin melpa)
(use-package sbt-mode
  :pin melpa)
(use-package scala-mode
  :pin melpa)
(use-package firrtl-mode
  :ensure t)
(use-package smartparens
  :defer)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(cua-mode t nil (cua-base))
 '(current-language-environment "Korean")
 '(debug-on-error t)
 '(fringe-mode (quote (nil . 0)) nil (fringe))
 '(global-display-line-numbers-mode t)
 '(load-theme (quote material) t)
 '(package-selected-packages
   (quote
    (firrtl-mode markdown-mode markdown-preview-mode py-autopep8 flycheck yaml-mode elpy neotree projectile expand-region multiple-cursors material-theme)))
 '(save-place-mode t)
 '(size-indication-mode t)
 '(tool-bar-mode nil))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:foreground "white" :background "black" :family "DejaVu Sans Mono" :foundry "PfEd" :slant normal :weight normal :height 120 :width normal)))))
;;;
;;; for Korean
(set-language-environment "Korean")
(prefer-coding-system 'utf-8)
(set-fontset-font nil 'hangul (font-spec :family "D2Coding"))
(desktop-save-mode 1)
(set-cursor-color "#ffffff") 
;;;
