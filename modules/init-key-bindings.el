;; kill lines backward
(global-set-key (kbd "C-<backspace>") (lambda ()
                                        (interactive)
                                        (kill-line 0)
                                        (indent-according-to-mode)))

;; lets see if we like cycle-spacing
(global-set-key [remap just-one-space] 'cycle-spacing)
(global-set-key [f6] 'recompile)
(global-set-key [f7] 'recompile-all)

(provide 'init-key-bindings)
