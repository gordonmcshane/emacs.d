;; ensure session dir
(unless (file-exists-p my-session-dir)
  (make-directory my-session-dir))

(setq backup-directory-alist `(("." . ,(expand-file-name "backups" my-init-dir))))

(defvar my-autosaves-dir (expand-file-name "autosaves/" my-init-dir))

(unless (file-exists-p my-autosaves-dir)
  (make-directory my-autosaves-dir))

(setq auto-save-file-name-transforms `((".*" ,my-autosaves-dir t)))
(setq auto-save-list-file-prefix (expand-file-name ".saves-" my-autosaves-dir))

;; I may regret this (Sacha told me too)
;; Never delete old backup versions
(setq delete-old-versions -1)
;; Append numbers to backups
(setq version-control t)
;; Backup files even if they are under version control (git, etc)
(setq vc-make-backup-files t)

(require 'savehist)
(setq history-length t)
(setq history-delete-duplicates t)
(setq savehist-additional-variables
      '(kill-ring search-ring regexp-search-ring)
      savehist-file (expand-file-name "savehist" my-session-dir))

;; pretty sure this defaults to true
(setq savehist-save-minibuffer-history t)
(savehist-mode +1)

;; save recent files
(require 'recentf)
(setq recentf-save-file (expand-file-name "recentf" my-session-dir)
      recentf-max-saved-items 1000
      recentf-max-menu-items 15
      ;; disable recentf-cleanup on Emacs start, because it can cause
      ;; problems with remote files
      recentf-auto-cleanup 'never)

(defun my-recentf-exclude-p (file)
  "A predicate to decide whether to exclude FILE from recentf."
  (let ((file-dir (file-truename (file-name-directory file))))
    (-any-p (lambda (dir)
              (string-prefix-p dir file-dir))
            (mapcar 'file-truename (list my-session-dir package-user-dir)))))

(add-to-list 'recentf-exclude 'my-recentf-exclude-p)

(recentf-mode +1)

(setq desktop-path (list my-session-dir)
      desktop-auto-save-timeout 180)

(setq desktop-globals-to-save
      '((comint-input-ring        . 50)
        (compile-history          . 30)
        desktop-missing-file-warning
        (dired-regexp-history     . 20)
        (extended-command-history . 30)
        (face-name-history        . 20)
        (file-name-history        . 100)
        (grep-find-history        . 30)
        (grep-history             . 30)
        (ido-buffer-history       . 100)
        (ido-last-directory-list  . 100)
        (ido-work-directory-list  . 100)
        (ido-work-file-list       . 100)
        (magit-read-rev-history   . 50)
        (minibuffer-history       . 50)
        (org-clock-history        . 50)
        (org-refile-history       . 50)
        (org-tags-history         . 50)
        (query-replace-history    . 60)
        (read-expression-history  . 60)
        (regexp-history           . 60)
        (regexp-search-ring       . 20)
        register-alist
        (search-ring              . 20)
        (shell-command-history    . 50)
        tags-file-name
        tags-table-list))

(desktop-save-mode 1)

(use-package session
  :init
  (setq session-save-file (expand-file-name ".session" my-session-dir)
        session-name-disable-regexp "\\(?:\\`'/tmp\\|\\.git/[A-Z_]+\\'\\)")
  :config
  (session-initialize))

(provide 'init-session)
