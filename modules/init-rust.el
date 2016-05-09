(use-package rust-mode
  :commands rust-mode
  :init
  (add-to-list 'auto-mode-alist '("\\.rs\\'" . rust-mode))
  :config
  (use-package flycheck-rust
    :commands flycheck-rust-setup
    :init
    (add-hook 'flycheck-mode-hook #'flycheck-rust-setup))
  (use-package racer
    :commands racer-mode
    :init
    (defvar racer-cmd "/Users/gordon/bin/racer/target/release/racer")
    (defvar racer-rust-src-path "/usr/local/src/rust/src")
    (add-hook 'rust-mode-hook #'racer-mode)
    (add-hook 'racer-mode-hook #'eldoc-mode)
    (add-hook 'racer-mode-hook #'company-mode))
  (use-package cargo
    :commands cargo-minor-mode
    :init
    (add-hook 'rust-mode-hook #'cargo-minor-mode))
  (use-package rustfmt
    :commands (rustfmt-enable-on-save rustfmt-format-buffer)
    :init
    (defvar rustfmt-bin "/Users/gordon/.multirust/toolchains/nightly/cargo/bin/rustfmt")))

(provide 'init-rust)
