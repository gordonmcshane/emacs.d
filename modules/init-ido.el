(use-package ido
  :init
  (setq ido-enable-prefix nil
        ido-enable-flex-matching t
        ido-create-new-buffer 'always
        ido-use-filename-at-point 'guess
        ido-max-prospects 10
        ido-save-directory-list-file (expand-file-name "ido.hist" my-session-dir)
        ido-default-file-method 'selected-window
        ido-auto-merge-work-directories-length -1)
  :config
  (ido-mode +1)
  (ido-everywhere +1)
  (use-package ido-ubiquitous
    :config
    (ido-ubiquitous-mode +1))
  (use-package flx-ido
    :init
    ;; disable ido faces to see flx highlights
    (setq ido-use-faces nil)
    :config
    ;;; smarter fuzzy matching for ido
    (flx-ido-mode +1))
  ;; smex, remember recently and most frequently used commands
  (use-package smex
    :init
    (setq smex-save-file (expand-file-name ".smex-items" my-session-dir))
    :config
    (smex-initialize)
    (global-set-key [remap execute-extended-command] 'smex)
    :bind
     ("M-X" . smex-major-mode-commands)))

(provide 'init-ido)
