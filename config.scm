;; This is an operating system configuration generated
;; by the graphical installer.
;;
;; Once installation is complete, you can learn and modify
;; this file to tweak the system configuration, and pass it
;; to the 'guix system reconfigure' command to effect your
;; changes.


;; Indicate which modules to import to access the variables
;; used in this configuration.
(add-to-load-path (dirname (current-filename)))
(define-module (config)
	       #:use-module (gnu)
	       #:use-module (channels)
	       #:use-module (gnu packages package-management)
	       #:use-module (gnu services cups)
	       #:use-module (gnu services desktop)
	       #:use-module (gnu services networking)
	       #:use-module (gnu services ssh)
	       #:use-module (gnu services xorg))

(operating-system
  (locale "en_CA.utf8")
  (timezone "America/Vancouver")
  (keyboard-layout (keyboard-layout "gb"))
  (host-name "elly")

  ;; The list of user accounts ('root' is implicit).
  (users (cons* (user-account
                  (name "kat")
                  (comment "Kat Inskip")
                  (group "users")
                  (home-directory "/home/kat")
                  (supplementary-groups '("wheel" "netdev" "audio" "video")))
                %base-user-accounts))

  ;; Packages installed system-wide.  Users can also install packages
  ;; under their own account: use 'guix search KEYWORD' to search
  ;; for packages and 'guix install PACKAGE' to install a package.
  (packages (append (list (specification->package "sway")
                          (specification->package "wmenu")
                          (specification->package "librewolf")
                          (specification->package "neovim")
                          (specification->package "foot")) %base-packages))

  ;; Below is the list of system services.  To search for available
  ;; services, run 'guix system search KEYWORD' in a terminal.
  (services (append (list
	    (service openssh-service-type)
	    (set-xorg-configuration
	      (xorg-configuration (keyboard-layout keyboard-layout)))
	    )
	  (modify-services %desktop-services
			   (guix-service-type
			     config => (guix-configuration
					 (inherit config)
					 (channels %kittywitch-channels)
					 (guix (guix-for-channels %kittywitch-channels)))))
	  ))
  (bootloader (bootloader-configuration
                (bootloader grub-efi-bootloader)
                (targets (list "/boot/efi"))
                (keyboard-layout keyboard-layout)))
  (mapped-devices (list (mapped-device
                          (source (uuid
                                   "796be682-a656-4cb1-8b4a-fd2b9db5202e"))
                          (target "cryptroot")
                          (type luks-device-mapping))))

  ;; The list of file systems that get "mounted".  The unique
  ;; file system identifiers there ("UUIDs") can be obtained
  ;; by running 'blkid' in a terminal.
  (file-systems (cons* (file-system
                         (mount-point "/boot/efi")
                         (device (uuid "8DC2-0DAE"
                                       'fat32))
                         (type "vfat"))
                       (file-system
                         (mount-point "/")
                         (device "/dev/mapper/cryptroot")
                         (type "ext4")
                         (dependencies mapped-devices)) %base-file-systems)))
