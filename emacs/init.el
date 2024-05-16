(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)


(setq inhibit-startup-message t)

(scroll-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)
(menu-bar-mode -1)
;;(set-fringe-mode 100)  ; Give some breathing room

(column-number-mode)
(global-display-line-numbers-mode 1)

(dolist (mode '(org-mode-hook
		term-mode-hook
		shell-mode-hook
		eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))





(recentf-mode 1) ; M-x recentf-open-file


;; Disable `*Messages*` buffer.
(setq-default message-log-max nil)
(kill-buffer "*Messages*")
;; Disable `*scratch*` buffer.
(setq initial-scratch-message "")
(kill-buffer "*scratch*")

(add-hook 'minibuffer-exit-hook
	  '(lambda ()
	     (let ((buffer "*Completions*"))
	       (and (get-buffer buffer)
		    (kill-buffer buffer)))))


(setq backup-directory-alist '(("." . "~/.emacs.d/backup"))
  backup-by-copying t    ; Don't delink hardlinks
  version-control t      ; Use version numbers on backups
  delete-old-versions t  ; Automatically delete excess backups
  kept-new-versions 20   ; how many of the newest versions to keep
  kept-old-versions 5    ; and how many of the old
  )




;; Initialize package sources
(require 'package)

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
			 ("melpa-stable" . "https://stable.melpa.org/packages/")
			 ("elpa" . "https://elpa.gnu.org/packages/")
			 ("org" . "https://orgmode.org/elpa/")))

