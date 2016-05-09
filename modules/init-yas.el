(use-package yasnippet
  :diminish yas-minor-mode
  :defer 15
  :init
  (setq yas-prompt-functions '(yas/ido-prompt
                               yas/dropdown-prompt
                               yas/completing-prompt
                               yas/no-prompt))

  (yas-global-mode +1)
  (add-hook 'term-mode-hook (lambda () (yas-minor-mode -1))))

(provide 'init-yas)
