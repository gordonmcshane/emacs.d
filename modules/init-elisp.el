(require 'init-lisp)

(use-package elisp-slime-nav
  :defer t
  :diminish elisp-slime-nav-mode)
(use-package rainbow-mode
  :defer t
  :diminish rainbow-mode)
(use-package eldoc
  :defer t
  :diminish eldoc-mode)

(defun my-recompile-elc-on-save ()
  "Recompile your elc when saving an elisp file."
  (add-hook 'after-save-hook
            (lambda ()
              (when (and
                     (string-prefix-p my-init-dir (file-truename buffer-file-name))
                     (file-exists-p (byte-compile-dest-file buffer-file-name)))
                (emacs-lisp-byte-compile)))
            nil
            t))

(defun my-visit-ielm ()
  "Switch to default `ielm' buffer.
Start `ielm' if it's not already running."
  (interactive)
  (start-or-switch-to 'ielm "*ielm*"))

(define-key emacs-lisp-mode-map (kbd "C-c C-z") 'my-visit-ielm)
(define-key emacs-lisp-mode-map (kbd "C-c C-c") 'eval-defun)
(define-key emacs-lisp-mode-map (kbd "C-c C-b") 'eval-buffer)

(defun conditional-emacs-lisp-checker ()
  "Don't check doc style in Emacs Lisp test files."
  (let ((file-name (buffer-file-name)))
    (when (and file-name (string-match-p ".*-tests?\\.el\\'" file-name))
      (setq-local flycheck-checkers '(emacs-lisp)))))

(defun emacs-lisp-mode-defaults ()
  "Sensible defaults for `emacs-lisp-mode'."
  (run-hooks 'lispy-modes-hook)
  (eldoc-mode +1)
  (my-recompile-elc-on-save)
  (rainbow-mode +1)
  (setq mode-name "ELisp")
  (conditional-emacs-lisp-checker))

(setq my-emacs-lisp-mode-hook 'emacs-lisp-mode-defaults)

(add-hook 'emacs-lisp-mode-hook (lambda ()
                                  (run-hooks 'my-emacs-lisp-mode-hook)))

(add-auto-mode 'emacs-lisp-mode "Cask\\'")

;; ielm is an interactive Emacs Lisp shell
(defun ielm-mode-defaults ()
  "Sensible defaults for `ielm'."
  (run-hooks 'interactive-lispy-modes-hook)
  (eldoc-mode +1))

(setq my-ielm-mode-hook #'ielm-mode-defaults)

(add-hook 'ielm-mode-hook (lambda ()
                            (run-hooks 'my-ielm-mode-hook)))

(eval-after-load "ielm"
  '(progn
     (define-key ielm-map (kbd "M-(") (my-wrap-with "("))
     (define-key ielm-map (kbd "M-\"") (my-wrap-with "\""))))

;; enable elisp-slime-nav-mode
(dolist (hook '(emacs-lisp-mode-hook ielm-mode-hook))
  (add-hook hook #'elisp-slime-nav-mode))

(defun conditionally-enable-smartparens-mode ()
  "Enable `smartparens-mode' in the minibuffer, during `eval-expression'."
  (if (eq this-command 'eval-expression)
      (smartparens-mode 1)))

(add-hook 'minibuffer-setup-hook #'conditionally-enable-smartparens-mode)

(provide 'init-elisp)
