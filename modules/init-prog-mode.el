(require 'which-func)
(which-function-mode 1)

(defun local-comment-auto-fill ()
  (set (make-local-variable 'comment-auto-fill-only-comments) t))

(defun common-prog-mode-defaults ()
  "Default coding hook, useful with any programming language."
  (when (executable-find ispell-program-name)
    (flyspell-prog-mode))

  (smartparens-mode +1)
  (enable-whitespace-for-buffer)
  (local-comment-auto-fill)
  (linum-mode +1)
  (subword-mode +1)
  ;;(prelude-font-lock-comment-annotations)
  )

(add-hook 'prog-mode-hook 'common-prog-mode-defaults)

(provide 'init-prog-mode)
