;; ensure installation of additional packages

(require 'package)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)

;;; check for new packages (package versions)
; (message "%s" "Emacs is now refreshing its package database...")
; (package-refresh-contents)
; (message "%s" " done.")

(defvar required-packages
  '(auctex clojure-mode coffee-mode deft gist haml-mode
           haskell-mode inf-ruby markdown-mode paredit projectile
           python sass-mode scss-mode solarized-theme yaml-mode yari zenburn-theme)
  "A list of packages to ensure are installed at launch.")

(dolist (p required-packages)
  (when (not (package-installed-p p))
    (package-install p)))

(provide 'init-packages)
