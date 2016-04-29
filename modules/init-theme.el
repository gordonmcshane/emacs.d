(defun set-my-custom-colors ()
  (let* ((class '((class color) (min-colors 89)))
         (variant 'dark)
         (base00   (if (eq variant 'light) "#FAFAFA" "#151718"))
         (base01   (if (eq variant 'light) "#90A4AE" "#757575"))
         (base02   (if (eq variant 'light) "#78909C" "#9E9E9E"))
         (base03   (if (eq variant 'light) "#546E7A" "#E0E0E0"))
         (yellow   (if (eq variant 'light) "#F57F17" "#FFEE58"))
         (yellow-1 (if (eq variant 'light) "#F9A725" "#FFF59D"))
         (brown    (if (eq variant 'light) "#4E342E" "#BCAAA4"))
         (brown-1  (if (eq variant 'light) "#6D4C41" "#D7CCC8"))
         (orange   (if (eq variant 'light) "#D84315" "#FFCC80"))
         (orange-1 (if (eq variant 'light) "#FF5722" "#FFA726"))
         (red      (if (eq variant 'light) "#D50000" "#E57373"))
         (red-1    (if (eq variant 'light) "#FF1744" "#EF9A9A"))
         (pink     (if (eq variant 'light) "#F8BBD0" "#F8BBD0"))
         (pink-1   (if (eq variant 'light) "#EC407A" "#FF80AB"))
         (purple   (if (eq variant 'light) "#7E57C2" "#E1BEE7"))
         (purple-1 (if (eq variant 'light) "#B388FF" "#9575CD"))
         (blue     (if (eq variant 'light) "#42A5F5" "#64B5F6"))
         (blue-1   (if (eq variant 'light) "#1E88E5" "#42A5F5"))
         (indigo   (if (eq variant 'light) "#5C6BC0" "#C5CAE9"))
         (indigo-1 (if (eq variant 'light) "#9FA8DA" "#7986CB"))
         (cyan     (if (eq variant 'light) "#0097A7" "#80DEEA"))
         (cyan-1   (if (eq variant 'light) "#00B8D4" "#26C6DA"))
         (teal     (if (eq variant 'light) "#26A69A" "#80CBC4"))
         (teal-1   (if (eq variant 'light) "#00897B" "#4DB6AC"))
         (green    (if (eq variant 'light) "#66BB6A" "#C5E1A5"))
         (green-1  (if (eq variant 'light) "#558B2F" "#F4FF81"))
         (base00-1 (if (eq variant 'light)
                       (color-lighten-name base00 3)
                     (color-darken-name base00 3)))
         (base00-2 (if (eq variant 'light)
                       (color-lighten-name base00 5)
                     (color-darken-name base00 5)))
         (base00-3 (if (eq variant 'light)
                       (color-lighten-name base00 10)
                     (color-darken-name base00 10)))
         (base00+1 (if (eq variant 'light)
                       (color-darken-name base00 2)
                     (color-lighten-name base00 2)))
         (base00+2 (if (eq variant 'light)
                       (color-darken-name base00 8)
                     (color-lighten-name base00 8)))
         (base00+3 (if (eq variant 'light)
                       (color-darken-name base00 12)
                     (color-lighten-name base00 12)))
         (light-emphasis (if (eq variant 'light) base00+3 base00-3))
         (light-emphasis-1 (if (eq variant 'light) base00+2 base00-2))
         (light-emphasis-2 (if (eq variant 'light) base00+1 base00-1))
         (flashing-color (if (eq variant 'light) pink (color-darken-name pink 25)))
         (highlight-line-color (if (eq variant 'light) base00-1 base00+1)))
    (custom-theme-set-faces 'apropospriate-dark
                            ;;'(flycheck-error ((t :box (:line-width 1 :color "#e57373" :style nil))))
                            ;;`(default ((t :background "#151718" :foreground ,base03)))
                            `(aw-background-face ((t (:foreground ,base00+3))))
                            `(aw-leading-char-face ((t (:foreground ,pink-1 :background nil :weight bold))))
                            '(fringe ((t :background "#353535")))
                            '(which-func ((t (:inherit font-lock-function-name-face)))) ;; which-func-face tries to be too smart
                            ;;`(diff-hl-insert ((t (:foreground ,green :background "#66BB6A"))))
                            `(whitespace-trailing ((t (:background ,base00-2 :foreground ,yellow))))
                            `(whitespace-empty ((t (:background ,base00-2 :foreground ,yellow)))))))

;; temporarily increase stack-size to allow apropospriate
;; to use large apply call
(let ((max-lisp-eval-depth 3000)
      (max-specpdl-size 3000))
  (use-package apropospriate-theme
    :config
    (load-theme 'apropospriate-dark t)
    (set-my-custom-colors)
    (set-frame-font "Source Code Pro" nil t)
    (set-mouse-color "white")
    (set-face-attribute 'default nil :height 141 :weight 'light)))

(provide 'init-theme)
