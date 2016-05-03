(setq load-prefer-newer t)

(defvar my-init-dir (file-name-directory load-file-name)
  "The root directory of my init")
(defvar my-lisp-dir (expand-file-name "lisp" my-init-dir)
  "Modules not in elpa")
(defvar my-init-modules-dir (expand-file-name "modules" my-init-dir)
  "Individual modules of my .emacs.d")
(defvar my-personal-config-dir (expand-file-name "~/.personal")
  "Personal config details")
(defvar my-session-dir (expand-file-name "session" my-init-dir)
  "Where session files go")
(defvar my-pkg-data-dir (expand-file-name "pkg-data" my-init-dir)
  "Where platform specific package files go (irony-mode server, anaconda-mode server, etc)")

;; give customized values symbols their own file
(setq custom-file (expand-file-name "custom.el" my-init-dir))

;; add local source first
(add-to-list 'load-path (expand-file-name "cc-mode" my-lisp-dir))
;; add modules dir to load-path
(add-to-list 'load-path my-init-modules-dir)
;; add personal dir to load-path
(add-to-list 'load-path my-personal-config-dir)

;; fix osx modifiers, do this before init.el errors happen
(when (boundp 'mac-function-modifier)
  (setq mac-function-modifier 'hyper))

(when (boundp 'mac-option-modifier)
  (setq mac-option-modifier 'meta))

(when (boundp 'mac-command-modifier)
  (setq mac-command-modifier 'super))

(require 'init-packaging)

(require 'init-core)
(when (eq system-type 'darwin)
  (require 'init-osx))
(require 'init-path)
(require 'init-gui)
(require 'init-session)
(require 'init-editing)
;;(require 'init-ido)
(require 'init-ivy)
(require 'init-ibuffer)
(require 'init-compile)
(require 'init-dired)
(require 'init-grep)
(require 'init-hippie)
(require 'init-company)
(require 'init-flyspell)
(require 'init-flycheck)
(require 'init-whitespace)
(require 'init-git)
(require 'init-theme)
(require 'init-prog-mode)
(require 'init-org)
(require 'init-mc)
(require 'init-elisp)
(require 'init-cxx)
(require 'init-rtags)
(require 'init-rust)
(require 'init-python)
(require 'init-yas)
(require 'init-misc-modes)
(require 'init-guide-key)
(require 'init-key-bindings)
(require 'init-slack)

(require 'server)
(when (and (not (server-running-p)) window-system)
  (server-start))
