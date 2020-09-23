(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ace-window-display-mode nil)
 '(custom-enabled-themes '(misterioso))
 '(display-line-numbers 'relative)
 '(electric-pair-mode t)
 '(electric-pair-pairs '((39 . 39) (96 . 96)))
 '(fringe-mode '(1 . 1) nil (fringe))
 '(global-auto-revert-mode t)
 '(inhibit-startup-screen t)
 '(line-number-mode nil)
 '(make-backup-files nil)
 '(menu-bar-mode nil)
 '(mode-line-percent-position nil)
 '(package-selected-packages
   '(yasnippet undo-tree restclient org-bullets multiple-cursors rjsx-mode hydra emmet-mode dumb-jump company-quickhelp company ace-window use-package))
 '(scroll-bar-mode nil)
 '(sgml-basic-offset 4)
 '(show-paren-mode t)
 '(show-trailing-whitespace t)
 '(speedbar-indentation-width 2)
 '(tab-width 4)
 '(tool-bar-mode nil)
 '(truncate-lines t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(font-lock-comment-face ((t (:background "#292e34" :foreground "#2aa1ae"))))
 '(font-lock-function-name-face ((t (:foreground "#ff516d" :height 1.1))))
 '(font-lock-keyword-face ((t (:foreground "violet red" :height 1.1))))
 '(font-lock-negation-char-face ((t (:foreground "#f8f8f2"))))
 '(font-lock-string-face ((t (:foreground "#1abc9c"))))
 '(font-lock-variable-name-face ((t (:foreground "#6580db" :weight bold :height 1.1))))
 '(font-lock-warning-face ((t (:foreground "#ff4242" :underline (:color foreground-color :style wave) :weight bold))))
 '(js2-function-call ((t (:foreground "#14a1a1" :weight bold))))
 '(js2-function-param ((t (:foreground "medium spring green" :weight bold :height 1.1))))
 '(line-number-current-line ((t (:background "gray32" :foreground "snow" :weight bold))))
 '(mode-line ((t (:background "#222226" :foreground "#b2b2b2" :box (:line-width 2 :color "#5d4d7a")))))
 '(mode-line-buffer-id ((t (:inherit bold :foreground "#bc6ec5"))))
 '(mode-line-inactive ((t (:background "#292b2e" :foreground "#b2b2b2"))))
 '(vertical-border ((((type w32)) (:foreground "#5d4d7a")))))

(global-set-key (kbd "M-m") 'viper-intercept-ESC-key)
