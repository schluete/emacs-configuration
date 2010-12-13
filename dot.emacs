
;; http://emacs-fu.blogspot.com/


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

(setq default-frame-alist
      '((top . 50) (left . 400)
	(width . 130) (height . 60)
	))

(add-to-list 'load-path "~/.emacs.d/site-lisp/")
;(add-to-list 'load-path "~/.emacs.d/vendor")
;(progn (cd "~/.emacs.d/vendor")
;       (normal-top-level-add-subdirs-to-load-path))

;; VIM lookalike-support und dafuer auch gleich noch passendes Undo
(require 'undo-tree)
(global-undo-tree-mode)
(require 'vimpulse)

;; wir wollen einfaches Syntax-Highlighting haben, also zuerst das 
;; color-theme.el laden, und danach unser Blackboard-Theme
(require 'color-theme)
(setq color-theme-load-all-themes nil)
(setq color-theme-directory "~/.emacs.d/themes") 
(color-theme-initialize)

;; (load-file "~/.emacs.d/themes/color-theme-blackboard.el")
(color-theme-blackboard)

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

;; (setq ibuffer-saved-filter-groups
;;           (quote (("default"
;;                    ("dired" (mode . dired-mode))
;;                    ("perl" (mode . cperl-mode))
;;                    ("erc" (mode . erc-mode))
;;                    ("planner" (or
;;                                (name . "^\\*Calendar\\*$")
;;                                (name . "^diary$")
;;                                (mode . muse-mode)))
;;                    ("emacs" (or
;;                              (name . "^\\*scratch\\*$")
;;                              (name . "^\\*Messages\\*$")))
;;                    ("gnus" (or
;;                             (mode . message-mode)
;;                             (mode . bbdb-mode)
;;                             (mode . mail-mode)
;;                             (mode . gnus-group-mode)
;;                             (mode . gnus-summary-mode)
;;                             (mode . gnus-article-mode)
;;                             (name . "^\\.bbdb$")
;;                             (name . "^\\.newsrc-dribble")))))))
;;     (add-hook 'ibuffer-mode-hook
;;               (lambda ()
;;                 (ibuffer-switch-to-saved-filter-groups "default")))


;; Vi(per)- Support fuer mehr Buffer
(require 'viper-in-more-modes)
(add-hook 'ibuffer-mode-hooks 'viper-mode)

;; keine Tabs sondern Whitespaces, ausserdem die Default-Tabwidth
(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)
(setq-default c-basic-offset 2)

;; yasnippets 
(require 'yasnippet)
(setq yas/root-directory "~/.emacs.d/snippets")
(yas/load-directory yas/root-directory)

;; autocompletion
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/site-lisp/ac-dict")
(ac-config-default)

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
             (yas/minor-mode-on)))


(setq-default py-indent-offset 4)
;(setq-default python-python-command "/opt/local/bin/ipython2.6")

(setq-default virtualenv-root "/Users/schluete/Development/hudora/virtualenvs")
;(setq-default virtualenv-workon-starts-python nil)

;; keine Tilde-Files, keine Autosave-Files
(setq make-backup-files nil)
(setq auto-save-default nil)
(setq backup-inhibited t)

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

;; clojure and slime configuration
(require 'clojure-mode)
;(eval-after-load "slime" 
;  '(progn (slime-setup '(slime-repl))))

(add-hook 'clojure-mode
          'viper-mode)

(add-hook 'slime-repl-mode-hook
          (lambda ()
            (viper-mode)
            (clojure-mode-font-lock-setup)))

(add-hook 'slime-mode-hook
          (lambda ()
            (setq slime-truncate-lines nil)
            (slime-redirect-inferior-output)))

(add-to-list 'load-path "/Users/schluete/.emacs.d/slime/")
;(setq inferior-lisp-program "/opt/sbcl/bin/sbcl") ; your Lisp system
(require 'slime)
(slime-setup '(slime-repl))


;; verschiedenster Kleinkram
(setq visible-bell t)              ; turn off the bell completely
(setq ring-bell-function 'ignore)

(global-set-key (kbd "C-m") 'newline-and-indent)
(require 'axel-utilities)
(global-set-key (kbd "C-c j") 'swap-buffers-in-windows)


