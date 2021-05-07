;;; evanmeek/app/config.el -*- lexical-binding: t; -*-

(use-package! telega
  :defer
  :init (setq telega-proxies
              '((:server "localhost"
                 :port "1088"
                 :enable t
                 :type (:@type "proxyTypeSocks5")))
              telega-chat-show-avatars nil)
  (setq telega-chat-fill-column 65)
  (setq telega-emoji-use-images t)
  :config
  (set-fontset-font t 'unicode (font-spec :family "Symbola") nil 'prepend)
  (setq telega-completing-read-function 'ivy-completing-read)
  (telega-notifications-mode t)
  (telega-mode-line-mode 1))

(defun toggle-telega ()
  "切換telega"
  (interactive)
  (if (get-buffer "*Telega Root*")
      (telega-kill t)
    (telega t)))
(map! :leader
      :desc "Telega"
      :n "t t" #'toggle-telega)
(map! :leader
      (:prefix ("a" . "app")
       (:prefix ("t" . "Telega")
        :desc "Telega Switch Chat" "c" #'telega-chat-with)))
(use-package! rime
  :config
  (setq default-input-method "rime")
  ;; (setq rime-user-data-dir "~/.emacs.d/var/rime")
  ;; (setq rime-share-data-dir "~/.emacs.d/var/rime")
  (setq rime-posframe-properties
        (list :background-color "#333333"
              :foreground-color "#dcdccc"
              ;; :font evan/en-font-name
              :internal-border-width 10))
  (setq default-input-method "rime"
        rime-show-candidate 'posframe)
  ;; (setq rime-disable-predicates '(rime-predicate-evil-mode-p))
  )
