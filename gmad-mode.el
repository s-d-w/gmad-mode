
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
	     (gmad-constants '("pi" "twopi" "halfpi"
			       "PeV" "TeV" "GeV" "MeV" "keV" "KeV" "eV"
			       "V" "kV" "MV"
			       "Tesla" "T"
			       "km" "m" "cm" "mm" "um" "mum" "nm" "ang" "pm"
			       "s" "ms" "us" "ns" "ps"
			       "Hz" "kHz" "MHz" "GHz"
			       "rad" "mrad" "urad"
			       "degrees"
			       "clight"))
	     ;; from parser.l
	     (gmad-preprocessor '("include"))
	     ;; from parser.l
	     (gmad-types '(;; beamline elements
			   "marker" "drift" "rf" "rfcavity" "sbend"
			   "rbend" "hkicker" "vkicker" "kicker"
			   "tkicker" "quadrupole" "sextupole"
			   "octupole" "decapole" "multipole" "thinmultipole"
			   "solenoid" "rcol" "ecol" "jcol" "muonspoiler"
			   "muspoiler" "shield" "element" "screen" "awakescreen"
			   "awakespectrometer" "transform3d" "laser"
			   "degrader" "gap" "thinrmatrix" "paralleltransporter"
			   "rmatrix" "crystalcol" "wirescanner"
			   "undulator" "usercomponent" "dump"

			   ;; other definitions
			   "cavitymodel" "cutsregion" "newcolour" "crystal"
			   "field" "placement" "query" "tunnel"
			   "samplerplacement" "scorer" "scorermesh"
			   "tunnel" "xsecbias" "xsecBias" "aperture" "blm"

			   "matdef" "atom"

			   "line"))
	     ;; from parser.l
	     (gmad-keywords '("all" "period" "range" "if" "for"
			      "else" "begin" "end" "beam" "option"
			      "beta0" "print" "return" "stop"
			      "use" "sample" "csample"))
	     (gmad-functions-regexp (regexp-opt gmad-functions
						'words))
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

(define-derived-mode gmad-mode prog-mode "gmad"
  "Major mode for editing GMAD files. "
(setq font-lock-defaults '((gmad-fontlock-keywords)))
(setq comment-start "!")
(set-syntax-table gmad-mode-syntax-table))


(provide 'gmad-mode)