(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

(require 'use-package)
(setq use-package-always-ensure t)





;; Make ESC quit prompts
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)
;; (global-set-key (kbd "C-M-j") 'counsel-switch-buffer)

;; (define-key emacs-lisp-mode-map (kbd "C-x M-t") 'counsel-load-theme)

(use-package counsel
  :bind (("M-x" . counsel-M-x)
	 ("C-x b" . counsel-ibuffer)
	 ("C-x C-f" . counsel-find-file)
	 :map minibuffer-local-map
	 ("C-r" . 'counsel-minibuffer-history))
  :config
  (setq ivy-initial-inputs-alist nil)) ; Don't start searches with 


(use-package ivy
  :diminish
  :bind (("C-s" . swiper)
	 :map ivy-minibuffer-map
	 ("TAB" . ivy-alt-done)
	 ("C-l" . ivy-alt-done)
	 ("C-j" . ivy-next-line)
	 ("C-k" . ivy-previous-line)
	 :map ivy-switch-buffer-map
	 ("C-k" . ivy-previous-line)
	 ("C-l" . ivy-done)
	 ("C-d" . ivy-switch-buffer-kill)
	 :map ivy-reverse-i-search-map
	 ("C-k" . ivy-previous-line)
	 ("C-d" . ivy-reverse-i-search-kill))
  :config
  (ivy-mode 1))

(use-package ivy-rich
  :init
  (ivy-rich-mode 1))


(use-package helpful
  :ensure t
  :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-describe-variable-function #'helpful-variable)
  :bind
  ([remap describe-function] . counsel-describe-function)
  ([remap describe-command] . helpful-command)
  ([remap describe-variable] . counsel-describe-variable)
  ([remap describe-key] . helpful-key))



(use-package all-the-icons)


;; Modeline
(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1))

(use-package doom-themes
  :init (load-theme 'doom-dracula t))






(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 0))




















;; Evil mode configuration ======================================================

(use-package evil
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  (setq evil-want-C-i-jump t)
  (evil-mode 1)

  (define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state)

  ;; Enable redo funcionality
  (evil-set-undo-system 'undo-redo)

  ;; Use visual line motions even outside of visual-line-mode buffers
  (evil-global-set-key 'motion "j" 'evil-next-visual-line)
  (evil-global-set-key 'motion "k" 'evil-previous-visual-line))

  
(use-package evil-collection
  :after evil
  :config (evil-collection-init))

;;==============================================================================





;; Font configuration ==========================================================

(set-face-attribute 'default nil
		    :font "Fira Code"
		    :height 160)
;; set the fixed pitch face.
(set-face-attribute 'fixed-pitch nil
		    :font "Fira Code"
		    :height 160)
;; Set the variable pitch face.
(set-face-attribute 'variable-pitch nil
		    :font "Archivo"
		    :height 180
		    :weight 'light)

;;==============================================================================





;; Org mode configuration. ======================================================
(defface bc-languages-list
  `((t :foreground ,(doom-color 'base6)))
  "Face for list.")

;; Set face for org mode bullet lists.
(font-lock-add-keywords 'org-mode
			'(("^ *[-].+" 0
			   'bc-languages-list))
			't)

;; Replace hyphens in list with em dashes.
(font-lock-add-keywords 'org-mode
			'(("^ *\\([-]\\) "
			   (0 (prog1 () (compose-region
					 (match-beginning 1)
					 (match-end 1) "—"))))))


(defun bc/org-mode-setup ()
  (org-indent-mode 1)
  (variable-pitch-mode 1)
  (visual-line-mode 1)

  ;; Config abbreviations.
  ;;(abbrev-mode 1)
  ;;(abbrev-table-put org-mode-abbrev-table
  ;;		    :regexp "\\(?:^\\|[\t\s]+\\|[^a-zA-Z0-9-]\\)\\(?1:[a-zA-Z0-9-]+\\)")
  ;;(define-abbrev org-mode-abbrev-table "---" "—")


  ;; Set faces for heading levels.
  (dolist (face '((org-level-1 . 1.15)
		  (org-level-2 . 1.10)
		  (org-level-3 . 1.05)
		  (org-level-4 . 1.00)
		  (org-level-5 . 1.00)
		  (org-level-6 . 1.00)
		  (org-level-7 . 1.00)
		  (org-level-8 . 1.00)))
    (set-face-attribute (car face) nil
			:font "Archivo"
			:weight 'regular
			:height (cdr face)))

  ;; Ensure that anything that should be fixed-pitch in Org files appears that way.
  (set-face-attribute 'org-block nil :foreground 'unspecified :inherit 'fixed-pitch)
  (set-face-attribute 'org-code nil :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-table nil :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-table nil :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-verbatim nil :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-special-keyword nil :inherit '(font-lock-comment-face fixed-pitch))
  (set-face-attribute 'org-meta-line nil :inherit '(font-lock-comment-face fixed-pitch))
  (set-face-attribute 'org-checkbox nil :inherit 'fixed-pitch)
  (set-face-attribute 'org-indent nil :inherit '(org-hide fixed-pitch))

  ;; Retaining new lines separating headings
;;  (customize-set-variable 'org-blank-before-new-entry 
;;			  '((heading . nil)
;;			    (plain-list-item . nil)))
  (setq org-blank-before-new-entry '((heading . nil)
				     (plain-list-item . nil)))
  (setq org-cycle-separator-lines 5))



(use-package org
  :hook (org-mode . bc/org-mode-setup)
  :config
  (setq
   ;; Replace the dots in the end of collapsed headings.
   org-ellipsis " ▾"
   ;; Hide the formating characters.
   org-hide-emphasis-markers t
   ;;org-hide-leading-stars t
   org-indent-indentation-per-level 1
   org-adapt-indentation nil
   ))




;; Replace the stars in the heading.
(use-package org-bullets
  :after org
  :hook (org-mode . org-bullets-mode)
  :custom (org-bullets-bullet-list '("◉" "○" "●" "○" "●" "○" "●")))



(defun bc/org-mode-visual-fill ()
  (setq visual-fill-column-width 70
	visual-fill-column-center-text t)
  (visual-fill-column-mode 1))

(use-package visual-fill-column
  :hook (org-mode . bc/org-mode-visual-fill))

;;==============================================================================





;; Dired configuration ==========================================================

;; Move files to trash when delete it.
(setq delete-by-moving-to-trash t)

(defun bc/dired-setup ()
  ;; Disable line numbers.
  (display-line-numbers-mode 0)
  ;; Remove details.
  (dired-hide-details-mode 1)
  ;; Narrow the window.
  (setq visual-fill-column-width 70
	visual-fill-column-center-text t)
  (visual-fill-column-mode 1)
  ;; Omit `.` and `..`.
  (dired-omit-mode)
  ;; Highlight current line
  (hl-line-mode))

(use-package dired
  :ensure nil
  :commands (dired dired-jump)
  :hook (dired-mode . bc/dired-setup)
  :bind (("C-x C-j" . dired-jump))
  :config
  (evil-collection-define-key 'normal 'dired-mode-map
    "h" 'dired-up-directory
    "l" 'dired-find-file))
  
(use-package dired-single)

(use-package all-the-icons
  :if (display-graphic-p))

(use-package all-the-icons-dired
  :hook (dired-mode . all-the-icons-dired-mode))
