(use-package bind-key)

;; ethan-wspace supercedes the need for this
(setq c-require-final-newline '())

(defun smart-c-indent (arg)
  (interactive "P")
  (if mark-active
      (indent-region (region-beginning) (region-end))
    (c-indent-command arg)))

(defun cc-mode-common-defaults ()
  (setq c-default-style "k&r"
        c-basic-offset 4)
  ;; lets use comment-dwim so we can can C-c C-c to comment/uncomment
  (define-key c-mode-base-map [remap comment-region] 'comment-dwim)
  (c-set-offset 'substatement-open 0)
  (c-toggle-hungry-state 1)
  (bind-key "<tab>" 'smart-c-indent c-mode-base-map))

(defvar my-c-mode-common-hook #'cc-mode-common-defaults)

(add-hook 'my-c-mode-common-hook #'common-prog-mode-defaults)

;; this will affect all modes derived from cc-mode, like
;; java-mode, php-mode, etc
(add-hook 'c-mode-common-hook (lambda ()
                                (run-hooks 'my-c-mode-common-hook)))

;; tabs are needed here
(defun makefile-mode-defaults ()
  (whitespace-toggle-options '(tabs))
  (setq indent-tabs-mode t))

(defvar my-makefile-mode-hook 'makefile-mode-defaults)

(add-hook 'makefile-mode-hook (lambda ()
                                (run-hooks 'my-makefile-mode-hook)))

(defun followed-by (cases)
  (cond ((null cases) nil)
        ((assq (car cases)
               (cdr (memq c-syntactic-element c-syntactic-context))) t)
        (t (followed-by (cdr cases)))))

(defun setup-namespace-indent-rules ()
  (c-set-offset 'innamespace
                '(lambda (x)
                   (if (followed-by '(innamespace namespace-close))
                       0
                     '+)))
  (c-set-offset 'inline-open 0))

;; force .h files to use c++-mode
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.inl\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.ipp\\'" . c++-mode))

(add-hook 'c++-mode-hook #'setup-namespace-indent-rules)

(defun my-valid-noise-names (x)
  (or (listp x) (stringp x)))

(defcustom custom-c-noise-macro-names () "Tap-in for .dir-local noise macro names" :safe #'my-valid-noise-names)

(defun my-recreate-noise-regexps ()
  (when (and (derived-mode-p 'c++-mode)
             (fboundp 'c-make-noise-macro-regexps)
             (not (null custom-c-noise-macro-names)))
    (set (make-local-variable 'c-noise-macro-names)
         (cond
          ((listp custom-c-noise-macro-names) (append c-noise-macro-names custom-c-noise-macro-names))
          ((stringp custom-c-noise-macro-names) (cons custom-c-noise-macro-names c-noise-macro-names))
          (t c-noise-macro-names)))
    (c-make-noise-macro-regexps)))

(add-hook 'hack-local-variables-hook #'my-recreate-noise-regexps)

(defun my-irony-mode-hook ()
  (define-key irony-mode-map [remap completion-at-point]
    'irony-completion-at-point-async)
  (define-key irony-mode-map [remap complete-symbol]
    'irony-completion-at-point-async)
  (company-irony-setup-begin-commands)
  (irony-cdb-autosetup-compile-options))

(use-package irony
  :commands irony-mode irony-cdb-autosetup-compile-options
  :init
  (setq my-irony-user-dir (expand-file-name "irony" my-pkg-data-dir))
  (setq irony-server-install-prefix my-irony-user-dir
        irony-user-dir my-irony-user-dir)

  (add-hook 'irony-mode-hook #'my-irony-mode-hook)

  (use-package company-irony
    :commands (company-irony company-irony-setup-begin-commands)
    :init
    (with-eval-after-load 'company
      (add-to-list 'company-backends #'company-irony)))

  (use-package company-irony-c-headers
    :commands company-irony-c-headers
    :init
    (with-eval-after-load 'company
      (add-to-list 'company-backends #'company-irony-c-headers)))

  (use-package flycheck-irony
    :commands flycheck-irony-setup
    :init
    (with-eval-after-load 'flycheck
      (add-hook 'flycheck-mode-hook #'flycheck-irony-setup)))

  (use-package irony-eldoc
    :commands irony-eldoc
    :init
    (with-eval-after-load 'irony
      (add-hook 'irony-mode-hook #'irony-eldoc))))

(add-hook 'c-mode-hook #'irony-mode)
(add-hook 'c++-mode-hook #'irony-mode)

(use-package cpputils-cmake
  :init
  (setq cppcm-write-flymake-makefile nil)
  (add-hook 'c-mode-common-hook
            (lambda ()
              (when (derived-mode-p 'c-mode 'c++-mode)
                (cppcm-reload-all)))))

(provide 'init-cxx)
