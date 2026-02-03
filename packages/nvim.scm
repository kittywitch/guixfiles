(define-module (packages nvim)
	       #:use-module ((guix licenses) #:prefix license:)
	       #:use-module (guix packages)
	       #:use-module (guix gexp)
	       #:use-module (guix utils)
	       #:use-module (guix download)
	       #:use-module (guix build-system vim)
	       #:use-module (guix git-download))

(define-public neovim-nfnl
	       (package
		 (name "neovim-nfnl")
		 (version "1.3.0")
		 (source (origin
			   (method git-fetch)
			   (uri (git-reference
				  (url "https://github.com/Olical/nfnl")
				  (commit (string-append "v" version))))
				(file-name (git-file-name name version))
				(sha256 (base32 "1c1gai38cmdiv6yvl55prw0x34h0zq7mys8icx9xy2rpa80sy3ds"))))
		 (build-system vim-build-system)
		 (arguments (list
			      #:plugin-name "nfnl"))
		 (synopsis "Enhance your Neovim with Fennel")
		 (description "Enhance your Neovim experience through Fennel with zero overhead. Write Fennel, run Lua, nfnl will not load unless you're actively modifying your Neovim configuration or plugin source code.")
		 (home-page "https://github.com/Olical/nfnl/")
		 (license license:unlicense)))

(define-public neovim-conjure
	       (package
		 (name "neovim-conjure")
		 (version "4.58.0")
		 (source (origin
			   (method git-fetch)
			   (uri (git-reference
				  (url "https://github.com/Olical/conjure")
				  (commit (string-append "v" version))))
				(file-name (git-file-name name version))
				(sha256 (base32 "0d69d5lq0a5n54wmbs8rkd4kjwarjcs22qy71jdg1bn5jl8lwhna"))))
		 (build-system vim-build-system)
		 (arguments (list
			      #:plugin-name "conjure"))
		 (synopsis "Interactive evaluation for Neovim (Clojure, Fennel, Scheme, Python, JavaScript, PHP, R, Lua, Rust and more!)")
		 (description "Conjure is an interactive environment for evaluating code within your running program.")
		 (home-page "https://github.com/Olical/conjure/")
		 (license license:unlicense)))
