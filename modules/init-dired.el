(use-package dired
  :ensure nil
  :init
  ;; guess directory based on other frame dired windows
  (setq-default dired-dwim-target t)

  ;; always delete and copy recursively
  (setq dired-recursive-deletes 'always)
  (setq dired-recursive-copies 'always)

  ;; dired - reuse current buffer by pressing 'a'
  (put 'dired-find-alternate-file 'disabled nil)

  ;; get a more capable 'ls' on osx if available
  (let ((gls (executable-find "gls")))
    (when gls (setq insert-directory-program gls)))

  ;; fancy dired
  (use-package dired+
    :init
    (setq-default diredp-hide-details-initially-flag nil)
    :config
    (global-dired-hide-details-mode -1))

  ;; adds a few interactive sorting commands
  (use-package dired-sort))

(provide 'init-dired)
