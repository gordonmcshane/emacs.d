(use-package flycheck
  :diminish " ✓"
  :commands flycheck-mode
  :init
  (setq flycheck-display-errors-function #'flycheck-display-error-messages-unless-error-list)
  (add-hook 'prog-mode-hook #'flycheck-mode))

(provide 'init-flycheck)
