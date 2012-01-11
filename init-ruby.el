;; configure everything needed for programming Ruby and Rails in Emacs

;; ruby mode configuration
(add-to-list 'auto-mode-alist '("Capfile" . ruby-mode))
(add-to-list 'auto-mode-alist '("Gemfile" . ruby-mode))
(add-to-list 'auto-mode-alist '("Rakefile" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.rake\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.rb\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.ru\\'" . ruby-mode))
(add-hook 'ruby-mode-hook
          '(lambda ()
             (setq ruby-deep-arglist t)
             (setq ruby-deep-indent-paren nil)
             (setq c-tab-always-indent nil)
             ;(require 'inf-ruby)
             ;(require 'ruby-compilation)
             ;(define-key ruby-mode-map (kbd "M-r") 'run-rails-test-or-ruby-buffer)
             (define-key ruby-mode-map "\C-m" 'newline-and-indent)))

;; yaml mode
(add-to-list 'load-path "~/.emacs.d/yaml-mode")
(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))
(add-hook 'yaml-mode-hook
          '(lambda ()
             (define-key yaml-mode-map "\C-m" 'newline-and-indent)))

;; schoeneres Editieren von haml-Templates und scss Stylesheets
(require 'haml-mode)
(require 'scss-mode)
(add-hook 'scss-mode-hook
          '(lambda ()
             (setq css-indent-offset 2)
             (setq scss-compile-at-save nil)))

;; und noch ein paar Einstellungen fuer normales CSS
(add-hook 'css-mode-hook
          '(lambda ()
             (setq css-indent-level 2)
             (setq css-indent-offset 2)
             (define-key css-mode-map "\C-m" 'newline-and-indent)))

;; sonstiger Rails-Krams

;; (defun is-rails-project ()
;;   (when (textmate-project-root)
;;     (file-exists-p (expand-file-name "config/environment.rb" (textmate-project-root)))))

;; (defun run-rails-test-or-ruby-buffer ()
;;   (interactive)
;;   (if (is-rails-project)
;;       (let* ((path (buffer-file-name))
;;              (filename (file-name-nondirectory path))
;;              (test-path (expand-file-name "test" (textmate-project-root)))
;;              (command (list ruby-compilation-executable "-I" test-path path)))
;;         (pop-to-buffer (ruby-compilation-do filename command)))
;;     (ruby-compilation-this-buffer)))

; https://github.com/eschulte/rinari ??
; http://www.viget.com/extend/emacs-24-rails-development-environment-from-scratch-to-productive-in-5-minu/
; https://github.com/r0man/emacs-rails-reloaded

(provide 'init-ruby)
