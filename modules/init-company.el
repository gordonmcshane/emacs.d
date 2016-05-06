(use-package company
  :diminish company-mode "  ©"
  :commands (company-mode global-company-mode)
  :init
  (setq company-idle-delay 0.25
        company-tooltip-limit 50
        company-show-numbers t
        company-minimum-prefix-length 2
        company-tooltip-flip-when-above t
        ;; leave case unchanged when suggesting things from dabbrev
        company-dabbrev-downcase nil)
  ;;(global-company-mode 1)
  (add-hook 'prog-mode-hook 'company-mode)
  (add-hook 'comint-mode-hook 'company-mode)
  :config
  (setq company-backends (delete 'company-semantic company-backends))
  (use-package company-quickhelp
    :if window-system
    :config
    (company-quickhelp-mode +1)))

(provide 'init-company)

