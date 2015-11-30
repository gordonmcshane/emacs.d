(use-package flycheck
  :config
  (setq flycheck-display-errors-function #'flycheck-display-error-messages-unless-error-list)
  (global-flycheck-mode +1))

(use-package flycheck-pos-tip
  :config
  (flycheck-pos-tip-mode))

(provide 'init-flycheck)
