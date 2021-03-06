;; Character encodings default to utf-8.
(prefer-coding-system 'utf-8)
(set-language-environment 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)

(setq-default indent-tabs-mode nil)   ;; don't use tabs to indent
(setq-default tab-width 8)            ;; but maintain correct appearance
(setq-default save-interprogram-paste-before-kill t) ;; store os clipboard entry to kill ring
(setq sentence-end-double-space nil)

;; enable narrowing commands
(put 'narrow-to-region 'disabled nil)
(put 'narrow-to-page 'disabled nil)
(put 'narrow-to-defun 'disabled nil)

;; enabled change region case commands
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)

;; enable erase-buffer command
(put 'erase-buffer 'disabled nil)

(use-package expand-region
  :bind ("C-=" . er/expand-region))

;; Newline at end of file is managed by ethan-wspace
(setq require-final-newline nil
      mode-require-final-newline nil
      c-require-final-newline nil)

;; delete the selection with a keypress
(delete-selection-mode nil)

(use-package autorevert
  :ensure nil
  :init
  ;; lets not spam the message buffer when we change branches, etc
  (setq auto-revert-verbose nil)
  ;; revert non-file buffers when stale (trialing this)
  (setq global-auto-revert-non-file-buffers t)
  ;; diminish auto revert minor mode
  (setq auto-revert-mode-text (propertize " " 'face '((:family "FontAwesome"))))
  ;; revert buffers automatically when underlying files are changed externally
  ;;(global-auto-revert-mode +1)
  (custom-set-variables '(global-auto-revert-mode t))
  )

;; smart tab behavior - indent or complete
(setq tab-always-indent 'complete)

;; global mode for pseudo-ligatures
(when (fboundp 'global-prettify-symbols-mode)
  (global-prettify-symbols-mode))

;; meaningful names for buffers with the same name
(use-package uniquify
  :ensure nil
  :init
  (setq uniquify-buffer-name-style 'forward) ; /foo/baz/filename
  (setq uniquify-separator "/")
  (setq uniquify-after-kill-buffer-p t)       ; rename after killing uniquified
  (setq uniquify-ignore-buffers-re "^\\*"))   ; don't muck with special buffers

(use-package saveplace
  :ensure nil
  :init
  ;; saveplace remembers your location in a file when saving files
  (setq save-place-file (expand-file-name "saveplace" my-session-dir))
  ;; activate it for all buffers
  (setq-default save-place t))

(defun smart-move-beginning-of-line (arg)
  "Move point back to indentation of beginning of line.
Move point to the first non-whitespace character on this line.
If point is already there, move to the beginning of the line.
Effectively toggle between the first non-whitespace character and
the beginning of the line.
If ARG is not nil or 1, move forward ARG - 1 lines first.  If
point reaches the beginning or end of the buffer, stop there."
  (interactive "^p")
  (setq arg (or arg 1))

  ;; Move lines first
  (when (/= arg 1)
    (let ((line-move-visual nil))
      (forward-line (1- arg))))

  (let ((orig-point (point)))
    (back-to-indentation)
    (when (= orig-point (point))
      (move-beginning-of-line 1))))

(global-set-key [remap move-beginning-of-line]
                'smart-move-beginning-of-line)

(require 'tabify)
(defmacro with-region-or-buffer (func)
  "When called with no active region, call FUNC on current buffer."
  `(defadvice ,func (before with-region-or-buffer activate compile)
     (interactive
      (if mark-active
          (list (region-beginning) (region-end))
        (list (point-min) (point-max))))))

(with-region-or-buffer indent-region)
(with-region-or-buffer untabify)

(use-package bookmark
  :ensure nil
  :init
  (setq bookmark-default-file (expand-file-name "bookmarks" my-session-dir)
        bookmark-save-flag 1))

(use-package smartparens
  :commands smartparens-mode
  :diminish "()"
  :init
  (setq sp-base-key-bindings 'paredit)
  ;;(setq sp-autoskip-closing-pair 'always)
  (setq sp-hybrid-kill-entire-symbol nil)
  :config
  (require 'smartparens-config)
  (sp-use-paredit-bindings)
  (show-smartparens-global-mode nil)
  ;; smart curly braces
  (sp-pair "{" nil :post-handlers
           '(((lambda (&rest _ignored)
                (smart-open-line-above)) "RET"))))

;; transient-mark-mode is on by default, but force anyway
(transient-mark-mode +1)

;; people say this is more intuitive than the builtin undo system
(use-package undo-tree
  :init (global-undo-tree-mode)
  :diminish undo-tree-mode)

;; lets us see what is being changed when we query/replace
(use-package anzu
  :diminish anzu-mode
  :bind (("M-%" . anzu-query-replace)
         ("C-M-%" . anzu-query-replace-regexp))
  :init (global-anzu-mode t))

;; DEL during isearch should edit the search string, not jump back to the previous result
(define-key isearch-mode-map [remap isearch-delete-char] 'isearch-del-char)

;; Activate occur easily inside isearch
(define-key isearch-mode-map (kbd "C-o") 'isearch-occur)

;; better kill-ring browsing
(use-package browse-kill-ring
  :init
  (browse-kill-ring-default-keybindings))

(use-package projectile
  :init
  (projectile-global-mode t)
  (setq projectile-cache-file (expand-file-name  "projectile.cache" my-session-dir)
	projectile-known-projects-file (expand-file-name "projectile-bookmarks.eld" my-session-dir))
  (setq projectile-mode-line '((:propertize "  " face ((:family "FontAwesome" :inherit which-func))) "["
			       (:propertize
				(:eval (when (ignore-errors (projectile-project-root))
					 (projectile-project-name)))
				face which-func
                                mouse-face mode-line-highlight)
			       "]")) ;; unnecessarily cool projectile modeline format

  (add-to-list 'projectile-project-root-files-top-down-recurring "CMakeLists.txt"))

(setq semanticdb-default-save-directory
      (expand-file-name "semanticdb" my-session-dir))

;; automatically save buffers associated with files on buffer switch
;; and on windows switch
(defun prelude-auto-save-command ()
  "Save the current buffer if `prelude-auto-save' is not nil."
  (when (and buffer-file-name
             (buffer-modified-p (current-buffer))
             (file-writable-p buffer-file-name))
    (save-buffer)))

(defmacro advise-commands (advice-name commands class &rest body)
  "Apply advice named ADVICE-NAME to multiple COMMANDS.
The body of the advice is in BODY."
  `(progn
     ,@(mapcar (lambda (command)
                 `(defadvice ,command (,class ,(intern (concat (symbol-name command) "-" advice-name)) activate)
                    ,@body))
               commands)))

;; advise all window switching functions
(advise-commands "auto-save"
                 (switch-to-buffer other-window windmove-up windmove-down windmove-left windmove-right)
                 before
                 (prelude-auto-save-command))

(add-hook 'mouse-leave-buffer-hook 'prelude-auto-save-command)

(when (version<= "24.4" emacs-version)
  (add-hook 'focus-out-hook 'prelude-auto-save-command))

;; highlight the current line
(global-hl-line-mode +1)

(use-package volatile-highlights
  :diminish volatile-highlights-mode
  :init (volatile-highlights-mode t))

(use-package zop-to-char
  :bind ("M-z" . zop-to-char))

(use-package easy-kill
  :bind (("M-w" . easy-kill)
         ("C-M-@" . easy-mark)))

;; tramp, for sudo access
(use-package tramp
  :ensure nil
  :init (setq tramp-default-method "ssh")) ;; keep in mind known issues with zsh - see emacs wiki

(set-default 'imenu-auto-rescan t)

(use-package diff-hl
  :init
  (global-diff-hl-mode +1)
  (add-hook 'dired-mode-hook 'diff-hl-dired-mode))

;; ediff - don't start another frame
(use-package ediff
  :ensure nil
  :init
  (setq ediff-window-setup-function 'ediff-setup-windows-plain))

;; abbrev config
(add-hook 'text-mode-hook 'abbrev-mode)

;; enable on-the-fly reindentation
(when (eval-when-compile (version< "24.4" emacs-version))
  (electric-indent-mode 1))

(defvar prelude-yank-indent-threshold 1000)
(defvar prelude-indent-sensitive-modes nil)
(defvar prelude-yank-indent-modes nil)

;; automatically indenting yanked text if in programming-modes
(defun yank-advised-indent-function (beg end)
  "Do indentation, as long as the region isn't too large."
  (if (<= (- end beg) prelude-yank-indent-threshold)
      (indent-region beg end nil)))

(advise-commands "indent" (yank yank-pop) after
                 "If current mode is one of `prelude-yank-indent-modes',
indent yanked text (with prefix arg don't indent)."
                 (if (and (not (ad-get-arg 0))
                          (not (member major-mode prelude-indent-sensitive-modes))
                          (or (derived-mode-p 'prog-mode)
                              (member major-mode prelude-yank-indent-modes)))
                     (let ((transient-mark-mode nil))
                       (yank-advised-indent-function (region-beginning) (region-end)))))

(use-package string-inflection
  :bind (("C-c i" . string-inflection-cycle)
         ("C-c C" . string-inflection-camelcase)        ;; Force to CamelCase
         ("C-c L" . string-inflection-lower-camelcase)  ;; Force to lowerCamelCase
         ("C-c J" . string-inflection-java-style-cycle))) ;; Cycle through Java styles)

(provide 'init-editing)
