(defun bc-poetry-mode-define-hook ()
  (defface bc-poetry-marked-good
    `((t :background ,(doom-color 'fg-alt)
	 :foreground ,(doom-color 'bg-alt)))
    "Face for good syllables")

  (defface bc-poetry-marked-bad
    `((t :background ,(doom-color 'red)
	 :foreground ,(doom-color 'yellow)))
    "Face for bad syllables")

  (defface bc-poetry-marked-attention
    `((t :background ,(doom-color 'teal)
	 :foreground ,(doom-color 'cyan)))
    "Face for syllables that need attention")

  (defun bc-poetry-generate-header (num)
    (interactive "nNumber of columns: ")
    (let ((line ""))
      (dotimes (index num)
	(setq line (format "%s|%d" line (1+ index))))
      (setq line (format "%s|0|" line))
      (insert line)))

  (defun bc/bc-poetry-analyze-tables ()
    (org-table-map-tables
     (lambda ()
       (let (;; Remove hline symbol if any.
	     (table (cl-remove-if-not #'listp (org-table-to-lisp)))
	     (row-index 1)
	     (col-index 1))
	 (org-table-analyze)
	 (setq-local case-fold-search nil)
	 (dolist (row table)
	   (setq col-index 1)
	   (dolist (col row)
	     (let ((face nil))
	       (when (string-match "^[A-Z -]+$" col)
		 (setq face 'bc-poetry-marked-good))
	       (when (string-match "^\*" col)
		 (setq face 'bc-poetry-marked-bad))
	       (when (string-match "^\+" col)
		 (setq face 'bc-poetry-marked-attention))
	       (when (not (eq face nil))
		 (org-table-goto-field (format "@%d$%d" row-index col-index))
		 (let* ((beg (caar (object-intervals col)))
			(end (cadar (object-intervals col)))
			(pos (point))
			(overlay (make-overlay (+ pos beg) (+ pos end))))
		   (overlay-put overlay 'face face)
		   )))
	     (setq col-index (1+ col-index)))
	   (setq row-index (1+ row-index))
	   )))))


  (define-minor-mode bc-poetry-mode
    "Toggles bc-poetry-mode"
    :lighter " bc-poetry"
    :keymap
    `((,(kbd "C-c C-j h") . bc-poetry-generate-header))

    (setq-local org-table--separator-space-pre "")
    (setq-local org-table--separator-space-post "")

    (if bc-poetry-mode
	(message "bc-poetry-mode activated!")
      (message "bc-poetry-mode deactivated!"))

    (add-hook 'org-ctrl-c-ctrl-c-hook 'bc/bc-poetry-analyze-tables nil t))

  (add-hook 'bc-poetry-mode-hook (lambda () (message "bc-poetry hook exected!")))
  (add-hook 'bc-poetry-mode-on-hook (lambda () (message "bc-poetry turned on!")))
  (add-hook 'bc-poetry-mode-off-hook (lambda () (message "bc-poetry turned off!"))))

(add-hook 'org-mode-hook 'bc-poetry-mode-define-hook)
