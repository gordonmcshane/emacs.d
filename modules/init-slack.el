(use-package slack
  :commands (slack-start)
  :init
  (setq slack-enable-emoji t) ;; if you want to enable emoji, default nil
  (setq slack-prefer-current-team t)
  :config
  (require 'slack-config)
  (gdm/register-for-slack))

(provide 'init-slack)
