;; osx doesn't support io notifications :/
(setq auto-revert-use-notify nil)

;; Enable emoji, and stop the UI from freezing when trying to display them.
(set-fontset-font t 'unicode "Apple Color Emoji" nil 'prepend)

;; use homebrew bash 4+
(setq explicit-shell-file-name "/usr/local/bin/bash")

(provide 'init-osx)
