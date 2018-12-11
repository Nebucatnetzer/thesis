;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)
(setq vc-follow-symlinks t);; always follow symlinks

;; keep customize settings in their own file
(setq custom-file "~/.emacs.d/custom.el")
(when (file-exists-p custom-file)
    (load custom-file))

(require 'org)

(add-to-list 'package-archives
    '("melpa" . "https://melpa.org/packages/"))
(when (< emacs-major-version 24)
    ;; For important compatibility libraries like cl-lib
    (add-to-list 'package-archives
        '("gnu" . "https://elpa.gnu.org/packages/")))

(unless (package-installed-p 'use-package)
        (package-refresh-contents)
        (package-install 'use-package))

(require 'use-package)
(use-package use-package-ensure-system-package
    :ensure t)

(use-package org-ref
    :ensure t
    :after org
    :init
    (setq org-ref-completion-library 'org-ref-ivy-cite)
    :config
    (setq org-ref-default-citation-link "footcite"))
