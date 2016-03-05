(use-package flycheck
  :config
  (setq flycheck-display-errors-function #'flycheck-display-error-messages-unless-error-list)
  (use-package flycheck-pos-tip
    :ensure pos-tip
    :config
    (flycheck-pos-tip-mode))
  (global-flycheck-mode +1)
)

(provide 'init-flycheck)
