(defun bc-poetry-mode-define-hook()
  (defvar bc-poetry-keymap-prefix "C-c C-j"
    "The prefix for bc-poetry-mode key bindings.")

  (defun bc-poetry--key (key)
    (kbd (concat bc-poetry-keymap-prefix " " key)))

  (defun bc-poetry-generate-header (num)
    (interactive "nNumber of columns: ")
    (let ((line ""))
      (dotimes (index num)
	(setq line (format "%s|%d" line (1+ index))))
      (setq line (format "%s|--|" line))
      (insert line)))


  (defun bc-poetry-parse-verse ()
    (interactive)
    (let* ((line (thing-at-point 'line t))
	   (escaped-line (shell-quote-argument line))
	   (verse (shell-command-to-string (format "versejador %s -N" escaped-line))))
      (delete-region (line-beginning-position) (line-end-position))
      (insert verse)
    ))


  (define-minor-mode bc-poetry-mode
    "Toggles bc-poetry-mode" nil
    :lighter " bc-poetry"
    :keymap
    (list (cons (bc-poetry--key "h") #'bc-poetry-generate-header)
	  (cons (bc-poetry--key "x") #'bc-poetry-parse-verse))

    (defvar bc-verse-stress-face 'bc-verse-stress-face "Verse stress syllable face.")
    (defface bc-verse-stress-face
      `((t (:inherit 'org-table :background ,(doom-color 'red) :foreground ,(doom-color 'bg))))
      "Verse stress syllable face.")

    (defvar bc-verse-rest-face 'bc-verse-rest-face "Verse rest syllables face.")
    (defface bc-verse-rest-face
      `((t (:inherit 'org-table :foreground ,(doom-color 'base6))))
      "Verse rest syllables face.")

    (setq-local org-table--separator-space-pre "")
    (setq-local org-table--separator-space-post "")
    (font-lock-add-keywords nil '(("\\(\s*\\+.+?\s*\\)|" 1 bc-verse-stress-face t)) 'append)
    (font-lock-add-keywords nil '(("\\(\s*--.+?\s*\\)|" 1 bc-verse-rest-face t)) 'append)

    (if bc-poetry-mode
 	(message "bc-poetry-mode activated!")
      (message "bc-poetry-mode deactivated!"))

    (add-hook 'bc-poetry-mode-hook (lambda () (message "bc-poetry hook executed!")))
    (add-hook 'bc-poetry-mode-on-hook (lambda () (message "bc-poetry turned on!")))
    (add-hook 'bc-poetry-mode-off-hook (lambda () (message "bc-poetry turned off!"))))


  (and buffer-file-name
       (string-match "poem.org$" buffer-file-name)
       (bc-poetry-mode 1))
  )


(add-hook 'org-mode-hook 'bc-poetry-mode-define-hook)
