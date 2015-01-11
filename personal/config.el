;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Display
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Color syntax
(global-font-lock-mode t)

;; Column/line numbering in status line
(setq-default column-number-mode t)
(setq-default line-number-mode t)

;; Highlight matches from searches
(setq-default isearch-highlight t)
(setq-default query-replace-highlight t)
(setq-default search-highlight t)

;; Highlight marked block
(setq-default transient-mark-mode t)

;; Highlight paren matching
(show-paren-mode t)

;; Do not fold lines
(set-default 'truncate-lines t)
(set-default 'case-fold-search t)

;; Always show trailing whitespace
(setq show-trailing-whitespace t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Behaviour
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(if (eq system-type 'darwin)
    (setq
     ns-pop-up-frames nil))

;; Replace highlighted text with typed text
(delete-selection-mode t)

;; Set the frame title
(setq-default frame-title-format '("" invocation-name " - " (:eval (if (buffer-file-name)
                                                               (abbreviate-file-name (buffer-file-name))
                                                             "%b"))))

;; Use spaces instead of tabs in general
(setq-default indent-tabs-mode nil)

;; Don't show the GNU splash screen
(setq-default inhibit-startup-message t)

;; Always end a file with a newline
(setq require-final-newline t)

;; Stop adding newlines to the end of files when moving down
(setq-default next-line-add-newlines nil)

;; Resize the mini-buffer  necessary
(setq-default resize-minibuffer-mode t)

;; Scroll just one line when point passes off the screen
(setq-default scroll-conservatively 7)

;; Stop that annoying beep
(setq visible-bell nil
      ring-bell-function (lambda ()
                           (invert-face 'mode-line)
                           (run-with-timer 0.1 nil 'invert-face 'mode-line)))

(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

;; Set meta and super keys on OSX
(if (eq system-type 'darwin)
    (setq
     mac-command-modifier 'meta
     mac-option-modifier 'super))

;; Disable suspend
(if window-system (progn (global-set-key (kbd "C-z") nil)
                         (global-set-key (kbd "C-x C-z") nil)))

;; Use the mouse wheel if available
(mouse-wheel-mode t)

(setq vc-follow-symlinks t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Buffers
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;Do not ask before killing a buffer that has a running process
(remove-hook 'kill-buffer-query-functions 'process-kill-buffer-query-function)

;;Do not ask for "confirm" when creating new buffer
(setq confirm-nonexistent-file-or-buffer nil)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Prelude
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq tab-width 4) ;; but maintain correct appearance

;; Set the line-wrapping width
(set-default 'fill-column 120)
(setq whitespace-line-column 120)

;; IDO All the things!
(setq ido-everywhere t)

;; Do not try to ping a potential host machine when executing find-file-at-point.
(setq ffap-machine-p-known 'reject)

;; Disable annoying smartparen keybindings
(setq sp-override-key-bindings '(("C-<left>" . nil)
                                 ("C-<right>" . nil)
                                 ("C-M-<left>" . nil)
                                 ("C-M-<right>" . nil)))
(sp--update-override-key-bindings)

;; Disable the kill-line binding
(global-set-key (kbd "C-<backspace>") 'backward-kill-word)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Load Packages
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(prelude-require-packages '(uuidgen
                            dockerfile-mode
                            neotree))

(require 'neotree)
(require 'conf-bindings)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Autocomplete
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(prelude-require-package 'auto-complete)
(require 'auto-complete-config)
(setq ac-comphist-file (expand-file-name "ac-comphist.dat" prelude-savefile-dir))
(setq ac-dwim t)
(ac-config-default)

(ac-set-trigger-key "TAB")
(setq ac-auto-start nil)

;; set also the completion for eshell
(add-hook 'eshell-mode-hook 'ac-eshell-mode-setup)

;; custom keybindings to use tab, enter and up and down arrows
(define-key ac-complete-mode-map "\t" 'ac-expand)
(define-key ac-complete-mode-map "\r" 'ac-complete)
(define-key ac-complete-mode-map "\M-n" 'ac-next)
(define-key ac-complete-mode-map "\M-p" 'ac-previous)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; YASnippet
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(prelude-require-packages '(yasnippet))
(require 'yasnippet)
(yas-initialize)

(add-to-list 'auto-mode-alist '("\\.yasnippet$" . snippet-mode))
(add-to-list 'auto-mode-alist '(".yas-setup$"   . emacs-lisp-mode))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Additional modes
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Use lines instead of ^L
(prelude-require-package 'form-feed)
(add-hook 'emacs-lisp-mode-hook 'form-feed-mode)
(add-hook 'compilation-mode-hook 'form-feed-mode)

;; Allow tabs in text-mode
(add-hook 'text-mode-hook '(lambda () (setq indent-tabs-mode t)))

;; Enable ansible support
(prelude-require-packages '(ansible ansible-doc))
(require 'ansible)
(add-hook 'yaml-mode-hook '(lambda () (ansible 1)))
(add-hook 'yaml-mode-hook 'ansible-doc-mode)
;;(add-hook 'yaml-mode-hook 'ansible-mode)

;; Jinja2 support
(prelude-require-package 'jinja2-mode)
(add-to-list 'auto-mode-alist '("\\.j2$" . jinja2-mode))

;; (autoload 'stratego-mode "stratego" nil t)
;; (add-to-list 'auto-mode-alist '("\\.cltx$"     . stratego-mode))
;; (add-to-list 'auto-mode-alist '("\\.cr$"       . stratego-mode))
;; (add-to-list 'auto-mode-alist '("\\.r$"        . stratego-mode))
;; (add-to-list 'auto-mode-alist '("\\.ss$"       . stratego-mode))
;; (add-to-list 'auto-mode-alist '("\\.str$"      . stratego-mode))
;; (add-to-list 'auto-mode-alist '("\\.sdf$"      . stratego-mode))

(add-to-list 'auto-mode-alist '("\\.spu.c$"    . c-mode))
(add-to-list 'auto-mode-alist '("\\.spuc$"     . c-mode))

;; Allow editing of binary .plist files.
(add-to-list 'jka-compr-compression-info-list
             ["\\.plist$"
              "converting text XML to binary plist"
              "plutil"
              ("-convert" "binary1" "-o" "-" "-")
              "converting binary plist to text XML"
              "plutil"
              ("-convert" "xml1" "-o" "-" "-")
              nil nil "bplist"])


(jka-compr-update)
