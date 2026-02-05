(define-module (packages fonts)
	       #:use-module (guix build-system font))

(define-public font-atkinson-hyperlegible-next
  (package
    (name "font-atkinson-hyperlegible-next")
    (version "2.001-unstable-2025-02-21")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/googlefonts/atkinson-hyperlegible-next")
             (commit "7925f50f649b3813257faf2f4c0b381011f434f1")))
       (file-name (git-file-name name version))
       (sha256
        (base32 "0000000000000000000000000000000000000000000000000000"))))
    (build-system font-build-system)
    (home-page "https://www.brailleinstitute.org/freefont/")
    (synopsis "New (2024) second version of the Atkinson Hyperlegible fonts")
    (description
     "Read Easier With Our Family of Hyperlegible® Fonts")
    (license license:ofl)))
