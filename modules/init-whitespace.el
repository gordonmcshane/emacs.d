;; whitespace-mode config
(require 'whitespace)
(setq whitespace-line-column 120) ;; >80  for my windows friends
(setq whitespace-style '(face tabs empty trailing lines-tail))

(use-package ethan-wspace
  :diminish ethan-wspace-mode
  :init
  (global-ethan-wspace-mode +1))

;;(defun my-buffer-cleanup ()
;;  TODO ethan-wspace
;;  (whitespace-cleanup))

(defun enable-whitespace-for-buffer ()
  "Enable `whitespace-mode'"
  ;; keep the whitespace decent all the time (in this buffer)
  ;; (add-hook 'before-save-hook 'my-buffer-cleanup nil t)
  ;; fix faces ugh
  (whitespace-mode +1))

;; superseded by ethan-wspace
(add-hook 'text-mode-hook 'enable-whitespace-for-buffer)

(provide 'init-whitespace)
