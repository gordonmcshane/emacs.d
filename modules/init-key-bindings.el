;; kill lines backward
(global-set-key (kbd "C-<backspace>") (lambda ()
                                        (interactive)
                                        (kill-line 0)
                                        (indent-according-to-mode)))

;; lets see if we like cycle-spacing
(global-set-key [remap just-one-space] 'cycle-spacing)
(global-set-key (kbd "M-o") 'smart-open-line)
(global-set-key [(shift return)] 'smart-open-line)
(global-set-key [f6] 'recompile)
(global-set-key [f7] 'recompile-all)
(global-set-key (kbd "C-+") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)

(provide 'init-key-bindings)
