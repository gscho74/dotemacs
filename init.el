(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/")
             t)
(package-initialize)
(when (not (package-installed-p 'use-package))
  (package-refresh-contents)
  (package-install 'use-package))


(use-package flycheck
  :init (global-flycheck-mode)
  :ensure t
  :config
  (setq flycheck-check-syntax-automatically '(mode-enabled idle-buffer-switch idle-change save))
  (setq flycheck-verilog-verilator-executable "~/.emacs.d/invoke-verilator.sh")

  )

(use-package ob-translate
  :ensure t
  :config
  (setq ob-translate:default-dest "ko"))

(use-package tabbar-ruler
  :ensure t
)

(use-package markdown-mode
  :ensure t
)

(use-package folding
  :ensure t
)


(ido-mode t)
(setq ido-enable-flex-matching t
      ido-use-virtual-buffers t)

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
 '(package-selected-packages
   (quote
    (auto-complete multi-term find-file-in-project autopair folding markdown-mode tabbar-ruler ob-translate flycheck use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
