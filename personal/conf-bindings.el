(eval-when-compile (require 'cl))

(defvar k-minor-mode-map (make-keymap) "k-minor-mode keymap.")

;; Make the `Delete' key delete the char under the cursor
(define-key k-minor-mode-map [delete]        'delete-char)
(define-key k-minor-mode-map [kp-delete]     'delete-char)
(define-key k-minor-mode-map [insert]        'yank)
(define-key k-minor-mode-map [C-delete]      'undo)

;; Makes home/end go to beginning/end of line
(define-key k-minor-mode-map [end] 'end-of-line)
(define-key k-minor-mode-map [home] 'beginning-of-line)

;; Makes control + home/end go to beginning/end of buffer
(define-key k-minor-mode-map [C-end] 'end-of-buffer)
(define-key k-minor-mode-map [C-home] 'beginning-of-buffer)

;; Pager stuff
(define-key k-minor-mode-map [M-up]          'pager-row-up)
(define-key k-minor-mode-map [M-down]        'pager-row-down)
(define-key k-minor-mode-map [prior]         'pager-page-up)
(define-key k-minor-mode-map [next]          'pager-page-down)
(define-key k-minor-mode-map [M-kp-8]        'pager-row-up)
(define-key k-minor-mode-map [M-kp-2]        'pager-row-down)
(define-key k-minor-mode-map (kbd "M-v")     'pager-page-up)
(define-key k-minor-mode-map (kbd "C-v")     'pager-page-down)

(define-key k-minor-mode-map [f1]            'man-follow)
(define-key k-minor-mode-map [f2]            'eshell)
(define-key k-minor-mode-map [C-f2]          'visit-ansi-term)
(define-key k-minor-mode-map [M-f2]          'python-shell)
(define-key k-minor-mode-map [f3]            'speedbar)
(define-key k-minor-mode-map [f4]            'neotree-toggle)
(define-key k-minor-mode-map [f5]            'toggle-truncate-lines)
(define-key k-minor-mode-map [f6]            'prelude-cleanup-buffer-or-region)
(define-key k-minor-mode-map [f7]            'indent-page)
(define-key k-minor-mode-map [f8]            'magit-status)

;; ;; cycle through buffers
;; (define-key k-minor-mode-map [C-tab]         'bs-cycle-next)
;; (define-key k-minor-mode-map [C-S-tab]       'bs-cycle-previous)

;; window stuff
(define-key k-minor-mode-map [C-kp-enter]    'other-window)
(define-key k-minor-mode-map [C-kp-add]      'enlarge-window)
(define-key k-minor-mode-map [C-kp-subtract] 'shrink-window)

(define-key k-minor-mode-map (kbd "C-x C-S-e")  'prelude-eval-and-replace)

(define-key k-minor-mode-map (kbd "C-x f")  'make-frame)
(define-key k-minor-mode-map (kbd "C-x M-f")  'delete-frame)

(define-key k-minor-mode-map (kbd "C-x j")  'jump-to-register)

;; (define-key k-minor-mode-map (kbd "C-x p")  'align-regexp)

(define-key k-minor-mode-map (kbd "C-c c")  'compile)
(define-key k-minor-mode-map (kbd "C-c g")  'goto-line)
(define-key k-minor-mode-map (kbd "C-c q")  'comment-or-uncomment-region)
(define-key k-minor-mode-map (kbd "C-c /")  'comment-or-uncomment-region)

(defun debug-key (map dbg) (define-key map (kbd "C-c d")  dbg))
(add-hook 'c-mode-hook (lambda () (debug-key c-mode-map 'gdb)))
(add-hook 'c++-mode-hook (lambda () (debug-key c++-mode-map 'gdb)))
(add-hook 'objc-mode-hook (lambda () (debug-key objc-mode-map 'gdb)))
(add-hook 'java-mode-hook (lambda () (debug-key java-mode-map 'jdb)))
(add-hook 'python-mode-hook (lambda () (debug-key py-mode-map 'pdb)))
(add-hook 'perl-mode-hook (lambda () (debug-key perl-mode-map 'perldb)))
(add-hook 'ruby-mode-hook (lambda () (debug-key ruby-mode-map 'rubydb)))

(define-key k-minor-mode-map (kbd "C-x t")  'toggle-truncate-lines)
(define-key k-minor-mode-map (kbd "C-x r")  'toggle-read-only)
(define-key k-minor-mode-map (kbd "C-x n")  'whitespace-cleanup)

(define-key k-minor-mode-map (kbd "C-c l")  'org-store-link)
(define-key k-minor-mode-map (kbd "C-c a")  'org-agenda)
(define-key k-minor-mode-map (kbd "C-c b")  'org-iswitchb)

;; Mouse button 1 drags the scroll bar
(define-key k-minor-mode-map [vertical-scroll-bar down-mouse-1] 'scroll-bar-drag)

(define-minor-mode k-minor-mode
  "A minor mode so that my key settings override annoying major modes."
  t
  " K"
  'k-minor-mode-map)

(k-minor-mode t)

(provide 'conf-bindings)
