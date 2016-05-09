(use-package company
  :init
  (setq company-lighter-base "©")
  (setq company-idle-delay 0.25
        company-tooltip-limit 50
        company-show-numbers t
        company-minimum-prefix-length 2
        company-tooltip-flip-when-above t
        ;; leave case unchanged when suggesting things from dabbrev
        company-dabbrev-downcase nil)

  :config
  (global-company-mode +1)

  (setq company-backends (delete 'company-semantic company-backends))
  (setq company-backends (delete 'company-clang company-backends))

  ;; let yas-snippet play too
  (require 'dash)

  (defun add-yas-snippet (backend)
    (cond
     ((symbolp backend) (gdm/with-yas backend))
     (t backend)))

  ;;(setq company-backends (-map #'add-yas-snippet company-backends))

  (use-package company-quickhelp
    :if window-system
    :config
    (company-quickhelp-mode +1)))

(provide 'init-company)
