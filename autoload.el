;;; autoload.el -*- lexical-binding: t; -*-
;;;###autoload
(defun +evan/toggle-transparency ()
  (interactive)
  (let ((alpha (frame-parameter nil 'alpha)))
    (set-frame-parameter
     nil 'alpha
     (if (eql (cond ((numberp alpha) alpha)
                    ((numberp (cdr alpha)) (cdr alpha))
                    ;; Also handle undocumented (<active> <inactive>) form.
                    ((numberp (cadr alpha)) (cadr alpha)))
              100)
         '(90 . 90) '(100 . 100)))))

;; 检查设置背光文件是否有写入权限
;;;###autoload
(defun +evan/check-backlight-write-permission ()
  (let ((check (string-trim-right (shell-command-to-string "sh ~/Documents/script/check-backlight-file.sh"))))
    (if (string= check "t")
        t
      (progn
        (with-temp-buffer
          (cd "/sudo::/")
          (shell-command "chmod ugoa+w /sys/class/backlight/intel_backlight/brightness"))))))


;; 增加10%屏幕亮
;;;###autoload
(defun +evan/plus-backlight ()
  (interactive)
  (+evan/check-backlight-write-permission)
  (let* (
         ;; 最大亮度
         (max-backlight (string-to-number (string-trim-right
                                           (shell-command-to-string "cat /sys/class/backlight/intel_backlight/max_brightness"))))
         ;; 当前亮度
         (current-backlight (string-to-number (string-trim-right
                                               (shell-command-to-string "cat /sys/class/backlight/intel_backlight/brightness"))))
         ;; 增加后的亮度
         (add-backlight (+ current-backlight (* max-backlight 0.1))))
    (if (< add-backlight max-backlight)
        (progn (shell-command
                (concat "echo "
                        (format "%d" add-backlight)
                        " > /sys/class/backlight/intel_backlight/brightness"))
               (message "亮度+10%"))
      (message "亮度MAX!!"))))

;; 减少屏幕亮度
;;;###autoload
(defun +evan/less-backlight ()
  (interactive)
  (+evan/check-backlight-write-permission)
  (let* (
         ;; 最大亮度
         (max-backlight (string-to-number (string-trim-right
                                           (shell-command-to-string "cat /sys/class/backlight/intel_backlight/max_brightness"))))
         ;; 当前亮度
         (current-backlight (string-to-number (string-trim-right
                                               (shell-command-to-string "cat /sys/class/backlight/intel_backlight/brightness"))))
         ;; 减少后的亮度
         (less-backlight (- current-backlight (* max-backlight 0.1))))
    (if (> less-backlight (* max-backlight 0.1) )
        (progn (shell-command
                (concat "echo "
                        (format "%d" less-backlight)
                        " > /sys/class/backlight/intel_backlight/brightness"))
               (message "亮度-10%"))
      (message "亮度Min!!"))))

;; 增加或减少透明
;;;###autoload
(defun sanityinc/adjust-opacity (frame incr)
  "Adjust the background opacity of FRAME by increment INCR."
  (unless (display-graphic-p frame)
    (error "Cannot adjust opacity of this frame"))
  (let* ((oldalpha (or (frame-parameter frame 'alpha) 100))
         ;; The 'alpha frame param became a pair at some point in
         ;; emacs 24.x, e.g. (100 100)
         (oldalpha (if (listp oldalpha) (car oldalpha) oldalpha))
         (newalpha (+ incr oldalpha)))
    (when (and (<= frame-alpha-lower-limit newalpha) (>= 100 newalpha))
      (modify-frame-parameters frame (list (cons 'alpha newalpha))))))


;;;###autoload
(defun bongo-buffer-live-p ()
  "判断是否存在bongo buffer。"
  (if (or (get-buffer "*Bongo Playlist*") (get-buffer "*Bongo Library*"))
    t
    nil))

;;;###autoload
(defun bongo-init-all ()
  "自动初始化bongo音乐列表"
  (interactive)
  (let ((buffer (current-buffer)))
    (when (bongo-buffer-live-p)
      (bongo-stop))
    (bongo)
    (setq bongo-insert-whole-directory-trees "ask")
    (bongo-insert-file "~/Music")
    (bongo-insert-enqueue-region (point-min)
                                 (point-max))
    (bongo-play-random)
    (switch-to-buffer buffer)))

;;;###autoload
(defun open-elisp-scratch ()
  (interactive)
  (set-popup-rule! "^\\*elisp-scratch*" :ttl t :size 0.35 :select t :quit t)
  (pop-to-buffer "*elisp-scratch*")
  (lisp-interaction-mode))
