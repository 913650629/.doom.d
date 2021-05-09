;;; evanmeek/blog/autoloads.el -*- lexical-binding: t; -*-

;;;###autoload
(defun blog/save-and-publish-website()
  "Save all buffers and publish."
  (interactive)
  (when (yes-or-no-p "Really save and publish current project?")
    (save-some-buffers t)
    (org-publish-project "website" t)
    (message "Site published done.")))
;;;###autoload
(defun blog/save-and-publish-statics ()
  "Just copy statics like js, css, and image file .etc."
  (interactive)
  (org-publish-project "statics" t)
  (message "Copy statics done."))
;;;###autoload
(defun blog/save-and-publish-file ()
  "Save current buffer and publish."
  (interactive)
  (save-buffer t)
  (org-publish-current-file t))
;;;###autoload
(defun blog/delete-org-and-html ()
  "Delete current org and the relative html when it exists."
  (interactive)
  (when (yes-or-no-p "Really delete current org and the relative html?")

    (let ((fileurl (concat "~/Documents/site/public/" (file-name-base (buffer-name)) ".html")))
      (if (file-exists-p fileurl)
          (delete-file fileurl))
      (delete-file (buffer-file-name))
      (kill-this-buffer)
      (message "Delete org and the relative html done."))))
;;;###autoload
(defun blog/just-delete-relative-html ()
  "Just delete the relative html when it exists."
  (interactive)
  (when (yes-or-no-p "Really delete the relative html?")
    (let ((fileurl (concat "~/Documents/site/public/" (file-name-base (buffer-name)) ".html")))
      (if (file-exists-p fileurl)
          (progn
            (delete-file fileurl)
            (message "Delete the relative html done."))
        (message "None relative html.")))))
;;;###autoload
(defun blog/create-article (&optional filename)
  (interactive "s文章名: ")
  (if (file-exists-p "~/Documents/site/org/index.org")
      (cl-block nil
        (let ((title filename)
              (filename (concat "~/Documents/site/org/" filename ".org")))
          (when (file-exists-p filename)
            (find-file filename)
            (cl-return t))
          (progn
            (message "%s" filename)
            (find-file filename)
            (save-buffer)
            (insert "#+SETUPFILE: ../theme-rose.setup\n")
            ;; #+DATE: <2020-09-19 六>
            (insert (concat "#+DATE: " (format-time-string "<%Y-%m-%d %a>" (current-time)) "\n"))
            (insert (concat "#+TITLE: " (if title
                                            title
                                          (read-string "文章名: "))))
            (insert "\n\n"))))
    (message "文件目录不存在!请手动创建.")))

;;;###autoload
(defun blog/preview-current-buffer-in-browser ()
  "Open current buffer as html."
  (interactive)
  (let ((fileurl (concat "http://127.0.0.1:8080/" (file-name-base (buffer-name)) ".html")))
    (blog/save-and-publish-file)
    (unless (httpd-running-p) (httpd-start))
    (browse-url fileurl)))
