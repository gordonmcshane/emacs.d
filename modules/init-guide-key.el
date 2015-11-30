(use-package guide-key
  :diminish guide-key-mode
  :defer 1
  :init
  (setq guide-key/guide-key-sequence t) ;;'("C-x" "C-c" "C-x 4" "C-x 5" "C-c ;" "C-c ; f" "C-c ' f" "C-x n" "C-x C-r" "C-x r"))
  (setq guide-key/idle-delay 1.0)
  (setq guide-key/popup-window-position 'bottom)
  :config
  (guide-key-mode +1))

(provide 'init-guide-key)
