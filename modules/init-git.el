(use-package git-blame
  :commands git-blame-mode)

(use-package gitignore-mode)

(use-package gitconfig-mode)

(use-package git-timemachine
  :commands (git-timemachine))

(use-package git-commit)
(use-package magit
  :init
  (setq-default
   magit-process-popup-time 10
   magit-diff-refine-hunk t
   magit-completing-read-function 'magit-ido-completing-read)
  :config
  (global-set-key (kbd "C-x g") 'magit-status)
  (global-set-key (kbd "C-x M-g") 'magit-dispatch-popup))

(provide 'init-git)
