(require 'cl)

(defmacro gdm/init-theme (package-name theme-name)
  (let ((overrides-path (gensym)))
    `(let ((,overrides-path (expand-file-name (concat "themes/" (symbol-name ',theme-name) "-overrides.el") my-init-dir)))
       (use-package ,package-name
         :init
         (load-theme ',theme-name t)
         (when (file-exists-p ,overrides-path)
           (load (file-name-sans-extension ,overrides-path) nil t))))))

(gdm/init-theme darkokai-theme darkokai)

(provide 'init-theme)
