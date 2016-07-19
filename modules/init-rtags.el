(use-package rtags
  :load-path "/usr/local/share/emacs/site-lisp/rtags"
  :ensure nil
  :init
  (setq rtags-completions-enabled t)
  (setq rtags-autostart-diagnostics t)
  (setq rtags-spellcheck-enabled nil)

  :config
  (rtags-enable-standard-keybindings)
  (rtags-diagnostics)
  ;; currently irony provides better company support
  ;; (with-eval-after-load 'company
  ;;   (progn
  ;;     (require 'company-rtags)
  ;;     (add-to-list 'company-backends 'company-rtags)))

  ;;(require 'flycheck-rtags)
  ;;(defun my-flycheck-rtags-setup ()
  ;;  (flycheck-select-checker 'rtags)
    ;;(setq-local flycheck-highlighting-mode nil) ;; RTags creates more accurate overlays.
    ;;(setq-local flycheck-check-syntax-automatically nil))
  ;; c-mode-common-hook is also called by c++-mode
    ;;(add-hook 'c-mode-common-hook #'my-flycheck-rtags-setup)
  )

(provide 'init-rtags)
