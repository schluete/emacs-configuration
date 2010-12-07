;;; axel-utilities.el --- generell utility functions written by myself

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
