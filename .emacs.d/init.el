;;; init.el --- Initialization file for Emacs.
;;; Commentary:
;; Emacs Startup File --- initialization for Emacs

;;; Code:
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; use-package
(eval-when-compile
  (require 'use-package))

;; use-package configurations
(use-package auto-package-update
  :ensure t
  :config
  (setq auto-package-update-delete-old-versions t)
  (auto-package-update-maybe))

;; (use-package evil
;;   :ensure t
;;   :init
;;   (setq evil-want-keybinding nil)
;;   :config
;;   (evil-mode 1)
;;   (defalias #'forward-evil-WORD #'forward-evil-symbol))

;; (use-package evil-collection
;;   :after evil
;;   :ensure t
;;   :config
;;   (evil-collection-init))

(use-package magit
  ;; :after (evil)
  :ensure t
  :bind ("C-x g" . magit-status)
  :config
  (global-magit-file-mode))

;; (use-package evil-magit
;;   :after (evil magit)
;;   :ensure t)
;;
;; (use-package evil-surround
;;   :ensure t
;;   :after evil
;;   :config
;;   (global-evil-surround-mode 1))

(use-package projectile
  :ensure t
  :bind-keymap
  ("C-c p" . projectile-command-map)
  :config
  (projectile-mode)
  (projectile-tags-exclude-patterns)
  (setq projectile-switch-project-action 'shell1))

(use-package ace-window
  :ensure t
  :bind ("M-o" . ace-window)
  :config
  (setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))
  ;; (setq aw-background nil)
  )

(use-package flycheck
  :ensure t
  :hook
  (ruby-mode . (lambda ()
                 (setq-local flycheck-command-wrapper-function
                             (lambda (command)
                               (append '("bundle" "exec") command)))))
  :config
  (global-flycheck-mode))

(use-package restclient
  :ensure t
  :config
  (setq restclient-inhibit-cookies t))

(use-package ivy
  :ensure t
  :bind
  (("C-c r" . ivy-resume)
   ("C-c s" . counsel-ag)
   ("C-s"   . swiper))
  :config
  (ivy-mode 1)
  (setq ivy-height 20)
  (setq ivy-use-virtual-buffers t)
  (setq ivy-count-format "(%d/%d) ")
  (setq ivy-re-builders-alist
	'((swiper . ivy--regex-plus)
	  (counsel-ag . ivy--regex-plus)
	  (t . ivy--regex-fuzzy)))
  (setq projectile-completion-system 'ivy)
  (setq magit-completing-read-function 'ivy-completing-read)
  (setq counsel-rg-base-command "rg -S -M 512 --no-heading --line-number --color never %s .")
  (setq counsel-ag-base-command "ag -W 256 --nocolor --nogroup %s"))

(use-package flx-ido :ensure t)
(ido-mode 0)
(ivy-mode 1)
  ;; (flx-ido-mode 1)
  ;; (setq ido-everywhere t)
  ;; (setq ido-enable-flex-matching t)
  ;; (setq ido-use-faces nil)
  ;; (setq ido-use-filename-at-point 'guess)
  ;; (setq ido-use-url-at-point t))

(use-package counsel
  :ensure t
  :after ivy
  :config
  (counsel-mode))

(use-package elixir-mode
  :ensure t
  :hook
  (elixir-mode . (lambda ()
                   (setq column-enforce-column 80)
                   (column-enforce-mode))))

(use-package flyspell
  :ensure t
  :hook
  (text-mode . flyspell-mode)
  (html-mode . (lambda() (flyspell-mode -1))))

;; (use-package evil-org
;;   :ensure t
;;   :after evil
;;   :hook (org-mode . evil-org-mode))

(use-package string-inflection :ensure t)

(use-package ag
  :ensure t
  :hook (ag-mode . wgrep-ag-setup)
  :config
  (setq ag-highlight-search t)
  (setq ag-arguments (cons "-W 256" ag-arguments)))

(use-package json-mode
  :ensure t
  :hook (json-mode . (lambda()(setq js-indent-level 2))))

(use-package rjsx-mode
  :ensure t
  :after column-enfore-mode
  :hook (js2-mode . (lambda()
		      (company-mode)
		      (display-line-numbers-mode)
		      (setq column-enforce-column 80)
		      (column-enforce-mode t)))
  :config
  (add-to-list 'auto-mode-alist '("\\.js\\'" . rjsx-mode))
  (setq js-indent-level 2))

(use-package rubocop :ensure t)

(use-package column-enforce-mode
  :ensure t
  :hook (prog-mode . column-enforce-mode)
  :config
  (setq column-enforce-mode-column 80))

(use-package ws-butler
  :ensure t
  :config
  (ws-butler-global-mode))

(use-package org-present :ensure t)

(use-package yaml-mode :ensure t)

(use-package doom-themes
  :ensure t
  :config
  (load-theme 'doom-one t)
  (doom-themes-visual-bell-config)
  (doom-themes-org-config))

(use-package exec-path-from-shell
  :ensure t
  :config
  (when (memq window-system '(mac ns x))
    (exec-path-from-shell-initialize)))

(use-package gnutls
  :ensure t
  :config
  (add-to-list 'gnutls-trustfiles "/usr/local/etc/openssl/cert.pem"))

(use-package yari :ensure t)

(use-package midnight)

(use-package markdown-mode :ensure t)

(use-package company :ensure t)

;; doom-modeline configuration
;; (use-package doom-modeline
;;       :ensure t
;;       :hook (after-init . doom-modeline-mod))


;; Miscellaneous

(defun shell1 () "Switch to or create *shell-1."
       (interactive) (shell "*shell-1*"))
(defun shell2 () "Switch to or create *shell-2."
       (interactive) (shell "*shell-2*"))
(defun shell3 () "Switch to or create *shell-3."
       (interactive) (shell "*shell-3*"))
(defun shell4 () "Switch to or create *shell-4."
       (interactive) (shell "*shell-4*"))

(global-set-key (kbd "C-1") 'shell1)
(global-set-key (kbd "C-2") 'shell2)
(global-set-key (kbd "C-3") 'shell3)
(global-set-key (kbd "C-4") 'shell4)
(global-set-key (kbd "C-c 1") 'shell1)
(global-set-key (kbd "C-c 2") 'shell2)
(global-set-key (kbd "C-c 3") 'shell3)
(global-set-key (kbd "C-c 4") 'shell4)

(add-hook 'prog-mode-hook 'display-line-numbers-mode)
(add-hook 'prog-mode-hook 'company-mode)
(add-hook 'ruby-mode-hook 'rubocop-mode)

(modify-syntax-entry ?_ "w")
(modify-syntax-entry ?- "w")

(defalias 'yes-or-no-p 'y-or-n-p)
(setenv "PAGER" "cat")

(delete-selection-mode 1)

;; Reload init.el file
(defun reload-init-file()
  (interactive)
  (load user-init-file))
(global-set-key (kbd "C-c C-l") 'reload-init-file)

;; View init.el file
(defun view-init-file()
  (interactive)
  (split-window-right)
  (balance-windows)
  (other-window 1)
  (find-file user-init-file))
(global-set-key (kbd "C-c C-v") 'view-init-file)

;; Test runner configuration
(defun run-test (&optional line-number-test)
  (interactive)
  (let ((default-directory (projectile-project-root)))
    (if line-number-test
        (async-shell-command (concat "bundle exec rspec " (buffer-file-name) ":" (number-to-string (funcall line-number-test))))
      (async-shell-command (concat "bundle exec rspec " (buffer-file-name))))))
(global-set-key (kbd "C-c T") 'run-test)
(global-set-key (kbd "C-c t") (lambda () (interactive) (run-test 'line-number-at-pos)))

;; look and feel
(setq column-number-mode t)
(show-paren-mode 1)
(add-hook 'after-init-hook 'toggle-frame-fullscreen)
(setq show-trailing-whitespace t)
(menu-bar-mode -1)
(tool-bar-mode -1)
(setq use-dialog-box nil)

;; tags
(setq tags-add-tables nil)

;; ediff
(setq ediff-window-setup-function 'ediff-setup-windows-plain)

;; ispell
(setq ispell-program-name "/usr/local/bin/ispell")

;; recentf
(recentf-mode 1)

;; shell
(setq shell-file-name "/bin/bash")
(add-hook 'comint-mode-hook (lambda () (setq comint-process-echoes t)))

;; text formatting
(electric-indent-mode 1)
(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)

;; backups
(setq backup-directory-alist
      `((".*" . ,"~/.emacs.backups/")))
(setq auto-save-file-name-transforms
      `((".*" ,"~/.emacs.saves/" t)))

(setq-default display-buffer-alist
              '(("*shell-?*" (display-buffer-reuse-window
                              display-buffer-same-window))))

;; babel
(org-babel-do-load-languages
 'org-babel-load-languages
 '((shell . t)))

(setq inhibit-startup-screen t)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#282c34" "#ff6c6b" "#98be65" "#ECBE7B" "#51afef" "#c678dd" "#46D9FF" "#bbc2cf"])
 '(custom-safe-themes
   (quote
    ("6b2636879127bf6124ce541b1b2824800afc49c6ccd65439d6eb987dbf200c36" default)))
 '(fci-rule-color "#5B6268")
 '(jdee-db-active-breakpoint-face-colors (cons "#1B2229" "#51afef"))
 '(jdee-db-requested-breakpoint-face-colors (cons "#1B2229" "#98be65"))
 '(jdee-db-spec-breakpoint-face-colors (cons "#1B2229" "#3f444a"))
 '(objed-cursor-color "#ff6c6b")
 '(package-selected-packages
   (quote
    (doom-modeline doom-themes markdown-mode yari exec-path-from-shell zenburn-theme yaml-mode org-present ws-butler column-enforce-mode rubocop rjsx-mode json-mode ag string-inflection evil-org elixir-mode counsel ivy restclient flycheck ace-window projectile evil-surround evil-magit magit evil-collection evil auto-package-update use-package)))
 '(safe-local-variable-values (quote ((column-enforce-column . 120))))
 '(vc-annotate-background "#282c34")
 '(vc-annotate-color-map
   (list
    (cons 20 "#98be65")
    (cons 40 "#b4be6c")
    (cons 60 "#d0be73")
    (cons 80 "#ECBE7B")
    (cons 100 "#e6ab6a")
    (cons 120 "#e09859")
    (cons 140 "#da8548")
    (cons 160 "#d38079")
    (cons 180 "#cc7cab")
    (cons 200 "#c678dd")
    (cons 220 "#d974b7")
    (cons 240 "#ec7091")
    (cons 260 "#ff6c6b")
    (cons 280 "#cf6162")
    (cons 300 "#9f585a")
    (cons 320 "#6f4e52")
    (cons 340 "#5B6268")
    (cons 360 "#5B6268")))
 '(vc-annotate-very-old-color nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
