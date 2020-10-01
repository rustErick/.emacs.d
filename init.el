(require 'package)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (url (concat (if no-ssl "http""https") "://melpa.org/packages/")))
  (add-to-list'package-archives (cons"melpa" url) t))
(when (>= emacs-major-version 24)
  (add-to-list'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(setq custom-file "~/.emacs.d/custom.el")
(setq default-directory "d:/")
(load custom-file)

(add-to-list 'before-save-hook 'delete-trailing-whitespace)
(fset 'yes-or-no-p 'y-or-n-p)
(add-to-list 'auto-mode-alist '("\\.scss\\'" . css-mode))
(set-cursor-color "white")

(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(setq initial-scratch-message "
                ███████████████████████████████████████████
                █                                         █
                █                                         █
                █                                         █
                ███████████████████████████████████████████
                ███████████████████████████████████████████
                █                                         █
               █        ╦  ┌─┐┌┬┐  ┬─┐┌─┐┌─┐┌┬┐┬ ┬         █
               █        ║  ├─┤│││  ├┬┘├┤ ├─┤ ││└┬┘         █
               █        ╩  ┴ ┴┴ ┴  ┴└─└─┘┴ ┴─┴┘ ┴  o       █
               █                                           █
           ████ █ █ █ █ █ █ █ █ █ █ █ █ █ █ █ █ █ █ █ █ █ █ █████
       █████   █ █ █ █ █ █ █ █ █ █ █ █ █ █ █ █ █ █ █ █ █ █ █    █████
      █                                                              █
     █                                                                █
    █                                                                  █
   █                                                                    █
  █       █████       ████████████         ████████████     █████        █
  █            █    ██            ██     ██           ██   █             █
  █             ████       ██      ███ ███       ██    ████              █
   █                ██            ██     ██           ██                █
    █                 ████████████         ████████████                █
     █                                                                █
      █                                                              █
       █████                                                    █████
           ███               ██████████████████               ███
             ███            █ ██  ██  ██  ██  ██            ███
               ███          ██  ██  ██  ██  ██ █          ███
                 ███         ██████████████████         ███
                   ███                                ███
                     ███                            ███
                       ███                        ███
                         ██████████████████████████")
;;;;;;;;;;;;;;;;;;
;; VIPER MODE - VIM
;;;;;;;;;;;;;;;;;
(setq viper-mode t)
(require 'viper)
;;;;;;;;;;;;;;;;;;
;; REACT EXTENSION PROGRAMING
;;;;;;;;;;;;;;;;;;
(use-package rjsx-mode
  :ensure t
  :mode "\\.jsx\\'"
  :init (setq-local indent-line-function 'js-jsx-indent-line))
;;;;;;;;;;;;;;;;;;
;; JAVASCRIPT PROGRAMING IDE
;;;;;;;;;;;;;;;;;;
(use-package js2-mode
  :ensure t
  :defer t
  :mode "\\.js\\'"
  :interpreter "node"
  :init (setq js2-basic-offset 4))
;;;;;;;;;;;;;;;;;;
;; UNDO THE FORM TREE
;;;;;;;;;;;;;;;;;;
(use-package undo-tree
  :ensure t
  :config
  (progn
    (global-undo-tree-mode)
    (setq undo-tree-visualizer-timestamps t)
    (setq undo-tree-visualizer-diff t)))
;;;;;;;;;;;;;;;;;;;;;;;;
;; ace window
;;;;;;;;;;;;;;;;;;;;;;;;
(use-package ace-window
  :ensure t
  :defer 1
  :bind ("C-x o" . ace-window)
  :config
  (set-face-attribute
   'aw-leading-char-face nil
   :foreground "deep sky blue"
   :weight 'bold
   :height 3.0)
  (setq aw-keys '(?a ?s ?d ?j ?k ?l ?ñ)
		aw-dispatch-always t
		aw-dispatch-alist
		'((?x aw-delete-window "Ace - Delete Window")
		  ;; (?c aw-swap-window "Ace - Swap Window")
		  (?c toggle-frame-fullscreen)
		  (?n aw-flip-window)
		  (?h aw-split-window-vert "Ace - Split Vert Window")
		  (?v aw-split-window-horz "Ace - Split Horz Window")
		  (?o delete-other-windows)
          (?b balance-windows)))

  (when (package-installed-p 'hydra)
    (defhydra hydra-window-size (:color red :hint nil)
      "
      [_h_] Left   [_j_] Up    [_k_] Down    [_l_] Right
"
      ("h" shrink-window-horizontally)
      ("j" shrink-window)
      ("k" enlarge-window)
      ("l" enlarge-window-horizontally))
    (defhydra hydra-window-frame (:color red :hint nil)
      "
       [_f_] New Frame      [_s_] Shell
       [_l_] List colors  [_e_] Speedbar
"
      ("f" make-frame)
      ;; ("x" delete-frame)
	  ("s" shell)
	  ("l" list-colors-display)
	  ("e" speedbar))
    (add-to-list 'aw-dispatch-alist '(?w hydra-window-size/body) t)
    (add-to-list 'aw-dispatch-alist '(?f hydra-window-frame/body) t))
  (ace-window-display-mode t))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; FOR CODE EXPAND YASNIPPET
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package yasnippet
  :ensure t
  :demand t
  :functions hydra-yasnippet
  :bind ("M-ñ y" . hydra-yasnippet/body)
  :diminish yas-minor-mode
  :custom (yas-snippet-dirs '("~/.emacs.d/private/snippets/"))
  ;; :init
  ;; (progn
  ;; (yas-global-mode 1)
  ;; )
  :hook (after-init . yas-global-mode)
  :commands yas-reload-all
  :config ;;(yas-reload-all)
  (with-eval-after-load 'hydra
	(defhydra hydra-yasnippet (:hint nil)
	  "
    [_n_] New snippet  [_f_] Visit File  [_t_] Describe on table
       "
	  ("n" yas-new-snippet)
	  ("f" yas-visit-snippet-file)
	  ("t" yas-describe-tables))
	))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; FOR PETITION THE API REST - HTTP
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package restclient
  :ensure t
  :functions hydra-restclient
  :bind ("M-ñ r" . hydra-restclient/body)
  :config
  (add-to-list 'auto-mode-alist '("\\.http\\'" . restclient-mode))
  (with-eval-after-load 'hydra
	(defhydra hydra-restclient (:hint nil)
	  "
      [_q_] Run query    [_r_] Run - Info       [_i_] Info url
      [_n_] Next query   [_p_] Previous query
        "
	  ("q" restclient-http-send-current)
	  ("r" restclient-http-send-current-raw)
	  ("n" restclient-jump-next)
	  ("p" restclient-jump-prev)
	  ("i" restclient-show-info))
	))
;;;;;;;;;;;;;;;;;;;
;; EMMET
;;;;;;;;;;;;;;;;;
(use-package emmet-mode
  :ensure t
  :diminish emmet-mode
  :bind ("M-o" . emmet-expand-line)
  :init
  (add-hook 'css-mode-hook 'emmet-mode)
  (add-hook 'sgml-mode-hook 'emmet-mode)
  (add-hook 'rjsx-mode-hook 'emmet-mode)
  ;; :config
  (add-hook 'rjsx-mode-hook
            (lambda ()
              (setq-local emmet-expand-jsx-className? t)))
  (add-hook 'sgml-mode-hook
			(lambda ()
			  (setq-local emmet-expand-jsx-className? nil))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; MULTIPLE CURSOR FOR EDIT OR CHANGE
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package multiple-cursors
  :ensure t
  :functions hydra-multiple-cursors
  :bind ("M-ñ c" . hydra-multiple-cursors/body)
  :config
  (with-eval-after-load 'hydra
	(defhydra hydra-multiple-cursors (:hint nil)
      "
   -----------Mark-----------------     --------------Unmark-----------
    [_j_] Down       [_k_] Up            [_p_] Previous  [_n_] Next
    [_0_] Numbers    [_l_] Letters       [_t_] Mark all
        "
	  ("t" mc/mark-all-like-this)
	  ("j" mc/mark-next-like-this)
	  ("k" mc/mark-previous-like-this)
	  ("n" mc/unmark-previous-like-this)
	  ("p" mc/unmark-next-like-this)
	  ("0" mc/insert-numbers)
	  ("l" mc/insert-letters))
    ))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; GO TO DEFINITION REDIRECT OTHER FILE
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package dumb-jump
  :ensure t
  :functions hydra-dumb-jump
  :bind ("M-ñ j" . hydra-dumb-jump/body)
  :config
  (with-eval-after-load 'hydra
	(defhydra hydra-dumb-jump (:hint nil)
	  "
         [_g_] Go     [_o_] Other window  [_e_] Go external
         [_b_] Back   [_p_] Prompt        [_d_] Dired
      "
	  ("g" dumb-jump-go)
	  ("o" dumb-jump-go-other-window)
	  ("e" dumb-jump-go-prefer-external)
	  ;; ("x" dumb-jump-go-prefer-external-other-window "Go external other window")
	  ("p" dumb-jump-go-prompt)
	  ;; ("d" dumb-jump-quick-look)
	  ("b" dumb-jump-back)
	  ("d" dired-jump)
	   ))
	)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; AUTOCOMPLETE FOR WORD REPEAT
;;;;;;;;;;;;;;;;;;
(global-set-key (kbd "M-h") 'company-capf)
(use-package company
  :diminish company-mode
  :defines
  (company-dabbrev-ignore-case company-dabbrev-downcase)
  ;; :bind
  ;; (:map company-active-map
		;; ("<tab>" . company-complete-common-or-cycle))
  :custom
  (company-idle-delay .2)
  (company-tooltip-idle-delay .2)
  (company-echo-delay 0)
  (company-minimum-prefix-length 1)
  :hook
  (after-init . global-company-mode)
  :config
  ;; (use-package company-posframe
    ;; :hook (company-mode . company-posframe-mode))
  (use-package company-quickhelp
    :defines company-quickhelp-delay
    :bind (:map company-active-map
                ("C-c h" . company-quickhelp-manual-begin))
    :hook (global-company-mode . company-quickhelp-mode)
    :custom (company-quickhelp-delay 0.3)))
  ;; )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; org bullets
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package org-bullets
  :ensure t
  :config
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))
(setq org-bullets-bullet-list '("☯" "✜" "☀" "☢" "◉" "❀"))
;;;;;;;;;;;;;;;;;;;;;;;;;
;; scroll window
;;;;;;;;;;;;;;;;;;;;;;;;;
(defhydra hydra-scroll-window (:hint nil)
"
     [_k_] Up           [_j_] Down          [_l_] Left
     [_h_] Right        [_p_] Up window    [_n_] Down window
"
("j" viper-scroll-down-one)
("k" viper-scroll-up-one)
("l" scroll-left)
("h" scroll-right)
("p" (lambda () (interactive )
	   (scroll-other-window +1)
	   ))
("n" (lambda () (interactive)
       (scroll-other-window -1)
       ))
  )
(global-set-key (kbd "M-ñ s") 'hydra-scroll-window/body)

(defhydra hydra-move-avy (:hint nil)
  "
    [_l_] Line    [_r_] Region    [_m_] Center   [_n_] Next  [_p_] Previous
"
  ("l" avy-move-line)
  ("r" avy-move-region)
  ("m" move-to-window-line-top-bottom)
  ("p" previous-buffer)
  ("n" next-buffer)
  )
(global-set-key (kbd "M-ñ m") 'hydra-move-avy/body)

(defhydra hydra-find-word (:hint nil)
"
      [_n_] Search next   [_p_] Search previous   [_q_] Replace  [_f_] Find file
"
  ("n" isearch-forward)
  ("p" isearch-backward)
  ("q" query-replace)
  ("f" find-file))
(global-set-key (kbd "M-ñ f") 'hydra-find-word/body)
(use-package rust-mode
  :ensure t
  :mode "\\.rs\\'"
  :config (setq rust-formart-on-save t)
  )
(use-package auto-package-update
  :ensure t
  :config
  (setq auto-package-update-delete-old-versions t)
  (setq auto-package-update-hide-results t)
  (auto-package-update-maybe))

(use-package org
  :ensure
  :bind (
		 ("C-c a" . org-agenda)
		 ("C-c c" . org-capture)
		 ("C-c b" . org-table-create)
		 ("M-ñ" . org-todo)
		 ))
(setq org-agenda-files '("~/Documents/org/notes.org"
						 "~/Documents/org/tasks.org"
						 "~/Documents/org/ideas.org"
						 "~/Documents/org/project.org"))
(setq org-todo-keywords
	  '((sequence "TODO" "IN-PROGRESS" "WAITING" "|" "DONE")))
;; (setq org-tag-alist '(("@work" . ?w) ("@home" . ?h) ("laptop" . ?l)))
(setq org-capture-templates
      (quote (
              ("n"         ;; hotkey
               "Notes" ;; name
               entry       ;; type
               (file+datetree "~/Documents/org/notes.org") ;; target
               "* TODO %^{title note} %T \n  1. %^{write a note}" ;; template
               )
              ("t" "Schedule an event or a task" entry
               (file+datetree "~/Documents/org/tasks.org")
               "* TODO [#%^{Priority}] %^{Schedule of event or task}\n** %^{title of event or task}\n SCHEDULED: %^t\n  1. %^{write a description:}"
               )
			  ("i" "Ideas" entry
               (file+datetree "~/Documents/org/ideas.org")
               "* TODO [0%] %^{Title idea} %T\n  - [-] %^{Description of idea}")
              ("b" "Add a book to read" entry
               (file+headline "~/Documents/org/books.org" "Books to read")
               "* TODO %^{Book name}\n  - %^{Why to read this book?}"
               )
			  ("e" "Notes of english" item
			   (file+datetree "~/Documents/org/english.org")
			   "%^{title}")
			  ("p" "Projects" item
			   (file+datetree "~/Documents/org/project.org")
			   "[-] %^{name project} - %^{description the project} %t")
              )))
