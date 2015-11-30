;; flyspell-mode does spell-checking on the fly as you type
(require 'flyspell)
(setq ispell-program-name "aspell" ; use aspell instead of ispell
      ispell-extra-args '("--sug-mode=ultra"))

(defun try-enable-flyspell ()
  (when (executable-find ispell-program-name)
    (flyspell-mode +1)))

;; enable flyspell for text modes
(add-hook 'text-mode-hook 'try-enable-flyspell)

(provide 'init-flyspell)
