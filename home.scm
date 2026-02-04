(add-to-load-path (dirname (current-filename)))
(use-modules (ice-9 match)
  (gnu)
  (gnu home)
  (gnu home services)
  (gnu home services dotfiles)
  (gnu home services shells)
  (gnu home services sway)
  (packages nvim)
  (gnu system keyboard)
  (gnu services)
  (gnu system shadow))

(use-package-modules wm ; grimshot
		     xdisorg ; wl-clipboard
		     rust-apps ; jujutsu
		     emacs ; self-explanatory
		     emacs-xyz ; evil
		     vim ; self-explanatory
		     librewolf ; self-explanatory
		     lua ; fennel
		     terminals ; foot
		     admin ; fastfetch
		     )

(define neovim-packages 
  (list neovim
	neovim-nfnl
	neovim-conjure
	vim-guile
	vim-paredit
	vim-guix-vim))

(define emacs-packages
  (list emacs-pgtk
	emacs-paredit
	emacs-geiser
	emacs-geiser-guile
	emacs-gruvbox-theme
	emacs-evil
	emacs-evil-collection
	emacs-evil-commentary
	emacs-evil-paredit))

(define sway-bar-status (file-append i3status-rust "/bin/i3status-rs"))

(define sway-config
  (sway-configuration
    (inherit %empty-sway-configuration)
    (bar (sway-bar
	   (identifier 'bar0)
	   (position 'top)
	   (status-command sway-bar-status)))
    ;;(startup+reload-programs TODO)
    ;;(extra-content TODO)
    (variables %sway-default-variables)
    (keybindings %sway-default-keybindings)
    (gestures %sway-default-gestures)
    (packages (append (list
		       grimshot
		       i3status-rust
		       wl-clipboard) %sway-default-packages))
    (modes %sway-default-modes)
    ;(startup-programs %sway-default-startup-programs)
    (inputs (list (sway-input (identifier "type:keyboard")
			      (layout (keyboard-layout "us" #:options '("ctrl:nocaps"))))))))

(define home-config
  (home-environment
    (packages (append neovim-packages
		      emacs-packages
		      (list jujutsu
			    fastfetch
			    ripgrep
			    fd
			    sd
			    librewolf
			    fennel
			    fennel-ls
			    foot)))
    (services
      (append
        (list
	  (simple-service 'editor-env-var
		   home-environment-variables-service-type
		   '(("EDITOR" . "nvim")))

          (service home-fish-service-type)

	  (service home-sway-service-type sway-config)

	  (service home-dotfiles-service-type
		    (home-dotfiles-configuration
		      (directories '("./dotfiles"))))

          (service home-files-service-type
           `((".guile" ,%default-dotguile)
             (".Xdefaults" ,%default-xdefaults)
	     ))

          (service home-xdg-configuration-files-service-type
           `(("gdb/gdbinit" ,%default-gdbinit)
             ("nano/nanorc" ,%default-nanorc))))

        %base-home-services))))

home-config
