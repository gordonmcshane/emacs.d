(use-package rainbow-delimiters
  :commands rainbow-delimiters-mode)

(setq-default initial-scratch-message
              (concat ";; Happy hacking " user-login-name " - Emacs ♥ you!\n\n"))

;; Lisp configuration
(define-key read-expression-map (kbd "TAB") 'completion-at-point)

;; wrap keybindings
(define-key lisp-mode-shared-map (kbd "M-(") (my-wrap-with "("))
;; FIXME: Pick terminal-friendly binding.
;;(define-key lisp-mode-shared-map (kbd "M-[") (my-wrap-with "["))
(define-key lisp-mode-shared-map (kbd "M-\"") (my-wrap-with "\""))

;; a great lisp coding hook
(defun lisp-coding-defaults ()
  (smartparens-strict-mode +1)
  (rainbow-delimiters-mode +1))

(setq lispy-modes-hook 'lisp-coding-defaults)

;; interactive modes don't need whitespace checks
(defun interactive-lisp-coding-defaults ()
  (smartparens-strict-mode +1)
  (rainbow-delimiters-mode +1)
  (whitespace-mode -1))

(setq interactive-lispy-mode-hook 'interactive-lisp-coding-defaults)

(provide 'init-lisp)
