(provide 'init-yas)

(use-package yasnippet
  :diminish yas-minor-mode
  :defer 15
  :init
  (setq yas-prompt-functions '(yas/ido-prompt
                               yas/dropdown-prompt
                               yas/completing-prompt
                               yas/no-prompt))
  :config
  (yas-global-mode +1))
