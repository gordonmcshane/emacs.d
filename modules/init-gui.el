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

;; hide mouse while typing
(setq make-pointer-invisible t)

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

;; allow pasting selection outside of emacs
(setq x-select-enable-clipboard t)

;; more useful frame title, that show either a file or a
;; buffer name (if the buffer isn't visiting a file)
(setq frame-title-format
      '("" invocation-name " - " (:eval (if (buffer-file-name)
                                            (abbreviate-file-name (buffer-file-name))
                                          "%b"))))

(setq linum-format " %4d ")

;; Disable cursor display in inactive windows.
(setq-default cursor-in-non-selected-windows nil)

;; Redraw without pause while processing input.
(setq redisplay-dont-pause t)

;; i like big fringes
;;(fringe-mode '(15 . 10))

(use-package ace-window
  :bind (("C-x o" . ace-window)))

;; diminish some modes.
(use-package simple
  :ensure nil
  :diminish visual-line-mode)
(use-package abbrev
  :ensure nil
  :diminish abbrev-mode)

(defvar gdm/fixed-font-name "Fira Code")
(defvar gdm/fixed-font-weight 'light)
(defvar gdm/var-font-name "Input Serif")
(defvar gdm/font-height 130)

(defun gdm/window-setup ()
    (when (fboundp 'menu-bar-mode) (menu-bar-mode -1))
    (when (fboundp 'tool-bar-mode) (tool-bar-mode -1))
    (when (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
    (run-with-idle-timer 0.1 nil (lambda () (toggle-frame-maximized)))
    (set-fringe-mode '(8 . 0))
    (set-face-attribute
     'default nil
     :family gdm/fixed-font-name
     :height gdm/font-height
     :weight gdm/fixed-font-weight)
    (set-face-attribute
     'linum nil
     :family gdm/fixed-font-name
     :height (- gdm/font-height 20)
     :weight gdm/fixed-font-weight)
    (set-face-attribute
     'variable-pitch
     nil
     :family gdm/var-font-name))

(add-hook 'window-setup-hook #'gdm/window-setup)

(provide 'init-gui)
