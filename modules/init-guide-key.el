(use-package guide-key
  :diminish guide-key-mode
  :init
  (setq guide-key/guide-key-sequence t ;;'("C-x" "C-c" "C-x 4" "C-x 5" "C-c ;" "C-c ; f" "C-c ' f" "C-x n" "C-x C-r" "C-x r"))
        guide-key/idle-delay 1.0
        guide-key/popup-window-position 'bottom)
  :config
  (guide-key-mode +1))

(use-package discover-my-major
  :commands (discover-my-major discover-my-mode)
  :bind (("C-h C-m" . discover-my-major)
         ("C-h M-m" . discover-my-mode)))

(provide 'init-guide-key)
