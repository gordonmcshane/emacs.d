
;; osx doesn't support io notifications :/
(setq auto-revert-use-notify nil)

;; Enable emoji, and stop the UI from freezing when trying to display them.
(set-fontset-font t 'unicode "Apple Color Emoji" nil 'prepend)

(set-frame-font "Source Code Pro" nil t)
(set-face-attribute 'default nil :height 141 :weight 'light)

(provide 'init-osx)
