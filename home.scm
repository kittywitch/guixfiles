(add-to-load-path (dirname (current-filename)))
(use-modules (ice-9 match)
  (gnu)
  (gnu home)
  (gnu home services)
  (gnu home services dotfiles)
  (gnu home services shells)
  (gnu home services sway)
  (gnu home services desktop)
  (gnu home services sound)
  (packages nvim)
  (packages fonts)
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
		     video ; mpv, yt-dlp
		     terminals ; foot
		     admin ; fastfetch
		     pulseaudio ; pavucontrol
		     fonts ; cozette
		     shellutils ; starship
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
	   (colors (sway-color (background "$dark")
			       (statusline "$light")
			       (focused-workspace
				(sway-border-color (border "$gray")
						   (background "$gray")
						   (text "$light")))
				(active-workspace
				(sway-border-color (border "$mid")
						   (background "$mid")
						   (text "$light")))
			       (inactive-workspace
				(sway-border-color (border "$inactive")
						   (background "$inactive")
						   (text "$light")))
			       (urgent-workspace
				(sway-border-color (border "$urgent")
						   (background "$urgent")
						   (text "$light")))))
	   (status-command sway-bar-status)))
    ;;(startup+reload-programs TODO)
    (extra-content (list
		    "client.focused $focused $focused $light $focused $focused"
		    "client.focused_inactive $inactive $inactive $light $inactive $inactive"
		    "client.unfocused $unfocused $unfocused $light $unfocused $unfocused"
		    "client.urgent $urgent $urgent $light $urgent $urgent"
		    "smart_gaps on"
		    "gaps inner 0"
		    "gaps outer -4"
		    "gaps top -2"
		    "gaps bottom 0"
		    "default_border pixel 0"
		    "default_floating_border pixel 2"
		    "font pango:Atkinson Hyperlegible Next 10"
		    ))
    (variables (append `((mod . "Mod4")
			 (light . "#ebdbb2")
			 (dark . "#3c3836")
			 (gray . "#928374")
			 (mid . "#665c54")
			(focused . "#3c3836")
			(inactive . "#282828")
			(unfocused . "#282828")
			(urgent . "#b8bb26")
			) %sway-default-variables))
    (keybindings %sway-default-keybindings)
    (gestures %sway-default-gestures)
    (outputs
           (list (sway-output
                  (identifier '*)
                  (background (local-file "files/homu-wallpaper.jpg")))))
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
			    yt-dlp
			    mpv
			    starship
			    font-awesome
			    font-atkinson-hyperlegible-next
			    font-atkinson-hyperlegible-mono
			    fastfetch
			    pavucontrol
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

          (service home-fish-service-type (home-fish-configuration (config (list (local-file "files/starship.fish")))))

	  (service home-sway-service-type sway-config)

	  (service home-dbus-service-type)
	  (service home-pipewire-service-type) 

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
