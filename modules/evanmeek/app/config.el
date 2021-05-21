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
  (telega-mode-line-mode 1)
  (define-key telega-msg-button-map "k" nil))

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
  (setq rime-user-data-dir (concat doom-etc-dir "rime" "/"))
  (setq rime-share-data-dir (concat doom-etc-dir "rime" "/"))
  (setq rime-posframe-properties
        (list :background-color "#333333"
              :foreground-color "#dcdccc"
              ;; :font evan/en-font-name
              :internal-border-width 10))
  (setq default-input-method "rime"
        rime-show-candidate 'posframe))
  ;; (setq rime-disable-predicates '(rime-predicate-evil-mode-p)))
(use-package shengci
  :commands (shengci-capture-word-and-save
             shengci-show-recorded-word
             shengci-show-memorized-word))


(use-package! bongo
  :commands (bong-init-all)
  :custom
  (bongo-header-line-mode nil)
  (bongo-mode-line-indicator-mode nil)
  (bongo-global-lastfm-mode nil)
  (bongo-mode-line-icon-size 10))

(map! :leader
      (:prefix ("a" . "app")
       :desc "Bongo-Init歌单" "B" #'bongo-init-all))
