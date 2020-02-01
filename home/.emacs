(require 'package)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  (when no-ssl
    (warn "\
Your version of Emacs does not support SSL connections,
which is unsafe because it allows man-in-the-middle attacks.
There are two things you can do about this warning:
1. Install an Emacs version that does support SSL and be safe.
2. Remove this warning from your init file so you won't see it again."))
  ;; Comment/uncomment these two lines to enable/disable MELPA and MELPA Stable as desired
  (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
  ;;(add-to-list 'package-archives (cons "melpa-stable" (concat proto "://stable.melpa.org/packages/")) t)
  (when (< emacs-major-version 24)
    ;; For important compatibility libraries like cl-lib
    (add-to-list 'package-archives (cons "gnu" (concat proto "://elpa.gnu.org/packages/")))))
(package-initialize)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (helm helm-projectile yasnippet yaml-mode projectile avy company-lsp typescript-mode company solarized-theme magit))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(define-key global-map "\C-ca" 'org-agenda)
(setq org-agenda-files (list "~/Dropbox/agenda/" "~/Dropbox/agenda/fitness/" "~/Dropbox/agenda/fitness/workouts/"))

(global-set-key [(super g)] 'magit-status)

(load-theme 'solarized-dark t)

(set-face-attribute 'default nil
                  :font "DejaVu Sans Mono")

(when window-system
    (tool-bar-mode -1)
  (menu-bar-mode -1)
  (toggle-scroll-bar -1)
  )

(setq-default display-line-numbers 'relative)

(add-hook 'after-init-hook 'global-company-mode)

(require 'company-lsp)
(push 'company-lsp company-backends)

(setq company-idle-delay 0)

(use-package flycheck
  :ensure t
  :init (global-flycheck-mode))

(require 'lsp-mode)
(add-hook 'typescript-mode-hook #'lsp-deferred)
(add-hook 'elixir-mode-hook #'lsp-deferred)
(add-hook 'elixir-mode-hook #'yas-minor-mode)

(global-set-key (kbd "C-;") 'avy-goto-char)

(add-to-list 'exec-path "~/.asdf/shims/")
(add-to-list 'exec-path "~/.elixir-ls/release/")

(require 'projectile)
(define-key projectile-mode-map [?\s-f] 'helm-projectile)
(define-key projectile-mode-map [?\s-p] 'helm-projectile-switch-project)
(projectile-mode +1)

