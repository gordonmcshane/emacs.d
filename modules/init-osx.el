;; osx doesn't support io notifications :/

(custom-set-variables
 '(auto-revert-use-notify nil))

;; Enable emoji, and stop the UI from freezing when trying to display them.
(set-fontset-font t 'unicode "Apple Color Emoji" nil 'prepend)

(setq mac-font-panel-mode t)

;; use homebrew bash 4+
(setq explicit-shell-file-name "/usr/local/bin/bash")

(setq calc-gnuplot-default-device "qt")

(provide 'init-osx)
