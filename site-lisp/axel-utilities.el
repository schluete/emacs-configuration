;;; axel-utilities.el --- generell utility functions written by myself

(defun xml-pretty-print ()
  "reformat an XML buffer through xmllint"
  (interactive)
  (save-excursion
    (shell-command-on-region (point-min) (point-max) "xmllint --format -" (buffer-name) t)
    (nxml-mode)
    (indent-region begin end)))


(defun swap-buffers-in-windows ()
  "swap buffers from the selected window with the next window"
  (interactive)
  (let* ((this (selected-window))
         (other (next-window))
         (this-buffer (window-buffer this))
         (other-buffer (window-buffer other)))
    (set-window-buffer other this-buffer)
    (set-window-buffer this other-buffer)))


;; was brauchen wir noch alles fuer einen graphischen Filebrowser?
;; - http://www.emacswiki.org/emacs/FileNameCache
;; - http://www.gnu.org/software/emacs/manual/html_node/emacs/Directory-Variables.html
;; - https://github.com/mattkeller/mk-project
;; 

(defun show-frame-and-buffer-info ()
  "simple test call to check where to get infos about the buffer"
  (interactive)
  (message "current buffer is %s, frame size is %d+%d+%dx%d"
           (buffer-file-name)
           (frame-parameter nil 'left)
           (frame-parameter nil 'top)
           (frame-pixel-width)
           (frame-pixel-height)))

(provide 'axel-utilities)
;;; axel-utilities.el ends here

