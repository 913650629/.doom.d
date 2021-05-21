;;; evanmeek/tools/config.el -*- lexical-binding: t; -*-
(use-package! go-translate
  :commands (go-translate-popup-current)
  :init
  (setq go-translate-base-url "https://translate.google.cn")
  (setq go-translate-local-language "zh-CN")
  (setq go-translate-token-current (cons 430675 2721866130)))

(map! :leader
      (:prefix ("a" . "app")
       (:desc "go-translate" "g" #'go-translate-popup-current)))


(use-package! disable-mouse
  :hook (after-init . (lambda ()
                        (global-disable-mouse-mode 1))))
