(setq load-prefer-newer t)

(defvar my-init-dir (file-name-directory load-file-name)
  "The root directory of my init")
(defvar my-init-modules-dir (expand-file-name "modules" my-init-dir)
  "Individual modules of my .emacs.d")
(defvar my-session-dir (expand-file-name "session" my-init-dir)
  "Where session files go")

;; give customized values symbols their own file
(setq custom-file (expand-file-name "custom.el" my-init-dir))

;; add modules dir to load-path
(add-to-list 'load-path my-init-modules-dir)

;; fix osx modifiers, do this before init.el errors happen
(when (boundp 'mac-function-modifier)
  (setq mac-function-modifier 'hyper))

(when (boundp 'mac-option-modifier)
  (setq mac-option-modifier 'meta))

(when (boundp 'mac-command-modifier)
  (setq mac-command-modifier 'super))

(require 'init-packaging)
(require-package 'diminish)

(require 'init-core)
(when (eq system-type 'darwin)
  (require 'init-osx))
(require 'init-path)
(require 'init-gui)
(require 'init-session)
(require 'init-editing)
(require 'init-ido)
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
(require 'init-elisp)
(require 'init-cxx)
(require 'init-yas)
(require 'init-misc-modes)
(require 'init-guide-key)
(require 'init-key-bindings)

(require 'server)
(when (and (not (server-running-p)) window-system)
  (server-start))
