;; -*- no-byte-compile: t; -*-
;;; evanmeek/lib/packages.el
(package! ov)
(package! twidget
  :recipe (:host github :repo "EvanMeek/twidget"
           :files ("*.el")))
