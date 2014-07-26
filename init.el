;; emacs kicker --- kick start emacs setup
;; Copyright (C) 2010 Dimitri Fontaine
;;
;; Author: Dimitri Fontaine <dim@tapoueh.org>
;; URL: https://github.com/dimitri/emacs-kicker
;; Created: 2011-04-15
;; Keywords: emacs setup el-get kick-start starter-kit
;; Licence: WTFPL, grab your copy here: http://sam.zoy.org/wtfpl/
;;
;; This file is NOT part of GNU Emacs.

(require 'cl)       ; common lisp goodies, loop

(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

(unless (require 'el-get nil t)
  (url-retrieve
   "https://github.com/dimitri/el-get/blob/62f217785fcdf36b304ae84d3951ac0d2e53998e/el-get-install.el"
   (lambda (s)
     (goto-char (point-max))
     (eval-print-last-sexp))))

;; now either el-get is `require'd already, or have been `load'ed by the
;; el-get installer.

;; set local recipes
(setq
 el-get-sources
 '(
   (:name        ac-nrepl
                 :description "Nrepl completion source for Emacs auto-complete package"
                 :type        github
                 :pkgname     "clojure-emacs/ac-nrepl"
                 :depends     (auto-complete cider)
                 :features    ac-nrepl)
   (:name auto-complete
          :website "https://github.com/auto-complete/auto-complete"
          :description "The most intelligent auto-completion extension."
          :type github
          :pkgname "auto-complete/auto-complete"
          :depends (popup fuzzy)
          :features auto-complete-config
          :post-init (progn
                       (add-to-list 'ac-dictionary-directories
                                    (expand-file-name "dict" default-directory))
                       (ac-config-default)))
   (:name auto-complete-yasnippet
          :description "Auto-complete sources for YASnippet"
          :type http
          :url "http://www.cx4a.org/pub/auto-complete-yasnippet.el"
          :depends (auto-complete yasnippet))
   (:name auto-complete-emacs-lisp
          :description "Auto-complete sources for emacs lisp"
          :type http
          :url "http://www.cx4a.org/pub/auto-complete-emacs-lisp.el"
          :depends auto-complete)
   (:name cider
          :description "CIDER is a Clojure IDE and REPL."
          :type github
          :pkgname "clojure-emacs/cider"
          :checkout "v0.5.0"
          :depends (dash clojure-mode pkg-info))
   (:name cl-lib
          :builtin "24.3"
          :type elpa
          :description "Properly prefixed CL functions and macros"
          :url "http://elpa.gnu.org/packages/cl-lib.html")

   (:name clj-refactor
          :description "A collection of simple clojure refactoring functions"
          :type github
          :depends (dash s clojure-mode yasnippet paredit multiple-cursors)
          :pkgname "magnars/clj-refactor.el")
   (:name clojure-mode
          :website "https://github.com/clojure-emacs/clojure-mode"
          :description "Emacs support for the Clojure language."
          :type github
          :pkgname "clojure-emacs/clojure-mode")
   (:name color-theme
          :description "An Emacs-Lisp package with more than 50 color themes for your use. For questions about color-theme"
          :website "http://www.nongnu.org/color-theme/"
          :type http-tar
          :options ("xzf")
          :url "http://download.savannah.gnu.org/releases/color-theme/color-theme-6.6.0.tar.gz"
          :load "color-theme.el"
          :features "color-theme"
          :post-init (progn
                       (color-theme-initialize)
                       (setq color-theme-is-global t)))

   (:name color-theme-solarized
          :description "Emacs highlighting using Ethan Schoonover's Solarized color scheme"
          :type github
          :pkgname "sellout/emacs-color-theme-solarized"
          :depends color-theme
          :prepare (progn
                     (add-to-list 'custom-theme-load-path default-directory)
                     (autoload 'color-theme-solarized-light "color-theme-solarized"
                       "color-theme: solarized-light" t)
                     (autoload 'color-theme-solarized-dark "color-theme-solarized"
                       "color-theme: solarized-dark" t)))
   (:name color-theme-tomorrow
          :description "Emacs highlighting using Chris Charles's Tomorrow color scheme"
          :type github
          :pkgname "ccharles/Tomorrow-Theme"
          :depends color-theme
          :prepare (progn
                     (autoload 'color-theme-tomorrow "GNU Emacs/color-theme-tomorrow"
                       "color-theme: tomorrow" t)
                     (autoload 'color-theme-tomorrow-night "GNU Emacs/color-theme-tomorrow"
                       "color-theme: tomorrow-night" t)
                     (autoload 'color-theme-tomorrow-night-eighties "GNU Emacs/color-theme-tomorrow"
                       "color-theme: tomorrow-night-eighties" t)
                     (autoload 'color-theme-tomorrow-night-blue "GNU Emacs/color-theme-tomorrow"
                       "color-theme: tomorrow-night-blue" t)
                     (autoload 'color-theme-tomorrow-night-bright "GNU Emacs/color-theme-tomorrow"
                       "color-theme: tomorrow-night-bright" t)))

   (:name dash
          :description "A modern list api for Emacs. No 'cl required."
          :type github
          :pkgname "magnars/dash.el")
   (:name el-get
          :website "https://github.com/dimitri/el-get#readme"
          :description "Manage the external elisp bits and pieces you depend upon."
          :type github
          :branch  "master"
          :pkgname "dimitri/el-get"
          :info    "."
          :compile ("el-get.*\\.el$" "methods/")
          :load    "el-get.el")
   (:name erc
          :description "An Emacs Internet Relay Chat client."
          :type git
          :url "git://git.savannah.gnu.org/erc.git"
          :build ("make")
          :info "."
          :post-init (progn
                       (setq erc-nicklist-icons-directory
                             (expand-file-name "images" default-directory))))
   (:name exec-path-from-shell
          :website "https://github.com/purcell/exec-path-from-shell"
          :description "Emacs plugin for dynamic PATH loading"
          :type github
          :pkgname "purcell/exec-path-from-shell")
   (:name expand-region
          :type github
          :pkgname "magnars/expand-region.el"
          :description "Expand region increases the selected region by semantic units. Just keep pressing the key until it selects what you want."
          :website "https://github.com/magnars/expand-region.el#readme")
   (:name fuzzy
          :website "https://github.com/auto-complete/fuzzy-el"
          :description "Fuzzy matching utilities for GNU Emacs"
          :type github
          :pkgname "auto-complete/fuzzy-el")
   (:name git-gutter
          :description "Emacs port of GitGutter Sublime Text 2 Plugin"
          :website "https://github.com/syohex/emacs-git-gutter"
          :type github
          :pkgname "syohex/emacs-git-gutter")
   (:name git-modes
          :description "GNU Emacs modes for various Git-related files"
          :type github
          :pkgname "magit/git-modes")
   (:name highlight-parentheses
          :description "Highlight the matching parentheses surrounding point."
          :type github
          :pkgname "nschum/highlight-parentheses.el")
   (:name ido-vertical-mode
          :type github
          :pkgname "rson/ido-vertical-mode.el"
          :description "makes ido-mode display vertically"
          :features ido-vertical-mode)
   (:name ido-ubiquitous
          :description "Use ido (nearly) everywhere"
          :type elpa)
   (:name magit
          :website "https://github.com/magit/magit#readme"
          :description "It's Magit! An Emacs mode for Git."
          :type github
          :pkgname "magit/magit"
          :depends (cl-lib git-modes)
          :info "."
          ;; let el-get care about autoloads so that it works with all OSes
          :build (if (version<= "24.3" emacs-version)
                     `(("make" ,(format "EMACS=%s" el-get-emacs) "all"))
                   `(("make" ,(format "EMACS=%s" el-get-emacs) "docs")))
          :build/berkeley-unix (("touch" "`find . -name Makefile`") ("gmake")))
   (:name multiple-cursors
          :description "An experiment in adding multiple cursors to emacs"
          :type github
          :pkgname "magnars/multiple-cursors.el")
   (:name paredit
          :description "Minor mode for editing parentheses"
          :type http
          :prepare (progn (autoload 'enable-paredit-mode "paredit")
                          (autoload 'disable-paredit-mode "paredit"))
          :url "http://mumble.net/~campbell/emacs/paredit.el")
   (:name pkg-info
          :description "Provide information about Emacs packages."
          :type github
          :pkgname "lunaryorn/pkg-info.el"
          :depends (dash epl))
   (:name popup
          :website "https://github.com/auto-complete/popup-el"
          :description "Visual Popup Interface Library for Emacs"
          :type github
          :submodule nil
          :pkgname "auto-complete/popup-el")
   (:name projectile
          :description "Project navigation and management library for Emacs."
          :type github
          :pkgname "bbatsov/projectile"
          :depends (dash s pkg-info))
   (:name s
          :description "The long lost Emacs string manipulation library."
          :type github
          :pkgname "magnars/s.el")
   (:name smex
          :description "M-x interface with Ido-style fuzzy matching."
          :type github
          :pkgname "nonsequitur/smex"
          :features smex
          :post-init (smex-initialize))
   (:name undo-tree
          :description "Treat undo history as a tree"
          :website "http://www.dr-qubit.org/emacs.php"
          :type git
          :url "http://www.dr-qubit.org/git/undo-tree.git/")
   (:name wgrep
          :description "Writable grep buffer and apply the changes to files"
          :type github
          :pkgname "mhayashi1120/Emacs-wgrep")
   (:name yasnippet
          :website "https://github.com/capitaomorte/yasnippet.git"
          :description "YASnippet is a template system for Emacs."
          :type github
          :pkgname "capitaomorte/yasnippet"
          :compile "yasnippet.el"

          ;; only fetch the `snippets' submodule, others have funny
          ;; file names that can cause problems
          ;; see https://github.com/dimitri/el-get/issues/1511
          :submodule nil
          :build (("git" "submodule" "update" "--init" "--" "snippets")))

   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
   ;; (:name goto-last-change ; move pointer back to last change           ;;
   ;;        :after (progn                                                 ;;
   ;;                 ;; when using AZERTY keyboard, consider C-x C-_      ;;
   ;;                 (global-set-key (kbd "C-x C-l") 'goto-last-change))) ;;
   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

   ))

;; now set our own packages
(setq
 my:el-get-packages
 '(el-get              ; el-get is self-hosting
   escreen             ; screen for emacs, C-\ C-h
   php-mode-improved   ; if you're into php...
   switch-window       ; takes over C-x o
   auto-complete       ; complete as you type with overlays
   yasnippet           ; powerful snippet mode
   zencoding-mode      ; http://www.emacswiki.org/emacs/ZenCoding
   color-theme         ; nice looking emacs
   color-theme-tango)) ; check out color-theme-solarized

;;
;; Some recipes require extra tools to be installed
;;
;; Note: el-get-install requires git, so we know we have at least that.
;;
(when (ignore-errors (el-get-executable-find "cvs"))
  (add-to-list 'my:el-get-packages 'emacs-goodies-el)) ; the debian addons for emacs

(when (ignore-errors (el-get-executable-find "svn"))
  (loop for p in '(psvn       ; M-x svn-status
                   )
        do (add-to-list 'my:el-get-packages p)))

(setq my:el-get-packages
      (append
       my:el-get-packages
       (loop for src in el-get-sources collect (el-get-source-name src))))

;; install new packages and init already installed packages
(el-get 'sync my:el-get-packages)

;; on to the visual settings
(setq inhibit-splash-screen t)    ; no splash screen, thanks
(line-number-mode 1)      ; have line numbers and
(column-number-mode 1)      ; column numbers in the mode line

(tool-bar-mode -1)      ; no tool bar with icons
(scroll-bar-mode -1)      ; no scroll bars
(unless (string-match "apple-darwin" system-configuration)
  ;; on mac, there's always a menu bar drown, don't have it empty
  (menu-bar-mode -1))

;; choose your own fonts, in a system dependant way
(if (string-match "apple-darwin" system-configuration)
    (set-face-font 'default "Monaco-13")
  (set-face-font 'default "Monospace-10"))

(global-hl-line-mode)     ; highlight current line
(global-linum-mode 1)     ; add line numbers on the left

;; avoid compiz manager rendering bugs
(add-to-list 'default-frame-alist '(alpha . 100))

;; copy/paste with C-c and C-v and C-x, check out C-RET too
(cua-mode)

;; under mac, have Command as Meta and keep Option for localized input
(when (string-match "apple-darwin" system-configuration)
  (setq mac-allow-anti-aliasing t)
  (setq mac-command-modifier 'meta)
  (setq mac-option-modifier 'none))

;; Use the clipboard, pretty please, so that copy/paste "works"
(setq x-select-enable-clipboard t)

;; Navigate windows with M-<arrows>
(windmove-default-keybindings 'meta)
(setq windmove-wrap-around t)

                                        ; winner-mode provides C-<left> to get back to previous window layout
(winner-mode 1)

;; whenever an external process changes a file underneath emacs, and there
;; was no unsaved changes in the corresponding buffer, just revert its
;; content to reflect what's on-disk.
(global-auto-revert-mode 1)

;; M-x shell is a nice shell interface to use, let's make it colorful.  If
;; you need a terminal emulator rather than just a shell, consider M-x term
;; instead.
(autoload 'ansi-color-for-comint-mode-on "ansi-color" nil t)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

;; If you do use M-x term, you will notice there's line mode that acts like
;; emacs buffers, and there's the default char mode that will send your
;; input char-by-char, so that curses application see each of your key
;; strokes.
;;
;; The default way to toggle between them is C-c C-j and C-c C-k, let's
;; better use just one key to do the same.
(require 'term)
(define-key term-raw-map  (kbd "C-'") 'term-line-mode)
(define-key term-mode-map (kbd "C-'") 'term-char-mode)

;; Have C-y act as usual in term-mode, to avoid C-' C-y C-'
;; Well the real default would be C-c C-j C-y C-c C-k.
(define-key term-raw-map  (kbd "C-y") 'term-paste)

;; use ido for minibuffer completion
(require 'ido)
(ido-mode t)
(setq ido-save-directory-list-file "~/.emacs.d/.ido.last")
(setq ido-enable-flex-matching t)
(setq ido-use-filename-at-point 'guess)
(setq ido-show-dot-for-dired t)
(setq ido-default-buffer-method 'selected-window)

;; default key to switch buffer is C-x b, but that's not easy enough
;;
;; when you do that, to kill emacs either close its frame from the window
;; manager or do M-x kill-emacs.  Don't need a nice shortcut for a once a
;; week (or day) action.
(global-set-key (kbd "C-x C-b") 'ido-switch-buffer)
(global-set-key (kbd "C-x C-c") 'ido-switch-buffer)
(global-set-key (kbd "C-x B") 'ibuffer)

;; have vertical ido completion lists
(setq ido-decorations
      '("\n-> " "" "\n   " "\n   ..." "[" "]"
        " [No match]" " [Matched]" " [Not readable]" " [Too big]" " [Confirm]"))

;; C-x C-j opens dired with the cursor right on the file you're editing
(require 'dired-x)

;; full screen
(defun fullscreen ()
  (interactive)
  (set-frame-parameter nil 'fullscreen
                       (if (frame-parameter nil 'fullscreen) nil 'fullboth)))
(global-set-key [f11] 'fullscreen)
