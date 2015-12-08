(defun cmake-mode-defaults ()
  (subword-mode +1))

(use-package cmake-mode
  :config
  (add-hook 'cmake-mode-hook
            'cmake-mode-defaults))

(provide 'init-cmake)
