(use-package grep
  :defer t
  :init
  (setq-default grep-highlight-matches t ;; highlight matches
                grep-scroll-output t)
  :config
  (use-package wgrep)) ;; auto-scroll results

(use-package ag
  :defer t
  :init
  (setq-default ag-highlight-search t  ;; highlight the matches
                ag-reuse-buffers t)  ;; reuse one *ag* buffer
  :config
  (use-package wgrep-ag
    :ensure wgrep))

(provide 'init-grep)
