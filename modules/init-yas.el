(provide 'init-yas)

(use-package yasnippet
  :diminish yas-minor-mode
  :config
  (setq yas-prompt-functions '(yas/ido-prompt
                               yas/dropdown-prompt
                               yas/completing-prompt
                               yas/no-prompt))
  (yas-global-mode +1))
