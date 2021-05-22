;;; evanmeek/ui/config.el -*- lexical-binding: t; -*-
(use-package! hide-mode-line
  :config
  (global-hide-mode-line-mode 1))
(use-package! awesome-tray
  :custom
  (awesome-tray-active-modules '("evil"
                                 "input-method"
                                 "git"
                                 "location"
                                 "buffer-read-only"
                                 "parent-dir"
                                 "mode-name"
                                 "battery"
                                 "date"))
  :config
  (awesome-tray-mode 1))
