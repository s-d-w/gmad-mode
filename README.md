# gmad-mode

A major mode for the language used to define particle accelerators in [BDSIM](https://twiki.ph.rhul.ac.uk/twiki/bin/view/PP/JAI/BdSim): "GMAD".

## Getting Started

### Prerequisites

All versions of emacs greater than 23 are expected to support gmad-mode.

### Installing

Clone this repository:

``` sh
git clone git@github.com:st-walker/gmad-mode.git
```

Add the following to your `init.el` (usually found in either `~/` or `~/.emacs.d`)

``` elisp
(add-to-list 'load-path "/path/to/this/cloned/gmad-mode/")
(load "gmad-mode")
;; Automatically load gmad-mode when opening a file with the .gmad extension:
(add-to-list 'auto-mode-alist '("\\.gmad\\'" . gmad-mode)) 
```

Then, to get emacs to evalute your `init.el`, type the following from within the buffer:

```
M-x eval-buffer RET
```

Now next time you visit a gmad file, it will have font highlighting.  

## Authors

* **Stuart Walker** - [st-walker](https://github.com/st-walker)

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details
