;;; .doom.d/config.el -*- lexical-binding: t; -*-

(set-frame-font "Iosevka 22")


(load-theme'doom-dracula t)
;;(load-theme 'doom-acario-light t)


(push '("\\.cl\\'" . lisp-mode)auto-mode-alist)

;; google-translate
(load "~/.doom.d/google-translate-chinese.el")
(load "~/.doom.d/telega-config.el")
(global-set-key (kbd "C-c C") 'google-translate-chinese-at-point-echo-area)

(image-type-available-p "imagemagick")
