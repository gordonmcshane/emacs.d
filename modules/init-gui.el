;; if tool-bar-mode is available, turn it off
(when (fboundp 'tool-bar-mode)
  (tool-bar-mode -1))

;; no tooltips
(tooltip-mode -1)
;; no menu bars
(menu-bar-mode -1)
;; no scroll bars
(when (fboundp 'set-scroll-bar-mode)
  (set-scroll-bar-mode nil))

;; solid cursor
(blink-cursor-mode -1)

;; not a huge bell fan
(setq ring-bell-function 'ignore)

;; disable os file dialog
(setq use-file-dialog nil)
;; disable os dialogs
(setq use-dialog-box nil)
;; disable the default buffer
(setq inhibit-startup-screen t)
;; disable startup message in echo area
(setq inhibit-startup-echo-area-message t)

;; accept y/n in lieu of yes/no
(fset 'yes-or-no-p 'y-or-n-p)

;; important stuff in the modeline
(line-number-mode t)
(column-number-mode t)
(size-indication-mode t)

;; undo/redo for window layout changes
(winner-mode +1)

;; more useful frame title, that show either a file or a
;; buffer name (if the buffer isn't visiting a file)
(setq frame-title-format
      '("" invocation-name " - " (:eval (if (buffer-file-name)
                                            (abbreviate-file-name (buffer-file-name))
                                          "%b"))))

;;(let ((no-border '(internal-border-width . 0)))
;;  (add-to-list 'default-frame-alist no-border)
;;  (add-to-list 'initial-frame-alist no-border))

;; i like big fringes
(fringe-mode '(15 . 10))

(use-package ace-window
  :bind (("C-x O" . ace-window)))

(provide 'init-gui)
