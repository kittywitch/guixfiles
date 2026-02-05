(evil-mode 1)

;; elisp paredit
(add-hook 'emacs-lisp-mode-hook 'enable-paredit-mode)
(add-hook 'emacs-lisp-mode-hook 'evil-paredit-mode)

;; scheme paredit
(add-hook 'scheme-mode-hook 'enable-paredit-mode)
(add-hook 'scheme-mode-hook 'evil-paredit-mode)

;; geiser
(add-hook 'geiser-mode-hook 'ac-geiser-setup)
(add-hook 'geiser-repl-mode-hook 'ac-geiser-setup)
(eval-after-load "auto-complete"
  '(add-to-list 'ac-modes 'geiser-repl-mode))

(load-theme 'gruvbox-dark-medium t)

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

(add-to-list 'default-frame-alist '(alpha-background . 90))
(set-frame-font "Atkinson Hyperlegible Next 10" nil t)
