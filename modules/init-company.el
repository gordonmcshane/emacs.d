(use-package company
  :diminish company-mode "co"
  :init
  (setq company-idle-delay 0.25
        company-tooltip-limit 50
        company-show-numbers t
        company-minimum-prefix-length 1
        company-tooltip-flip-when-above t)
  :config
  (global-company-mode 1))

(use-package pos-tip)
(use-package company-quickhelp
  :config
  (company-quickhelp-mode +1))

(provide 'init-company)
