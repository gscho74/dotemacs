(require 'package)
(setq package-archives
      '(("elpa"     . "https://elpa.gnu.org/packages/")
        ("melpa-stable" . "https://stable.melpa.org/packages/")
        ("melpa"        . "https://melpa.org/packages/"))
      package-archive-priorities
      '(
        ("melpa"        . 10)
        ("elpa"     . 5)
        ("melpa-stable" . 0)
        ))

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

(use-package flycheck
  :init (global-flycheck-mode)
  :ensure t
  :config
  (setq flycheck-check-syntax-automatically '(mode-enabled idle-buffer-switch idle-change save))
  (setq flycheck-verilog-verilator-executable "~/.emacs.d/invoke-verilator.sh")

  )

;;(use-package helm
;;  :init (require `helm-config)
;;  :config
;;  (helm-mode 1)
;;  (setq
   ;; helm-scroll-amount 4 ; scroll 4 lines other window using M-<next>/M-<prior>
   ;; helm-quick-update t ; do not display invisible candidates
   ;; helm-idle-delay 0.01 ; be idle for this many seconds, before updating in delayed sources.
   ;; helm-input-idle-delay 0.01 ; be idle for this many seconds, before updating candidate buffer
   ;; helm-split-window-default-side 'other ;; open helm buffer in another window
;;   helm-split-window-in-side-p t ;; open helm buffer inside current window, not occupy whole other window
   ;; helm-candidate-number-limit 256 ; limit the number of displayed canidates
   ;; helm-move-to-line-cycle-in-source nil ; move to end or beginning of source when reaching top or bottom of source.
   ;; helm-command
   ;; helm-M-x-requires-pattern 0     ; show all candidates when set to 0
;;   helm-mode-fuzzy-match t
;;   helm-completion-in-region-fuzzy-match t
;;   )
;;  (bind-keys ("M-x" . helm-M-x)
;;             ("M-y" . helm-show-kill-ring)
;;             ("M-j" . helm-mini)
;;         ("C-j" . helm-find-files)
;;         )
;;  )


(use-package neotree
  :ensure t
  :bind ([C-f1] . neotree-project-dir)
  :bind ([C-f2] . neotree-toggle))
;;  :bind ([C-f1] . neotree-toggle))

(defun neotree-project-dir ()
    "Open NeoTree using the git root."
    (interactive)
    (let ((project-dir (ffip-project-root))
          (file-name (buffer-file-name)))
      (if project-dir
          (progn
            (neotree-dir project-dir)
            (neotree-find file-name))
        (message "Could not find git project root."))))

;;(define-key map (kbd "C-c C-p") 'neotree-project-dir)

;;(defun neotree-project-dir ()
;;    "Open NeoTree using the git root."
;;    (interactive)
;;    (let ((project-dir (projectile-project-root))
;;          (file-name (buffer-file-name)))
;;      (neotree-toggle)
;;      (if project-dir
;;          (if (neo-global--window-exists-p)
;;              (progn
;;                (neotree-dir project-dir)
;;                (neotree-find file-name)))
;;        (message "Could not find git project root."))))
;; (global-set-key [C-c C-p] 'neotree-project-dir)


(use-package ob-translate
  :ensure t
  :config
  (setq ob-translate:default-dest "ko"))

(use-package tabbar-ruler
  :ensure t
)

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

(use-package folding
  :ensure t
)


(use-package ido
  :ensure t
  :init
  (setq ido-enable-flex-matching t)
  (setq ido-everywhere t)
  (setq ido-use-filename-at-point 'guess)
  (ido-mode t)
)

;;(ido-mode t)
;;(setq ido-enable-flex-matching t
;;      ido-use-virtual-buffers t)

(use-package autopair
  :ensure t
  :config
  (require 'autopair)
  )

(use-package find-file-in-project
  :ensure t
  )

(use-package multi-term
  :ensure t
  :config
  (setq multi-term-program "/bin/bash")
  )

(use-package auto-complete
  :ensure t
  :config
  (ac-config-default)
  )

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#212526" "#ff4b4b" "#b4fa70" "#fce94f" "#729fcf" "#e090d7" "#8cc4ff" "#eeeeec"])
 '(column-number-mode t)
 '(custom-enabled-themes (quote (deeper-blue)))
 '(default
	((t
	  (:family "DejaVu Sans Mono" :foundry "unknown" :slant normal :weight normal :height 101 :width normal))))
 '(inhibit-startup-screen t)
 '(menu-bar-mode nil)
 '(package-selected-packages
   (quote
	(projectile py-autopep8 helm auto-complete multi-term autopair folding firrtl-mode ensime elpy yaml-mode markdown-mode tabbar-ruler ob-translate neotree flycheck use-package)))
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


;;;
;;;
;;; User Function
(setq default-tab-width 4)
(setq x-alt-keysym 'meta)

(defun my-verilog-hook ()
    (setq indent-tabs-mode nil)
    (setq tab-width 4))
 (add-hook 'verilog-mode-hook 'my-verilog-hook)


(defun kill-other-buffers ()
      "Kill all other buffers."
      (interactive)
      (mapc 'kill-buffer (delq (current-buffer) (buffer-list))))

(global-set-key (kbd "C-x C-b") 'kill-other-buffers)
