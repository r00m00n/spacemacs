
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(set-frame-font "Noto Mono 12" nil t)

;; packages
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(package-initialize)
(unless (package-installed-p 'use-package)
	(package-refresh-contents)
	(package-install 'use-package))

(unless (package-installed-p 'tide)
	(package-refresh-contents)
	(package-install 'tide))

(unless (package-installed-p 'linum-relative)
	(package-refresh-contents)
	(package-install 'linum-relative))
	
(unless (package-installed-p 'linum-relative)
	(package-refresh-contents)
	(package-install 'linum-relative))
	
(unless (package-installed-p 'magit)
	(package-refresh-contents)
	(package-install 'magit))
	
(unless (package-installed-p 'ivy)
	(package-refresh-contents)
	(package-install 'ivy))
	
(unless (package-installed-p 'powerline)
	(package-refresh-contents)
	(package-install 'powerline))

(unless (package-installed-p 'multiple-cursors)
	(package-refresh-contents)
	(package-install 'multiple-cursors))
	
(unless (package-installed-p 'ace-jump-mode)
	(package-refresh-contents)
	(package-install 'ace-jump-mode))
	
(defalias 'yes-or-no-p 'y-or-n-p)

;; which key
(use-package which-key
	:ensure t
	:init
	(which-key-mode))

;; appearance
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(global-hl-line-mode t)
(global-prettify-symbols-mode t)
(setq make-backup-file nil)
(setq auto-save-default nil)

(defun setup-tide-mode ()
  (interactive)
  (tide-setup)
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)
  ;; company is an optional dependency. You have to
  ;; install it separately via package-install
  ;; `M-x package-install [ret] company`
  (company-mode +1))
;; aligns annotation to the right hand side
(setq company-tooltip-align-annotations t)

;; formats the buffer before saving
(add-hook 'before-save-hook 'tide-format-before-save)

(add-hook 'typescript-mode-hook #'setup-tide-mode)

;; lines specific
(setq-default truncate-lines t)
(require 'linum-relative)
(global-linum-mode 1)
(linum-mode)
(linum-relative-on)

;; powerline
(require 'powerline)
(powerline-default-theme)

;; multiple cursors
(require 'multiple-cursors)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

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
(global-set-key (kbd "C-c k") 'counsel-ag)
(global-set-key (kbd "C-x l") 'counsel-locate)
(global-set-key (kbd "C-S-o") 'counsel-rhythmbox)
(define-key minibuffer-local-map (kbd "C-r") 'counsel-minibuffer-history)

;; projectile specific
(projectile-mode +1)
(define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
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
 '(inhibit-startup-screen t)
 '(package-selected-packages
   (quote
    (ace-jump-mode powerline multiple-cursors linum-relative ag geben-helm-projectile magit magit-find-file company counsel-projectile swiper ts-comint tss tide))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
