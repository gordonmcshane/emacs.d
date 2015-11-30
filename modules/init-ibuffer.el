;; TODO: enhance ibuffer-fontification-alist
;;   See http://www.reddit.com/r/emacs/comments/21fjpn/fontifying_buffer_list_for_emacs_243/

(setq-default ibuffer-show-empty-filter-groups nil)

(setq ibuffer-filter-group-name-face 'font-lock-doc-face)

;; group ibuffer by vc roots
(defun ibuffer-set-up-preferred-filters ()
  (ibuffer-vc-set-filter-groups-by-vc-root)
  (unless (eq ibuffer-sorting-mode 'filename/process)
    (ibuffer-do-sort-by-filename/process)))

(use-package ibuffer-vc
  :config
  (add-hook 'ibuffer-hook 'ibuffer-set-up-preferred-filters))

(global-set-key (kbd "C-x C-b") 'ibuffer)

(provide 'init-ibuffer)
