;; all the other configuration stuff

;; beim Speichern sollen alle trailing whitespaces am Ende der Zeilen geloescht werden,
;; ausserdem noch Leerzeilen am Ende und am Anfang der Datei etc. blabla.
(add-hook 'before-save-hook 'whitespace-cleanup)

;; wenn eine .h-Datei geoeffnet wird und diese den String "@interface" enthaelt
;; dann gehen wir mal von Objective C aus und laden den entsprechenden Mode
(add-to-list 'magic-mode-alist
             `(,(lambda ()
                  (and (string= (file-name-extension buffer-file-name) "h")
                       (re-search-forward "@\\<interface\\>"
                                          magic-mode-regexp-match-limit t)))
               . objc-mode))

;; tramp, for sudo access
(require 'tramp)
(setq tramp-default-method "ssh")

;; no audible nor visual bell
(setq-default visible-bell t)
(setq-default ring-bell-function 'ignore)

;; geaenderte Files automatisch neu laden
(global-auto-revert-mode t)

;; Windows grundsaetzlich nur vertical splitten
(setq-default split-width-threshold nil)

;; indentation im cc-mode fuer einige Stellen reparieren
(setq-default c-offsets-alist '((case-label . 2)))

;;; kein Debugger bei normalen Fehlern, nervt beim
;;; Viper bspw. bei einen "h" am Anfang der Zeile
;(setq-default debug-on-error nil)

;;; keine neuen Fenster fuer jede Datei bei XCode
;(setq ns-pop-up-frames 'nil)

;; A happy word and the world looks brither again!
(message "%s" "I love it when a plan comes together!")

(provide 'init-stuff)
