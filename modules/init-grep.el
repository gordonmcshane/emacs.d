(use-package grep
  :ensure nil
  :init
  (setq-default grep-highlight-matches t ;; highlight matches
                grep-scroll-output t)  ;; auto-scroll results
  (use-package wgrep))

(use-package ag
  :init
  (setq-default ag-highlight-search t  ;; highlight the matches
                ag-reuse-buffers t)  ;; reuse one *ag* buffer
  (use-package wgrep-ag))

(provide 'init-grep)
