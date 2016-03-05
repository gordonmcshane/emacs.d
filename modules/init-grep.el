(use-package grep
  :init
  (setq-default grep-highlight-matches t ;; highlight matches
                grep-scroll-output t)
  :config
  (use-package wgrep)) ;; auto-scroll results

(use-package ag
  :init
  (setq-default ag-highlight-search t  ;; highlight the matches
                ag-reuse-buffers t)  ;; reuse one *ag* buffer
  :config
  (use-package wgrep-ag))

(provide 'init-grep)
