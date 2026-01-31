(use-modules (ice-9 match)
  (gnu)
  (gnu home)
  (gnu home services)
  (gnu home services shells)
  (gnu home services sway)
  (gnu system keyboard)
  (gnu services)
  (gnu system shadow))

(use-package-modules wm ; grimshot
		     xdisorg ; wl-clipboard
		     rust-apps) ; jujutsu

(define sway-bar-status #~(string-append "while "
                 #$coreutils "/bin/date"
                 " +'%Y-%m-%d %X'; do sleep 1; done"))

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
			wl-clipboard) %sway-default-packages))
    (modes %sway-default-modes)
    ;(startup-programs %sway-default-startup-programs)
    (inputs (list (sway-input (identifier "type:keyboard")
			      (layout (keyboard-layout "us" #:options '("ctrl:nocaps"))))))))

(define home-config
  (home-environment
    (packages (list jujutsu))
    (services
      (append
        (list
          ;; Uncomment the shell you wish to use for your user:
          ;(service home-bash-service-type)
          ;(service home-fish-service-type)
          (service home-zsh-service-type)

	  (service home-sway-service-type sway-config)

          (service home-files-service-type
           `((".guile" ,%default-dotguile)
             (".Xdefaults" ,%default-xdefaults)
	     (".gitconfig", (local-file "files/gitconfig"))
	     ))

          (service home-xdg-configuration-files-service-type
           `(("gdb/gdbinit" ,%default-gdbinit)
             ("nano/nanorc" ,%default-nanorc))))

        %base-home-services))))

home-config
