;;; evanmeek/blog/config.el -*- lexical-binding: t; -*-


(use-package! ox-html
  :after org
  :custom
  (user-full-name "Evan Meek"))

(progn
  "Settings of `org-export'."
  (setq org-export-in-background t
        ;; Hide html built-in style and script.
        org-html-htmlize-output-type 'inline-css
        org-html-head-include-default-style nil
        org-html-head-include-scripts nil))

(define-minor-mode blog/auto-save-and-publish-file-mode
  "Toggle auto save and publish current file."
  :global nil
  :lighter ""
  (if blog/auto-save-and-publish-file-mode
      ;; When the mode is enabled
      (progn
        (add-hook 'after-save-hook #'blog/save-and-publish-file :append :local))
    ;; When the mode is disabled
    (remove-hook 'after-save-hook #'blog/save-and-publish-file :local)))

(use-package! ox-publish
  :after org
  :config
  (setq org-publish-project-alist
        '(("orgfiles"
           :base-directory "~/Documents/site/org/" ;; local dir
           :publishing-directory "~/Documents/site/public/" ;; :publishing-directory "/ssh:jack@192.112.245.112:~/Documents/site/public/"
           :base-extension "org"
           :recursive t
           :publishing-function org-html-publish-to-html
           :headline-levels 4	;; org-export-headline-levels
           :section-numbers nil		;; org-export-with-section-numbers
           :with-author "Evan Meek" ;; org-export-with-author
           :with-priority t ;; org-export-with-priority ;
           :with-toc t ;; org-export-with-toc
           :html-doctype "html5" ;; org-html-doctype
           :table-of-contents t
           )
          ("js"
           :base-directory "~/Documents/site/js/"
           :base-extension "js"
           :publishing-directory "~/Documents/site/public/js/"
           :recursive t
           :publishing-function org-publish-attachment)
          ("css"
           :base-directory "~/Documents/site/css/"
           :base-extension "css"
           :publishing-directory "~/Documents/site/public/css/"
           :recursive t
           :publishing-function org-publish-attachment)
          ("images"
           :base-directory "~/Documents/site/images/"
           :base-extension "jpg\\|gif\\|png\\|svg\\|gif"
           :publishing-directory "~/Documents/site/public/images/"
           :recursive t
           :publishing-function org-publish-attachment)
          ("assets"
           :base-directory "~/Documents/site/assets/"
           :base-extension "mp3"
           :publishing-directory "~/Documents/site/public/assets/"
           :recursive t
           :publishing-function org-publish-attachment)
          ("webfonts"
           :base-directory "~/Documents/site/webfonts/"
           :base-extension "eot\\|svg\\|ttf\\|woff\\|woff2"
           :publishing-directory "~/Documents/site/public/webfonts/"
           :recursive t
           :publishing-function org-publish-attachment)
          ("website" :components ("orgfiles" "js" "css" "images" "assets" "webfonts"))
          ("statics" :components ("js" "css" "images" "assets" "webfonts")))))

(use-package! simple-httpd
  :defer
  :custom
  (httpd-root "~/Documents/site/public"))



(map! :leader
      (:prefix ("a" . "app")
       (:prefix ("b" . "Blog")
        :desc "保存并发布博客" "p" #'blog/save-and-publish-website
        :desc "保存并发布静态" "s" #'blog/save-and-publish-statics
        :desc "保存并发布当前Buffer" "f" #'blog/save-and-publish-file
        :desc "删除当前org文件及HTML文件" "d" #'blog/delete-org-and-html
        :desc "仅删除HTML文件" "r" #'blog/just-delete-relative-html
        :desc "创建博文" "c" #'blog/create-article
        :desc "预览博文" "P" #'blog/preview-current-buffer-in-browser)))
