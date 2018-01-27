(defvar gmad-mode-hook nil) ; don't know how to use this yet.

(defvar gmad-mode-syntax-table nil "Syntax table for `gmad-mode'.")

(setq gmad-mode-syntax-table
      ;; make-syntax-table inherits standard-syntax-table, which we
      ;; then modify to add our comment flavour.
      (let ( (table (make-syntax-table)))
        ;; python style comment: “# …”
        (modify-syntax-entry ?! "<" table)
        (modify-syntax-entry ?\n ">" table)
	(modify-syntax-entry ?_ "w" table)
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
	     (gmad-preprocessor '("include"))
	     (gmad-types '(
			   ;; beamline.  from elementtype.cc
			   "marker" "drift" "rf" "sbend" "rbend" "vkicker"
			   "hkicker" "kicker" "tkicker" "quadrupole"
			   "sextupole" "octupole" "decapole"
			   "multipole" "thinmult" "solenoid" "ecol" "rcol"
			   "muspoiler" "shield" "degrader" "laser"
			   "screen" "awakescreen" "awakespectrometer"
			   "transform3d" "line"

			   ;; other definitions
			   "element" "atom" "field" "material"
			   "physicsbiasing" "placement" "query"
			   "region" "tunnel" "cavitymodel"
			   ))
	     (gmad-keywords '("beam" "option" "print" "range" "stop" "use"
			      "sample" "csample" ))
	     (gmad-functions-regexp (regexp-opt gmad-functions 'words))
	     (gmad-constants-regexp (regexp-opt gmad-constants 'words))
	     (gmad-preprocessor-regexp (regexp-opt gmad-preprocessor 'words))
	     (gmad-types-regexp (regexp-opt gmad-types 'words))
	     (gmad-keywords-regexp (regexp-opt gmad-keywords 'words))
	     ;; make a group of the word as we want to select just
	     ;; that to be highlighted, i.e. exclude the colon.
	     (gmad-variables-regexp (rx (group (1+ word))
					(0+ space)
					?:
					(0+ space)
					)))
	`(
	  (,gmad-functions-regexp . font-lock-builtin-face)
	  (,gmad-constants-regexp . font-lock-constant-face)
	  (,gmad-preprocessor-regexp . font-lock-preprocessor-face)
	  (,gmad-types-regexp . font-lock-type-face)
	  (,gmad-keywords-regexp . font-lock-keyword-face)
	  (,gmad-variables-regexp . (1 font-lock-variable-name-face))
	  )))

(define-derived-mode gmad-mode prog-mode "GMAD MODE"
  "Major mode for editing Graphical Methodical Accelerator Design
(GMAD). "
(setq font-lock-defaults '((gmad-fontlock-keywords)))
(setq comment-start "!")
(set-syntax-table gmad-mode-syntax-table))


(provide 'gmad-mode)
