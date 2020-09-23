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
       [_f_] New Frame    [_x_] Delete Frame  [_s_] Shell
       [_l_] List colors  [_e_] Speedbar
"
      ("f" make-frame)
      ("x" delete-frame)
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
    [_0_] Numbers    [_l_] Letters       [_a_] Mark all
        "
	  ("a" mc/mark-all-like-this)
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
         [_b_] Back   [_p_] Prompt        [_d_] Description
      "
	  ("g" dumb-jump-go)
	  ("o" dumb-jump-go-other-window)
	  ("e" dumb-jump-go-prefer-external)
	  ;; ("x" dumb-jump-go-prefer-external-other-window "Go external other window")
	  ("p" dumb-jump-go-prompt)
	  ("d" dumb-jump-quick-look)
	  ("b" dumb-jump-back))
	))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; AUTOCOMPLETE FOR WORD REPEAT
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package company
  :ensure t
  :init
  (progn
	(global-company-mode t)
	)
  :config (add-hook 'prog-mode-hook 'company-mode))
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
   [_k_] Up  [_j_] Down  [_l_] Left  [_h_] Right
"
("j" viper-scroll-down-one)
("k" viper-scroll-up-one)
("l" scroll-left)
("h" scroll-right)
  )
(global-set-key (kbd "M-ñ s") 'hydra-scroll-window/body)

(defhydra hydra-move-avy (:hint nil)
  "
    [_l_] Line    [_r_] Region    [_m_] Center   [_n_] Next [_p_] Previous
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