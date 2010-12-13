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

(provide 'axel-utilities)
;;; axel-utilities.el ends here

