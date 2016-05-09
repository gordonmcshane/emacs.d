(defun gdm/with-yas (backend) (list backend :with 'company-yasnippet))

(use-package yasnippet
  :defer 2
  :init
  (setq yas-prompt-functions '(yas/ido-prompt
                               yas/dropdown-prompt
                               yas/completing-prompt
                               yas/no-prompt))

  (defvar gdm/yas-disabled-modes '(term-mode erc-mode comint-mode))
  (defun gdm/disabled-yas-modes-p (mode)
    (memq mode gdm/yas-disabled-modes))

  :config

  (defvar gdm/yas-mode-line (concat " " (propertize "\uf02d" 'face '((:family "FontAwesome")))))

  (yas-global-mode +1)
  (add-hook 'yas-dont-activate-functions (lambda () (gdm/disabled-yas-modes-p major-mode)))
  (diminish 'yas-minor-mode gdm/yas-mode-line))

(provide 'init-yas)
