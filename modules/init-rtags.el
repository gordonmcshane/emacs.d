(use-package rtags
  :init
  (setq rtags-completion-enabled t)
  (setq rtags-autostart-diagnostics nil)
  (setq rtags-spellcheck-enabled nil)
  (rtags-enable-standard-keybindings)
  (require 'company-rtags)
  (add-to-list 'company-backends 'company-rtags)

  ;;(require 'flycheck-rtags)
  ;;(defun my-flycheck-rtags-setup ()
  ;;  (flycheck-select-checker 'rtags)
    ;;(setq-local flycheck-highlighting-mode nil) ;; RTags creates more accurate overlays.
    ;;(setq-local flycheck-check-syntax-automatically nil))
  ;; c-mode-common-hook is also called by c++-mode
    ;;(add-hook 'c-mode-common-hook #'my-flycheck-rtags-setup)
  )

(provide 'init-rtags)
