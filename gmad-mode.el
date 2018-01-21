(defvar gmad-mode-hook nil) ; don't know how to use this yet.

(defvar gmad-mode-syntax-table nil "Syntax table for `gmad-mode'.")

(setq gmad-mode-syntax-table
      ;; make-syntax-table inherits standard-syntax-table, which we
      ;; then modify to add our comment flavour.
      (let ( (table (make-syntax-table)))
        ;; python style comment: “# …”
        (modify-syntax-entry ?! "<" table)
        (modify-syntax-entry ?\n ">" table)
        table))

(setq gmad-fontlock-keywords
      (let* (
	     ;; from parser.cc
	     (gmad-functions '("sqrt" "cos" "sin" "exp" "log" "tan"
			       "asin" "acos" "atan" "abs"))
	     ;; from parser.cc
	     (gmad-constants '("pi"
			       "TeV" "GeV" "MeV" "keV" "KeV" "eV"
			       "V" "kV" "MV"
			       "Tesla"
			       "km" "m" "cm" "mm" "um" "mum" "nm" "pm"
			       "s" "ms" "us" "ns" "ps"
			       "Hz" "kHz" "GHz"
			       "rad" "mrad" "urad"
			       "degrees"
			       "clight"))
	     (gmad-functions-regexp (regexp-opt gmad-functions 'words))
	     (gmad-constants-regexp (regexp-opt gmad-constants 'words)))
	`(
	  (,gmad-functions-regexp . font-lock-builtin-face)
	  (,gmad-constants-regexp . font-lock-constant-face)
	  )))

(define-derived-mode gmad-mode prog-mode "GMAD MODE"
  "Major mode for editing Graphical Methodical Accelerator Design
(GMAD). "
(setq font-lock-defaults '((gmad-fontlock-keywords)))
(setq comment-start "!")
(set-syntax-table gmad-mode-syntax-table))


(provide 'gmad-mode)
