(use-package multiple-cursors
  :bind (("C->" . mc/mark-next-like-this)
         ("C-<" . mc/mark-previous-like-this))
  :init
  (setq mc/cmds-to-run-for-all
        '(easy-kill
          org-delete-char
          org-self-insert-command
          c-electric-delete-forward)))

(provide 'init-mc)
