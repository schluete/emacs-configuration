;;; axel-project-mode.el --- simple major mode to provide a fast file switcher
;;
;; http://xahlee.org/emacs/make_sitemap.html
;; 

(make-face 'my-date-face)
(set-face-attribute 'my-date-face nil :underline t)
(set-face-attribute 'my-date-face nil :family "times")
(set-face-attribute 'my-date-face nil :slant 'normal)
(set-face-attribute 'my-date-face nil :height '340)

;;;###autoload
(define-generic-mode axel-project-mode
  '(("/*" . "*/"))                                       ; comment characters
  '("hello" "hi" "howdy" "greetings" "hola")             ; keywords
  '(("\\([0-9]+/[0-9]+/[0-9]+\\)" (1 'my-date-face)))    ; font lock
  '("\\*Project\\*$")                                    ; auto-mode-alist  
  '(project-mode-setup)                                  ; function-list
  "A major mode for easy handling of a bundle of files called a project.")

(defun project-mode-setup ()
  "Some custom setup stuff done here by mode writer."
  (insert "this text gets inserted")
  (goto-char 0)
  (search-forward "gets")
  (insert " right now")
  ;(setq buffer-read-only t)
  (message "You've just enabled the most amazing mode ever."))

(defun show-project ()
  (interactive)
  (let ((buf (get-buffer-create "*Project*"))
        (window (next-window)))
    (set-window-buffer window buf)
    (select-window window)
    (or (eq major-mode 'axel-project-mode)
        (axel-project-mode))
))

(provide 'axel-project-mode)
