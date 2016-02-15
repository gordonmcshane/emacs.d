(use-package rust-mode
  :config
  (add-to-list 'auto-mode-alist '("\\.rs\\'" . rust-mode))
  (use-package flycheck-rust
    :config
    (add-hook 'flycheck-mode-hook #'flycheck-rust-setup))
  (use-package racer
    :init
    (defvar racer-cmd "/Users/gordon/bin/racer/target/release/racer")
    (defvar racer-rust-src-path "/usr/local/src/rust/src")
    :config
    (add-hook 'rust-mode-hook #'racer-mode)
    (add-hook 'racer-mode-hook #'eldoc-mode)
    (add-hook 'racer-mode-hook #'company-mode))
  (use-package cargo
    :config
    (add-hook 'rust-mode-hook 'cargo-minor-mode))
  (use-package rustfmt
    :init
    (defvar rustfmt-bin "/Users/gordon/.multirust/toolchains/nightly/cargo/bin/rustfmt")))

(provide 'init-rust)
