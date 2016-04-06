(use-package gitignore-mode
  :defer t)
(use-package gitconfig-mode
  :defer t)
(use-package git-blame
  :defer t)
(use-package git-timemachine
  :defer t)
(use-package git-commit
  :defer t)

(use-package magit
  :bind (("C-x g" . magit-status)
         ("C-x M-g" . magit-dispatch-popup))
  :demand
  :init
  (setq-default
   magit-process-popup-time 10
   magit-diff-refine-hunk t
   magit-completing-read-function 'magit-ido-completing-read))

(provide 'init-git)
