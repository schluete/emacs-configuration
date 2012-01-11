;; emacs 24 configuration file
;; 2011-12-12

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes (quote ("1440d751f5ef51f9245f8910113daee99848e2c0" "485737acc3bedc0318a567f1c0f5e7ed2dfde3fb" "e254937cba0f82c2d9eb3189a60748df9e486522" default)))
 '(safe-local-variable-values (quote ((encoding . utf-8)))))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; und jetzt kommt unser eigener Kram
(add-to-list 'load-path "~/.emacs.d")
(require 'init-packages)
(require 'init-ui)
(require 'init-ruby)
(require 'init-stuff)


;; Kram der noch ausprobiert werden muss:
;;
;; - hippie expand is dabbrev expand on steroids
;; - https://github.com/bbatsov/emacs-prelude/blob/master/modules/prelude-editor.el
;; - time-stamps, when there's "Time-stamp: <>" in the first 10 lines of the file
;;   (setq time-stamp-active t
;;         ;; check first 10 buffer lines for Time-stamp: <>
;;         time-stamp-line-limit 10
;;         time-stamp-format "%04y-%02m-%02d %02H:%02M:%02S (%u)") ; date format
;;   (add-hook 'write-file-hooks 'time-stamp) ; update when saving
;; - load yasnippet
