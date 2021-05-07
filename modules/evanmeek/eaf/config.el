;;; evanmeek/eaf/config.el -*- lexical-binding: t; -*-


(use-package! eaf
  :commands (eaf-open eaf-search-it eaf-open-browser eaf-open-bookmark eaf-open-browser-with-history)
  :custom
  (eaf-find-alternate-file-in-dired t)
  (eaf-proxy-type "socks5")
  (eaf-proxy-host "127.0.0.1")
  (eaf-proxy-port "1088")
  :config
  (use-package! ctable)
  (use-package! deferred)
  (use-package! epc)
  (require 'eaf-evil)

  (define-key key-translation-map (kbd "SPC")
    (lambda (prompt)
      (if (derived-mode-p 'eaf-mode)
          (pcase eaf--buffer-app-name
            ("browser" (if  (string= (eaf-call-sync "call_function" eaf--buffer-id "is_focus") "True")
                           (kbd "SPC")
                         (kbd eaf-evil-leader-key)))
            ("pdf-viewer" (kbd eaf-evil-leader-key))
            ("image-viewer" (kbd eaf-evil-leader-key))
            (_  (kbd "SPC")))
        (kbd "SPC"))))
  (defalias 'browse-web #'eaf-open-browser)
  ;; (setq eaf-browser-default-search-engine "google")
  (setq eaf-browser-default-search-engine "duckduckgo")
  (eaf-setq eaf-browse-blank-page-url "https://google.com")
  (eaf-setq eaf-browser-enable-adblocker "true")
  (eaf-setq eaf-browser-default-zoom "1.2")
  (eaf-bind-key scroll_up "C-n" eaf-pdf-viewer-keybinding)
  (eaf-bind-key scroll_down "C-p" eaf-pdf-viewer-keybinding)
  (eaf-bind-key take_photo "p" eaf-camera-keybinding)
  (eaf-bind-key nil "x" eaf-browser-keybinding)
  (eaf-bind-key eaf-proxy-insert_or_close_buffer "C-S-x" eaf-browser-keybinding)
  (setq mouse-avoidance-banish-position '((frame-or-window . frame)
                                          (side . right)
                                          (side-pos . 100)
                                          (top-or-bottom . bottom)
                                          (top-or-bottom-pos . -100)))
  (mouse-avoidance-mode 'banish))
  ;; :commands (eaf-open eaf-search-it eaf-open-browser eaf-open-bookmark eaf-open-browser-with-history)
(map! :leader
      (:prefix ("a" . "app")
       (:prefix ("e" . "EAF")
        :desc "智能打開" "o" #'eaf-open
        :desc "立即搜索" "s" #'eaf-search-it
        :desc "打開網頁" "b" #'eaf-open-browser
        :desc "打開書籤" "m" #'eaf-open-bookmark
        :desc "歷史記錄" "h" #'eaf-open-browser-with-history
        (:after eaf
         :desc "下載管理" "e" #'eaf-proxy-open_download_manage_page
         :desc "打開攝像" "c" #'eaf-open-camera
         :desc "打開導圖" "p" #'eaf-open-mindmap
         :desc "創建導圖" "l" #'eaf-create-mindmap
         :desc "重啓EAF" "r" #'eaf-restart-process
         :desc "打開終端" "t" #'eaf-open-terminal)
        )))
