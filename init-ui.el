;; UI configuration stuff

;; On OS X Emacs doesn't use the shell PATH if it's not started from
;; the shell. If you're using homebrew modifying the PATH is essential.
(if (eq system-type 'darwin)
    (push "/usr/local/bin" exec-path))

;; fuer den Emacsclient lassen wir noch den Server laufen
(server-start)

;; some basic UI configuration and theming, das Fenster faengt immer direkt
;; unterhalb der Menueleiste an, mein aktueller Lieblingsfont ist auch gesetzt
(setq initial-frame-alist
      '((top . 22)
        (font . "Bitstream_Vera_Sans_Mono")))

;; wenn wir Emacs auf dem Laptop (1440x900) starten wird das erste Fenster
;; automatisch auf die richtige Groesse und Position eingestellt
(let* ((width (display-pixel-width))
       (frame-args (cond ((= width 1440) '((left . 8)     ; internal MBA display
                                           (width . 200)
                                           (height . 60)))
                         ((= width 1920) '((left . 150)   ; der 24" Dell bei Anja
                                           (width . 232)
                                           (height . 72)))
                         ((= width 2560) '((left . 400)   ; das 27" Thunderbolt
                                           (width . 232)
                                           (height . 91))))))
  (setq initial-frame-alist (append frame-args initial-frame-alist)))

;; default-frame-alist is defined in terms of initial-frame-alist.  Don't
;; use copy-sequence here, it doesn't copy the list elements, just the
;; list's cons cells.
(setq default-frame-alist (copy-alist initial-frame-alist))

;; ich will das Fenster eigentlich immer in zwei Teile geteilt haben
(split-window-horizontally)

;; einfache Moeglichkeit, das aktuelle Fenster auf verschiedene Bildschirmgroessen anzupassen.
(defun optimal-frame-size ()
  (interactive)
  (let ((frame (selected-frame)))
    (if (= (display-pixel-width) 1440)
        (progn (set-frame-size frame 200 60)
               (set-frame-position frame 8 22))
      (set-frame-size frame 232 91))))

;; Themes und Anpassungen fuer den ausgewaehlten Font, dmait's schoen aussieht
(setq-default line-spacing 0.2)
;(load-theme 'wombat)
(load-theme 'tango-dark)
;(load-theme 'solarized-dark)

(delete-selection-mode t)
(scroll-bar-mode t)              ; vertical scrollbars
(tool-bar-mode -1)               ; no icon toolbar at the top of the window
(blink-cursor-mode -1)           ; no blinking cursor
(show-paren-mode -1)             ; no indication of matching paren, evil takes care of this
(set-fringe-style -1)            ; please no fringes at the borders
(tooltip-mode -1)                ; no tooltip windows, just inidications in the mode line
(column-number-mode 1)           ; display the current column in the mode line
(size-indication-mode 1)         ; display file size in the mode line
(setq inhibit-startup-screen t)  ; don't display a startup screen

;; keine Tabs sondern Whitespaces, ausserdem die Default-Tabwidth
(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)
(setq-default c-basic-offset 2)

;; keine Tilde-Files, keine Autosave-Files
(setq-default make-backup-files nil)
(setq-default auto-save-default nil)
(setq-default backup-inhibited t)

;;(global-set-key (kbd "s-|") 'comment-or-uncomment-region)

;; load and initialize the Evil vim emulation
(add-to-list 'load-path "~/.emacs.d/evil")
(require 'evil)
(evil-mode 1)
(setq-default evil-shift-width 2)

;; pressing [enter] always indents the line
(define-key evil-insert-state-map "\C-m" 'newline-and-indent)

;; [cmd-shift-\] will (un)comment the current region
(define-key evil-normal-state-map (kbd "s-|") 'comment-or-uncomment-region)

;; deutsche Umlaute und das Problem des modifizierten Tastaturlayouts
(define-key key-translation-map (kbd "M-'") (kbd "ä"))
(define-key key-translation-map (kbd "M-\"") (kbd "Ä"))
(define-key key-translation-map (kbd "M-;") (kbd "ö"))
(define-key key-translation-map (kbd "M-:") (kbd "Ö"))
(define-key key-translation-map (kbd "M-[") (kbd "ü"))
(define-key key-translation-map (kbd "M-{") (kbd "Ü"))
(define-key key-translation-map (kbd "M-\-") (kbd "ß"))

;; in einem zweigeteilten Fenster die Buffer links und rechts vertauschen
(require 'axel-utilities)
(define-key evil-normal-state-map (kbd "\C-wa") 'swap-buffers-in-windows)

;; temporaer brauchen wir noch den ibuffer zu auswahl
;(global-set-key (kbd "C-x C-b") 'ibuffer)
(global-set-key (kbd "<f2>") 'ibuffer)
(autoload 'ibuffer "ibuffer" "List buffers." t)
;(require 'ibuf-ext)
;(add-to-list 'ibuffer-never-show-predicates "^\\*")

(eval-after-load 'ibuffer
  '(progn
     ;; use the standard ibuffer bindings as a base
     (set-keymap-parent
      (evil-get-auxiliary-keymap ibuffer-mode-map 'normal t)
      (assq-delete-all 'menu-bar (copy-keymap ibuffer-mode-map)))
     (evil-define-key 'normal ibuffer-mode-map "j" 'ibuffer-forward-line)
     (evil-define-key 'normal ibuffer-mode-map "k" 'ibuffer-backward-line)
     (evil-define-key 'normal ibuffer-mode-map "J" 'ibuffer-jump-to-buffer) ; "j"
     (evil-define-key 'normal ibuffer-mode-map (kbd "DEL") 'ibuffer-unmark-backward)))

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

(add-hook 'ibuffer-mode-hook 'evil-exit-emacs-state)

(provide 'init-ui)
