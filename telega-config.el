;;; ~/.doom.d/telega-config.el -*- lexical-binding: t; -*-

(setq telega-proxies
      (list '(:server "127.0.0.1" :port 1080 :enable t
                      :type (:@type "proxyTypeSocks5"))))
(add-hook! '(telega-root-mode-hook telega-chat-mode-hook) #'evil-emacs-state)
(add-hook! 'telega-chat-mode-hook :append
           #'yas-minor-mode
           (lambda ()
             (set-company-backend! 'telega-chat-mode
               (append '(telega-company-emoji
                         telega-company-username
                         telega-company-hashtag)
                       (when (telega-chat-bot-p telega-chatbuf--chat)
                         '(telega-company-botcmd))))
             (company-mode 1)))
(add-hook 'telega-chat-pre-message-hook #'telega-msg-ignore-blocked-sender)
(set-popup-rule! "^\\*Telega Root"
  :side 'right :size 95 :quit nil :modeline t)
(set-popup-rule! "^◀\\(\\[\\|<\\|{\\).*\\(\\]\\|>\\|}\\)"
  :side 'right :size 95 :quit nil :modeline t)
(telega-mode-line-mode 1)
