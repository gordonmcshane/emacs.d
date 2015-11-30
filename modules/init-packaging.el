(require 'package)

(defun require-package (package &optional min-version no-refresh)
  "Install given PACKAGE, optionally requiring MIN-VERSION.
If NO-REFRESH is non-nil, the available package lists will not be
re-downloaded in order to locate PACKAGE."
  (if (package-installed-p package min-version)
      t
    (if (or (assoc package package-archive-contents) no-refresh)
        (if (boundp 'package-selected-packages)
            ;; Record this as a package the user installed explicitly
            (package-install package nil)
          (package-install package))
      (progn
        (package-refresh-contents)
        (require-package package min-version t)))))

(setq package-user-dir (expand-file-name "elpa" my-init-dir))
(setq package-enable-at-startup nil)

;; slow today
;;(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives `("melpa" . ,(if (< emacs-major-version 24)
                                              "http://melpa.org/packages/"
                                              "https://melpa.org/packages/")))

;; if exception happens in `package-initialize'
;; try clearing out emacs.d/elpa/archives/melpa/archive-contents
(package-initialize)

(require-package 'use-package)

;; details of loading in messages
;;(setq use-package-verbose t)

;; always get from melpa if missing
(setq use-package-always-ensure t)

(require 'use-package)

(provide 'init-packaging)
