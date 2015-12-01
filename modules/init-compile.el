;; Compilation from Emacs
(defun colorize-compilation-buffer ()
  "Colorize a compilation mode buffer."
  (interactive)
  ;; we don't want to mess with child modes such as grep-mode, ack, ag, etc
  (when (eq major-mode 'compilation-mode)
    (let ((inhibit-read-only t))
      (ansi-color-apply-on-region (point-min) (point-max)))))

(require 'compile)
(setq compilation-ask-about-save nil  ; Just save before compiling
      compilation-always-kill t       ; Just kill old compile processes before
                                        ; starting the new one
      compilation-scroll-output 'first-error ; Automatically scroll to first
                                        ; error
      )

;; Colorize output of Compilation Mode, see
;; http://stackoverflow.com/a/3072831/355252
(require 'ansi-color)
(add-hook 'compilation-filter-hook #'colorize-compilation-buffer)

(with-eval-after-load 'compile
  (defadvice compilation-start (after gdm/save-last-compilation-buffer activate)
    "Record the compilation buffer for use later"
    ;; see last line of `compilation-start'
    (setq gdm/last-compilation-buffer next-error-last-buffer))

  (defadvice recompile (around gdm/find-last-compilation-buffer (&optional edit-command) activate)
    "Use last compilation buffer if available"
    (if (and (null edit-command)
             (not (derived-mode-p 'compilation-mode))
             gdm/last-compilation-buffer
             (buffer-live-p gdm/last-compilation-buffer))
        (with-current-buffer gdm/last-compilation-buffer
          ad-do-it)
      ad-do-it)))

(defun recompile-all ()
  (interactive)
  (dolist (buf (buffer-list))
    (with-current-buffer buf
      (when (eq major-mode 'compilation-mode)
        (setq gdm/last-compilation-buffer nil)
        (recompile)))))

(provide 'init-compile)
