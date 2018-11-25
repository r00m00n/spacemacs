?
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(set-frame-font "Source Code Pro 12" nil t)

;; packages
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(package-initialize)
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(unless (package-installed-p 'projectile)
  (package-refresh-contents)
  (package-install 'projectile))

(unless (package-installed-p 'tide)
  (package-refresh-contents)
  (package-install 'tide))

(unless (package-installed-p 'linum-relative)
  (package-refresh-contents)
  (package-install 'linum-relative))

(unless (package-installed-p 'linum-relative)
  (package-refresh-contents)
  (package-install 'linum-relative))

(unless (package-installed-p 'company)
  (package-refresh-contents)
  (package-install 'company))

(unless (package-installed-p 'magit)
  (package-refresh-contents)
  (package-install 'magit))

(unless (package-installed-p 'ivy)
  (package-refresh-contents)
  (package-install 'ivy))

(unless (package-installed-p 'counsel)
  (package-refresh-contents)
  (package-install 'counsel))

(unless (package-installed-p 'powerline)
  (package-refresh-contents)
  (package-install 'powerline))

(unless (package-installed-p 'multiple-cursors)
  (package-refresh-contents)
  (package-install 'multiple-cursors))

(unless (package-installed-p 'ace-jump-mode)
  (package-refresh-contents)
  (package-install 'ace-jump-mode))

(unless (package-installed-p 'indium)
  (package-install 'indium))

(defalias 'yes-or-no-p 'y-or-n-p)

;; which key
(use-package which-key
  :ensure t
  :init
  (which-key-mode))

(use-package spaceline 
  :ensure t
  :config
  (require 'spaceline-config)
  (setq powerline-default-separator (quote nil))
  (spaceline-emacs-theme))

(use-package afternoon-theme 
  :ensure t)

(use-package avy
  :ensure t
  :bind
  ("C-c C-d" . avy-goto-char))

(use-package yasnippet
  :ensure t
  :config
  (use-package yasnippet-snippets
    :ensure t)
  (yas-reload-all))

(use-package tide
  :ensure t
  :after (typescript-mode company flycheck)
  :hook ((typescript-mode . tide-setup)
         (typescript-mode . tide-hl-identifier-mode)
         (before-save . tide-format-before-save)))

;; appearance
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(global-hl-line-mode t)
(global-prettify-symbols-mode t)
(setq make-backup-file nil)
(setq auto-save-default nil)
(setq ring-bell-function 'ignore)

(setq w32-pass-lwindow-to-system nil)
(setq w32-lwindow-modifier 'super) ; Left Windows key

(add-hook 'after-init-hook 'global-company-mode)

(defun split-and-follow-horizontally()
	(interactive)
	(split-window-below)
	(balance-windows)
	(other-window))
(global-set-key (kbd "C-x 2") 'split-and-follow-horizontally) 

(defun split-and-follow-vertically()
  (interactive)
  (split-window-right)
  (balance-windows)
  (other-window))
(global-set-key (kbd "C-x 3") 'split-and-follow-vertically)

(defun config-visit()
	(interactive)
	(find-file "~/.emacs"))
(global-set-key (kbd "C-c e") 'config-visit)


;; lines specific
(setq-default truncate-lines t)
(require 'linum-relative)
(global-linum-mode 1)
(linum-mode)
(linum-relative-on)

;; multiple cursors
(require 'multiple-cursors)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

;; yasnippet
(add-hook 'lua-mode-hook 'yas-minor-mode)
(add-hook 'typescript-mode-hook 'yas-minor-mode)
(add-hook 'javascript-mode-hook 'yas-minor-mode)

;; magit
(global-set-key (kbd "C-x g") 'magit-status)

;; ivy specific
(ivy-mode 1)
(setq ivy-use-virtual-buffers t)
(setq enable-recursive-minibuffers t)
(global-set-key "\C-s" 'swiper)
(global-set-key (kbd "C-c C-r") 'ivy-resume)
(global-set-key (kbd "<f6>") 'ivy-resume)
(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)
(global-set-key (kbd "<f1> f") 'counsel-describe-function)
(global-set-key (kbd "<f1> v") 'counsel-describe-variable)
(global-set-key (kbd "<f1> l") 'counsel-find-library)
(global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
(global-set-key (kbd "<f2> u") 'counsel-unicode-char)
(global-set-key (kbd "C-c g") 'counsel-git)
(global-set-key (kbd "C-c j") 'counsel-git-grep)
(global-set-key (kbd "C-c k") 'counsel-rg)
(global-set-key (kbd "C-x l") 'counsel-locate)
(global-set-key (kbd "C-S-o") 'counsel-rhythmbox)
(define-key minibuffer-local-map (kbd "C-r") 'counsel-minibuffer-history)

;; projectile specific
(projectile-mode +1)
(define-key projectile-mode-map (kbd "s-o") 'projectile-command-map)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
(setq projectile-indexing-method 'alien)

(projectile-register-project-type 'npm '("package.json")
                  :compile "npm install"
                  :test "npm test"
                  :run "npm start"
                  :test-suffix ".spec")
				  
;; ace jump mode
(autoload
  'ace-jump-mode
  "ace-jump-mode"
  "Emacs quick move minor mode"
  t)
;; you can select the key you prefer to
(define-key global-map (kbd "C-c SPC") 'ace-jump-mode)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (deeper-blue)))
 '(custom-safe-themes
   (quote
    ("aaffceb9b0f539b6ad6becb8e96a04f2140c8faa1de8039a343a4f1e009174fb" default)))
 '(inhibit-startup-screen t)
 '(package-selected-packages
   (quote
    (swiper-helm counsel ivy doom ace-jump-mode powerline multiple-cursors linum-relative ag geben-helm-projectile magit magit-find-file company counsel-projectile swiper ts-comint tss tide))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(put 'upcase-region 'disabled nil)
(put 'dired-find-alternate-file 'disabled nil)
