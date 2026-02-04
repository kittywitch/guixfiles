(evil-mode 1)

;; elisp paredit
(add-hook 'emacs-lisp-mode-hook 'enable-paredit-mode)
(add-hook 'emacs-lisp-mode-hook 'evil-paredit-mode)

;; scheme paredit
(add-hook 'scheme 'enable-paredit-mode)
(add-hook 'scheme 'evil-paredit-mode)

;; geiser
(add-hook 'geiser-mode-hook 'ac-geiser-setup)
(add-hook 'geiser-repl-mode-hook 'ac-geiser-setup)
(eval-after-load "auto-complete"
  '(add-to-list 'ac-modes 'geiser-repl-mode))
