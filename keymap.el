;;; keymap.el -*- lexical-binding: t; -*-
(map! :leader
      (:prefix ("t" . "toggle")
       :desc "切换透明" "e" #'+evan/toggle-transparency))
(map! :leader
      (:prefix ("a" . "app")
       :desc "增加亮度" "=" #'+evan/plus-backlight
       :desc "减少亮度" "-" #'+evan/less-backlight))
(map! :leader
      (:prefix ("a" . "app")
       :desc "减少透明度" "1" (lambda () (interactive) (sanityinc/adjust-opacity nil -2))
       :desc "增加透明度" "2" (lambda () (interactive) (sanityinc/adjust-opacity nil 2))))

(map! :leader
      (:prefix ("t" . "toggle")
       :desc "Open Elisp Scratch" "E" #'open-elisp-scratch))
