(use-package gitignore-mode)
(use-package gitconfig-mode)

(use-package git-timemachine
  :commands (git-timemachine
             git-timemachine-toggle
             git-timemachine-switch-branch))

(use-package git-commit
  :commands global-git-commit-mode)

(use-package magit
  :bind (("C-x g" . magit-status)
         ("C-x M-g" . magit-dispatch-popup))
  :init
  (global-magit-file-mode t)
  (setq-default
   magit-process-popup-time 10
   magit-diff-refine-hunk t
   magit-delete-by-moving-to-trash t
   magit-completing-read-function 'magit-ido-completing-read
   magit-log-arguments '("--decorate" "--color")))

(provide 'init-git)
