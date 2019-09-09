(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/")
             t)
(package-initialize)
(when (not (package-installed-p 'use-package))
  (package-refresh-contents)
  (package-install 'use-package))


(use-package flycheck
  :ensure t
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
