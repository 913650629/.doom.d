;; -*- no-byte-compile: t; -*-
;;; evanmeek/eaf/packages.el

(when (package! eaf :recipe (:host github
                             :repo "manateelazycat/emacs-application-framework"
                             :files ("*.el" "*.py" "app" "core" "*.sh" "*.js")
                             :build (:not compile)))

  (package! ctable :recipe (:host github :repo "kiwanami/emacs-ctable"))
  (package! deferred :recipe (:host github :repo "kiwanami/emacs-deferred"))
  (package! epc :recipe (:host github :repo "kiwanami/emacs-epc")))
