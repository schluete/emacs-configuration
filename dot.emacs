
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(blink-cursor-mode nil)
 '(inhibit-startup-screen t)
 '(initial-buffer-choice nil)
 '(show-paren-mode nil)
 '(transient-mark-mode (quote (only . t))))

(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(mumamo-background-chunk-submode1 ((((class color) (min-colors 88) (background dark)) (:background "#200"))))
 '(mumamo-background-chunk-submode2 ((((class color) (min-colors 88) (background dark)) (:background "#200")))))

(setq default-frame-alist
      '((top . 50)
        (left . 400)
        (width . 130)
        (height . 60)
        (font . "Bitstream_Vera_Sans_Mono")
        ))

(add-to-list 'load-path "~/.emacs.d/site-lisp/")
;(add-to-list 'load-path "~/.emacs.d/vendor")
;(progn (cd "~/.emacs.d/vendor")
;       (normal-top-level-add-subdirs-to-load-path))

;; VIM lookalike-support und dafuer auch gleich noch passendes Undo
(require 'undo-tree)
(global-undo-tree-mode)
(add-to-list 'load-path "~/.emacs.d/vimpulse/")
(require 'vimpulse)

;; wir wollen einfaches Syntax-Highlighting haben, also zuerst das 
;; color-theme.el laden, und danach unser Blackboard-Theme
(add-to-list 'load-path "~/.emacs.d/themes/")
(require 'color-theme)
(setq color-theme-load-all-themes nil)
(setq color-theme-directory "~/.emacs.d/themes") 
(color-theme-initialize)

;; (load-file "~/.emacs.d/themes/color-theme-blackboard.el")
(color-theme-blackboard)
; (color-theme-solarized-dark)
; (color-theme-solarized-light)


;; unser Default-Font ist Vera Sans Mono von Bitstream 
(let ((spec '((t (:family "Bitstream_Vera_Sans_Mono" :height 120)))))
    (mapc (lambda (face)
        (face-spec-set face spec)
        (put face 'face-defface-spec spec))
        '(default menu)))

;; der Abstand zwischen den Zeilen soll dem im vim entsprechen, das 
;; sieht mit dem Vera Sans Mono Font schoen aus
(setq-default line-spacing 0.2)

;; deutsche Umlaute und das Problem des modifizierten Tastaturlayouts
(global-set-key "\M-'" 'insert-umlaut-ae)
(global-set-key "\M-\"" 'insert-umlaut-upcase-ae)
(global-set-key "\M-;" 'insert-umlaut-oe)
(global-set-key "\M-:" 'insert-umlaut-upcase-oe)
(global-set-key "\M-[" 'insert-umlaut-ue)
(global-set-key "\M-{" 'insert-umlaut-upcase-ue)
(global-set-key "\M-\-" 'insert-umlaut-ss)
(global-set-key "\M-_" 'insert-umlaut-ss)
(defun insert-umlaut-ae () (interactive) (insert "ä"))
(defun insert-umlaut-upcase-ae () (interactive) (insert "Ä"))
(defun insert-umlaut-oe () (interactive) (insert "ö"))
(defun insert-umlaut-upcase-oe () (interactive) (insert "Ö"))
(defun insert-umlaut-ue () (interactive) (insert "ü"))
(defun insert-umlaut-upcase-ue () (interactive) (insert "Ü"))
(defun insert-umlaut-ss () (interactive) (insert "ß"))

;; amerikanisches Layout auf deutscher Tastatur laesst die Tilde
(global-set-key "±" 'insert-tilde)
(defun insert-tilde () (interactive) (insert "~"))

;; fuer den Emacsclient lassen wir noch den Server laufen
(server-start)

;; bessere Uebersicht aller offenen Buffer
;; http://www.emacswiki.org/emacs/IbufferMode
(global-set-key (kbd "C-x C-b") 'ibuffer)
(global-set-key (kbd "<f2>") 'ibuffer)
(autoload 'ibuffer "ibuffer" "List buffers." t)
;(require 'ibuf-ext)
;(add-to-list 'ibuffer-never-show-predicates "^\\*")

(setq ibuffer-saved-filter-groups nil)
(setq ibuffer-saved-filters
      (quote (("python" ((name . ".*\\.py")))
              ("magit" ((name . "\*magit.*")))
              ("programming" ((or
                               (mode . emacs-lisp-mode)
                               (mode . cperl-mode)
                               (mode . c-mode)
                               (mode . java-mode)
                               (mode . idl-mode)
                               (mode . lisp-mode)))))))
(setq ibuffer-default-sorting-mode 'alphabetic)
(setq ibuffer-always-show-last-buffer t)
(setq ibuffer-expert t)


;; keine Tabs sondern Whitespaces, ausserdem die Default-Tabwidth
(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)
(setq-default c-basic-offset 2)

;; yasnippets 
(require 'yasnippet)
(setq yas/root-directory "~/.emacs.d/snippets")
(yas/load-directory yas/root-directory)

;; ctags
(require 'etags-select)
(require 'etags-table)
(setq etags-table-search-up-depth 10)
(setq etags-table-alist
      (list
       ;; For jumping to standard headers:
       ;'(".*\\.\\([ch]\\|cpp\\)" "c:/Program Files/Microsoft SDKs/Windows/v6.1/Include/TAGS")
       ;; For jumping across project:
       ;'("/home/devel/proj1/" "/home/devel/proj2/TAGS" "/home/devel/proj3/TAGS")
       ;'("/home/devel/proj2/" "/home/devel/proj1/TAGS" "/home/devel/proj3/TAGS")
       ;'("/home/devel/proj3/" "/home/devel/proj1/TAGS" "/home/devel/proj2/TAGS")
       ))
(global-set-key "\M-." 'etags-select-find-tag)

;(setq path-to-ctags "/opt/local/bin/ctags")
;(defun create-tags (dir-name)
;  "Create tags file."
;  (interactive "Directory: ")
;  (shell-command
;   (format "%s -f %s/TAGS -e -R %s" path-to-ctags dir-name (directory-file-name dir-name))))

;; autocompletion
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/site-lisp/ac-dict")
(ac-config-default)
(global-auto-complete-mode t)

;; dirty fix for having AC everywhere
(define-globalized-minor-mode real-global-auto-complete-mode
  auto-complete-mode (lambda ()
                       (if (not (minibufferp (current-buffer)))
                           (auto-complete-mode 1))
                       ))
(real-global-auto-complete-mode t)


(setq ac-use-fuzzy t)
(setq ac-auto-start nil)
(global-set-key (kbd "C-SPC") 'auto-complete)

(setq ac-use-menu-map t)
(define-key ac-menu-map "\C-j" 'ac-next)
(define-key ac-menu-map "\C-k" 'ac-previous)

;; initialize the python mode
(add-hook 'python-mode-hook 
          '(lambda () 
             (setq tab-width 4)
             (setq viper-shift-width 4)
             (define-key python-mode-map "\C-m" 'newline-and-indent)
             (require 'virtualenv)))

; auto completion, yasnippets fuer python konfigurieren
(add-hook 'python-mode-hook
          '(lambda ()
             (add-to-list 'ac-sources 'ac-source-yasnippet)
             (add-to-list 'ac-sources 'ac-source-words-in-same-mode-buffers)
             (add-to-list 'ac-sources 'ac-source-filename)
             (yas/minor-mode-on)))

(setq-default py-indent-offset 4)
;(setq-default python-python-command "/opt/local/bin/ipython2.6")

(setq-default virtualenv-root "/Users/schluete/Development/hudora/virtualenvs")
;(setq-default virtualenv-workon-starts-python nil)

;; keine Tilde-Files, keine Autosave-Files
(setq make-backup-files nil)
(setq auto-save-default nil)
(setq backup-inhibited t)

;; indentation im cc-mode fuer einige Stellen reparieren
(setq c-offsets-alist '((case-label . 2)))

;; ruby mode configuration
(add-hook 'ruby-mode-hook 
          '(lambda () 
             (define-key ruby-mode-map "\C-m" 'newline-and-indent)))

;; yaml mode
(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))
(add-to-list 'auto-mode-alist '("\\.yaml$" . yaml-mode))
(add-hook 'yaml-mode-hook
          '(lambda ()
             (define-key yaml-mode-map "\C-m" 'newline-and-indent)))

;; haml-mode from https://github.com/nex3/haml-mode
(autoload 'haml-mode "haml-mode"
  "Edit haml documents" t)
(add-to-list 'auto-mode-alist '("\\.haml$" . haml-mode))

;; jinja2 mode
(autoload 'jinja-mode "jinja")

;; clojure and slime configuration
(add-to-list 'load-path "~/.emacs.d/clojure-mode/")
(require 'clojure-mode)
;(require 'clojure-test-mode)

(add-hook 'Man-mode-hook 'viper-mode)
(add-hook 'help-mode-hook 'viper-mode)
(add-hook 'view-mode-hook 'viper-mode)
(add-hook 'clojure-mode 'viper-mode)

(add-hook 'slime-repl-mode-hook
          (lambda ()
            (viper-mode)
            (clojure-mode-font-lock-setup)))

(add-hook 'slime-mode-hook
          (lambda ()
            (setq slime-truncate-lines nil)
            (slime-redirect-inferior-output)))

(eval-after-load "slime" 
  '(progn (slime-setup '(slime-repl))
          ;(defun paredit-mode-enable () (paredit-mode 1))	
          ;(add-hook 'slime-mode-hook 'paredit-mode-enable)	
          ;(add-hook 'slime-repl-mode-hook 'paredit-mode-enable)
          (setq slime-protocol-version 'ignore)))

(add-to-list 'load-path "~/.emacs.d/slime/")
;(setq inferior-lisp-program "/opt/sbcl/bin/sbcl") ; your Lisp system
(require 'slime)
(slime-setup)
;;(slime-setup '(slime-repl))

;; Git support via git-emacs.el
(autoload 'magit-status "magit" nil t)
(setq magit-git-executable "/opt/local/bin/git")
(autoload 'git-blame-mode "git-blame"
  "Minor mode for incremental blame for Git." t)
(global-set-key (kbd "<f3>") 'magit-status)

;; nXhtml mode configuration for HTML editing
(load "~/.emacs.d/nxhtml/autostart.el")

;; Markdown support
(autoload 'markdown-mode "markdown-mode.el"
  "Major mode for editing Markdown files" t)
(setq auto-mode-alist
      (cons '("\\.md" . markdown-mode) auto-mode-alist))
(defun markdown-customization ()
  "markdown-mode-hook"
  (setq markdown-command "rdiscount")
  (setq markdown-indent-on-enter t))

(add-hook 'markdown-mode-hook
          '(lambda() (markdown-customization)))


;; custom javascript mode. Wir benutzen js2-mode fuer Highlighting etc., aber die
;; Indentation da ist voellig unbenutzbar, dafuer kommt espresso zum Einsatz
; http://mihai.bazon.net/projects/editing-javascript-with-emacs-js2-mode
; https://github.com/mooz/js2-mode
(autoload 'js2-mode "js2-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
(add-hook 'js2-mode-hook
          (lambda ()
            (auto-complete-mode)))
(add-hook 'objc-mode-hook
          (lambda ()
            (auto-complete-mode)))
(setq js2-indent-on-enter-key nil)
(setq js2-enter-indents-newline t)
(setq js2-bounce-indent-p t)
(setq js2-cleanup-whitespace t)
(setq js2-mirror-mode nil)
(setq js2-mode-show-parse-errors nil)
(setq js2-consistent-level-indent-inner-bracket-p t)

;(autoload 'espresso-mode "espresso")
;(setq espresso-indent-level 2)

;; (add-to-list 'auto-mode-alist '("\\.js$" . espresso-mode))
;; (add-to-list 'auto-mode-alist '("\\.json$" . espresso-mode))
;; (autoload 'espresso-mode "espresso" nil t)
;; (add-hook 'espresso-mode-hook
;;          (lambda ()
;;            (auto-complete-mode)))

;; Vi(per)- Support fuer mehr Buffer, ausserdem einige zusaetzliche Keybindings
(require 'viper-in-more-modes)
(add-hook 'ibuffer-mode-hooks 'viper-mode)
(add-hook 'magit-mode-hook 'viper-mode)

;; Tramp configuration fuer den Remotezugriff auf andere Rechner
(setq tramp-default-method "ssh")
; C-x C-f /libertad:~/src/foobar

;; Go mode
(autoload 'go-mode "go-mode" "\
Major mode for editing Go source text.

This provides basic syntax highlighting for keywords, built-ins,
functions, and some types.  It also provides indentation that is
\(almost) identical to gofmt.

\(fn)" t nil)

(add-to-list 'auto-mode-alist (cons "\\.go$" #'go-mode))

(autoload 'gofmt "go-mode" "\
Pipe the current buffer through the external tool `gofmt`.
Replace the current buffer on success; display errors on failure.

\(fn)" t nil)

(autoload 'gofmt-before-save "go-mode" "\
Add this to .emacs to run gofmt on the current buffer when saving:
 (add-hook 'before-save-hook #'gofmt-before-save)

\(fn)" t nil)

;; verschiedenster Kleinkram
(setq visible-bell t) ; no audible bell but a visual one instead
(setq ring-bell-function 'ignore) ; now turn off the bell completely
(global-auto-revert-mode t) ; geaenderte Files automatisch neu laden
(setq split-width-threshold nil) ; Windows grundsaetzlich nur vertical splitten
(setq-default debug-on-error nil) ; kein Debugger bei normalen Fehlern, nervt beim
                                  ; Viper bspw. bei einen "h" am Anfang der Zeile 
(setq ns-pop-up-frames 'nil) ; keine neuen Fenster fuer jede Datei bei XCode

(global-set-key (kbd "s-§") 'other-frame) ; cmd-~ Fensterwechsel wie ueblich auf dem Mac
(global-set-key (kbd "s-|") 'comment-or-uncomment-region)
(global-set-key (kbd "C-m") 'newline-and-indent)
(require 'axel-utilities)
(define-key viper-vi-global-user-map "\C-wa" 'swap-buffers-in-windows)
(define-key viper-emacs-global-user-map "\C-wa" 'swap-buffers-in-windows)

(define-key viper-vi-global-user-map "\C-w+" 'enlarge-window)
(define-key viper-vi-global-user-map "\C-w-" 'shrink-window)
(define-key viper-emacs-global-user-map "\C-w+" 'enlarge-window)
(define-key viper-emacs-global-user-map "\C-w-" 'shrink-window)

(define-key viper-vi-global-user-map "\M-C-/" 'comment-or-uncomment-region)
(define-key viper-emacs-global-user-map "\M-C-/" 'comment-or-uncomment-region)

(autoload 'ack "ack-emacs" "ack extended grep support" t)
(setq ack-command "/opt/local/bin/ack")

(column-number-mode 1) ; display the current column in the mode line
(size-indication-mode 1) ; display file size in the mode line
; M-x count-lines-region    Display the number of lines in the current region
; C-x =                     Display the character code of character after point
