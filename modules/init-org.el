(use-package org
  :ensure org-plus-contrib
  :pin org
  :config
  (add-to-list 'org-export-backends 'md))

(provide 'init-org)
