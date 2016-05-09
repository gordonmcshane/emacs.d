;; for homebrew issues:
;;http://stackoverflow.com/questions/24257803/distutilsoptionerror-must-supply-either-home-or-prefix-exec-prefix-not-both

(use-package anaconda-mode
  :commands (anaconda-mode anaconda-eldoc-mode)
  :init
  (setq my-anaconda-user-dir (expand-file-name "anaconda-mode" my-pkg-data-dir))
  (setq anaconda-mode-installation-directory my-anaconda-user-dir)
  :config
  (when (boundp 'company-backends)
    (use-package company-anaconda
      :config
      (add-to-list 'company-backends 'company-anaconda))))

(use-package virtualenvwrapper
  :defer t
  :init
  (setq-default venv-location "/Users/gordon/.py_venvs")
  (venv-initialize-interactive-shells) ;; if you want interactive shell support
  (venv-initialize-eshell)) ;; if you want eshell support

(require 'electric)

;; Copy pasted from ruby-mode.el
(defun python--encoding-comment-required-p ()
  (re-search-forward "[^\0-\177]" nil t))

(defun python--detect-encoding ()
  (let ((coding-system
         (or save-buffer-coding-system
             buffer-file-coding-system)))
    (if coding-system
        (symbol-name
         (or (coding-system-get coding-system 'mime-charset)
             (coding-system-change-eol-conversion coding-system nil)))
      "ascii-8bit")))

(defun python--insert-coding-comment (encoding)
  (let ((newlines (if (looking-at "^\\s *$") "\n" "\n\n")))
    (insert (format "# coding: %s" encoding) newlines)))

(defun python-mode-set-encoding ()
  "Insert a magic comment header with the proper encoding if necessary."
  (save-excursion
    (widen)
    (goto-char (point-min))
    (when (python--encoding-comment-required-p)
      (goto-char (point-min))
      (let ((coding-system (python--detect-encoding)))
        (when coding-system
          (if (looking-at "^#!") (beginning-of-line 2))
          (cond ((looking-at "\\s *#\\s *.*\\(en\\)?coding\\s *:\\s *\\([-a-z0-9_]*\\)")
                 ;; update existing encoding comment if necessary
                 (unless (string= (match-string 2) coding-system)
                   (goto-char (match-beginning 2))
                   (delete-region (point) (match-end 2))
                   (insert coding-system)))
                ((looking-at "\\s *#.*coding\\s *[:=]"))
                (t (python--insert-coding-comment coding-system)))
          (when (buffer-modified-p)
            (basic-save-buffer-1)))))))

(when (fboundp 'exec-path-from-shell-copy-env)
  (exec-path-from-shell-copy-env "PYTHONPATH"))

(defun python-mode-defaults ()
  "Defaults for Python programming."
  (subword-mode +1)
  (anaconda-mode +1)
  (anaconda-eldoc-mode +1)
  (eldoc-mode +1)
  (setq-local electric-layout-rules
              '((?: . (lambda ()
                        (and (zerop (first (syntax-ppss)))
                             (python-info-statement-starts-block-p)
                             'after)))))
  (when (fboundp #'python-imenu-create-flat-index)
    (setq-local imenu-create-index-function
                #'python-imenu-create-flat-index))
  (add-hook 'post-self-insert-hook
            #'electric-layout-post-self-insert-function nil 'local)
  (add-hook 'after-save-hook 'python-mode-set-encoding nil 'local))

(add-hook 'python-mode-hook #'python-mode-defaults)

(provide 'init-python)
