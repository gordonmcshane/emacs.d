(provide 'init-yas)

(use-package yasnippet
  :config
  (setq yas-prompt-functions '(yas/ido-prompt
                             yas/dropdown-prompt
                             yas/completing-prompt
                             yas/no-prompt))
  (yas-global-mode +1))
