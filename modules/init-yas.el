(defun gdm/get-mode-hook (mode) (intern (concat (symbol-name mode) "-hook")))

(use-package yasnippet
  :defer 2
  :init
  (defvar gdm/yas-mode-line (concat " " (propertize "\uf02d" 'face '((:family "FontAwesome")))))

  (setq yas-prompt-functions '(yas/ido-prompt
                               yas/dropdown-prompt
                               yas/completing-prompt
                               yas/no-prompt))

  (defun gdm/yas-disable-hook ()
    (setq yas-dont-activate t))

  (defvar gdm/yas-disabled-modes '(term-mode erc-mode comint-mode))

  (-each
      gdm/yas-disabled-modes
    (lambda (mode) (add-hook (gdm/get-mode-hook mode) #'gdm/yas-disable-hook)))

  :config
  (yas-global-mode +1)
  (diminish 'yas-minor-mode gdm/yas-mode-line))

(provide 'init-yas)
