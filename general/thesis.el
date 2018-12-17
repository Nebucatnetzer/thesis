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

(add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/") t)

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

(use-package org
    :ensure t
    :pin org
    :config

;; enable org-mode keys
    (define-key global-map "\C-ca" 'org-agenda)
    (global-set-key "\C-cl" 'org-store-link)
    (global-set-key "\C-cc" 'org-capture)
    (global-set-key "\C-cb" 'org-iswitchb)

;; disable line split with M-RET
(setq org-M-RET-may-split-line (quote ((default))))

;; enable the correct intdentation for source code blocks
(setq org-edit-src-content-indentation 0)
(setq org-src-tab-acts-natively t)
(setq org-src-preserve-indentation t)

;; enable ido for org-mode
;(setq org-completion-use-ido t)

;; archive files to a monthly file
(setq org-archive-location
    (concat "~/git_repos/notes/personal/notes/archive/"
        (format-time-string "%Y-%m" (current-time)) "-%s::datetree/"))
;; enable todo and checkbox depencies
(setq org-enforce-todo-dependencies t)
(setq org-enforce-todo-checkbox-dependencies t)

;; quick access for todo states
(setq org-todo-keywords
    '((sequence "TODO(t)" "NEXT(n)" "WAITING(w!)" "PROJECT(p)" "|" "DONE(d)")
        (sequence "|" "CANCELLED(c)")))

(setq org-log-done 'time)

(setq org-log-into-drawer t)

;; enable org-indent
(setq org-startup-indented t)

;; input templates
(eval-after-load 'org
    '(progn
        (add-to-list 'org-structure-template-alist
            '("p" "#+attr_latex: :center\n[[]]" "<src lang=\"?\">\n\n</src>"))))

;; capture templates
    (setq org-capture-templates
        (quote
            (("j" "Journal" entry (file+datetree "~/git_repos/notes/personal/notes/journal.org")
                "* %U\n\n%?" :empty-lines 1)
            ("p" "Small Project" entry
                (file+headline "~/git_repos/notes/personal/agenda/personal.org" "Capture")
                (file "~/git_repos/notes/settings/templates/temp_personal_small_project.txt"))
            ("t" "Adds a Next entry" entry
                (file+headline "~/git_repos/notes/personal/agenda/personal.org" "Capture")
                (file "~/git_repos/notes/settings/templates/temp_personal_todo.txt")
                    :empty-lines 1))))

;; available effort times
(setq org-global-properties
    (quote
        (("Effort_ALL" . "0 0:10 0:30 1:00 2:00 3:00 4:00 5:00 6:00 7:00"))))

;; org-refile options
(setq org-refile-allow-creating-parent-nodes (quote confirm))
(setq org-refile-targets (quote ((org-agenda-files :maxlevel . 6))))
(setq org-refile-use-outline-path 'file
    org-outline-path-complete-in-steps nil)

;; set to line seperator to 1
(setq org-cycle-separator-lines 1)

(setq org-src-fontify-natively t)

(setq org-highlight-latex-and-related '(latex))

(setq org-image-actual-width (quote (500)))
(setq org-startup-with-inline-images t)

(setq org-id-link-to-org-use-id 'create-if-interactive-and-no-custom-id
    org-clone-delete-id t)

(setq org-blank-before-new-entry
    (quote ((heading . t)
        (plain-list-item . auto))))

(setq org-footnote-section "Resources")

(setq org-attach-directory "~/nextcloud/03_documents/attachements/")

(setq org-todo-keyword-faces
      `(("WAITING"   :foreground "#0087ff" :weight bold)
        ("TODO" :foreground "#d75f00" :weight bold)
        ("PROJECT"      :foreground "#626262" :weight bold)
        ("NEXT"      :foreground "#d70000" :weight bold)))


(set-face-attribute 'org-agenda-structure nil :inherit 'default :height 1.00)
(set-face-attribute 'org-agenda-date-weekend nil :height 1.00 :weight 'medium)
(set-face-attribute 'org-agenda-calendar-event nil :weight 'medium)
(set-face-attribute 'org-agenda-date nil :inherit 'default :height 1.00 :weight 'bold)
(set-face-attribute 'org-agenda-date-today nil :slant 'normal :weight 'bold :height 1.00)
(set-face-attribute 'org-done nil :foreground "#5f8700" :weight 'bold)
(set-face-attribute 'org-link nil :foreground "#0087ff" :underline t)
(set-face-attribute 'org-scheduled nil :foreground "#5f8700" :slant 'italic :weight 'normal)
(set-face-attribute 'org-scheduled-previously nil :foreground "#d70000" :weight 'normal)
(set-face-attribute 'org-scheduled-today nil :foreground "#5f8700" :slant 'italic :weight 'normal)
(set-face-attribute 'org-todo nil :background "nil" :foreground "#d70000" :weight 'bold)
(set-face-attribute 'org-upcoming-deadline nil :foreground "#d70000" :weight 'normal)
(set-face-attribute 'org-warning nil :foreground "#d70000" :weight 'normal)

;; org-export formats
;;(setq org-export-backends (quote (beamer html latex md odt reveal)))

(setq org-html-html5-fancy t
    org-html-doctype "html5")

;; disable the Todo keywords in the export
(setq org-export-with-todo-keywords nil)

;; disable the tags in the export
(setq org-export-with-tags nil)

(setq org-latex-caption-above nil)

(setq org-export-with-sub-superscripts nil)

(setq org-export-with-smart-quotes t)

(setq org-export-headline-levels 5)

;; options for beamer exports
(setq org-beamer-frame-level 2)
(setq org-beamer-outline-frame-options "")
(setq org-beamer-outline-frame-title "Inhalt")
(setq org-beamer-theme "metropolis")

;; options for latex exports
(setq org-latex-classes
    (quote
        (("beamer" "\\documentclass{az_beamer}"
            ("\\section{%s}" . "\\section*{%s}")
            ("\\subsection{%s}" . "\\subsection*{%s}")
            ("\\subsubsection{%s}" . "\\subsubsection*{%s}"))
         ("article" "\\documentclass{article}"
            ("\\section{%s}" . "\\section*{%s}")
            ("\\subsection{%s}" . "\\subsection*{%s}")
            ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
            ("\\paragraph{%s}" . "\\paragraph*{%s}")
            ("\\subparagraph{%s}" . "\\subparagraph*{%s}"))
         ("report" "\\documentclass[11pt]{report}"
            ("\\part{%s}" . "\\part*{%s}")
            ("\\chapter{%s}" . "\\chapter*{%s}")
            ("\\section{%s}" . "\\section*{%s}")
            ("\\subsection{%s}" . "\\subsection*{%s}")
            ("\\subsubsection{%s}" . "\\subsubsection*{%s}"))
         ("book" "\\documentclass[11pt]{book}"
            ("\\part{%s}" . "\\part*{%s}")
            ("\\chapter{%s}" . "\\chapter*{%s}")
            ("\\section{%s}" . "\\section*{%s}")
            ("\\subsection{%s}" . "\\subsection*{%s}")
            ("\\subsubsection{%s}" . "\\subsubsection*{%s}")))))
    (setq org-latex-default-packages-alist nil)
    (setq org-latex-listings 'listings)
    (setq org-latex-title-command "\\maketitle\\newpage")
    (setq org-latex-toc-command "\\tableofcontents
    \\newpage
    ")

;; Set the agenda separator to a space character.
(setq org-agenda-block-separator " ")

;; a function to call the custom agenda view.
(defun az/custom-agenda (&optional arg)
    (interactive "P")
    (org-agenda arg "A"))

(global-set-key [f9] 'az/custom-agenda)

;; hide done tasks in the agenda
(setq org-agenda-skip-deadline-if-done t)
(setq org-agenda-skip-scheduled-if-done t)
(setq org-agenda-skip-timestamp-if-done t)

;; Custom agenda command to list the stuck projects in the normal
;; agenda view.
(setq org-stuck-projects '("/PROJECT" ("NEXT") nil ""))
(setq org-agenda-custom-commands
    (quote (("A" "Custom Agenda"
        ((agenda "" nil)
        (stuck ""
            ((org-agenda-overriding-header "Stuck Projects")
                (org-agenda-sorting-strategy
                    '(category-up))))
        (tags-todo "TODO=\"PROJECT\" "
            ((org-agenda-overriding-header "Projects")
                (org-agenda-sorting-strategy
                    '(category-up))))
                nil))
            ;; Show all headings with the corresponding TODO state
        ("N" occur-tree "NEXT")
        ("O" occur-tree "TODO")
        ("W" occur-tree "WAITING"))))

;; don't show the warnings for deadlines if the item is scheduled
(setq org-agenda-skip-deadline-prewarning-if-scheduled t)

;; start the agenda on the current day and show the next 13 days
(setq org-agenda-span 14
    org-agenda-start-on-weekday nil)
(setq org-agenda-tags-column -80)
(setq org-agenda-show-future-repeats (quote next))
(setq org-agenda-sorting-strategy
    (quote
        ((agenda todo-state-up priority-down category-up))))

;; dimm open tasks
(setq org-agenda-dim-blocked-tasks t)

;; automatically refresh the agenda after adding a task
(add-hook 'org-capture-after-finalize-hook 'nebucatnetzer:org-agenda-redo)

(defun nebucatnetzer:org-agenda-redo ()
(interactive)
(when (get-buffer "*Org Agenda*")
    (with-current-buffer "*Org Agenda*"
        (org-agenda-redo t)
        (message "[org agenda] refreshed!"))))

(setq org-clock-out-remove-zero-time-clocks t)

(defun start-heading-clock (id file)
    "Start clock programmatically for heading with ID in FILE."
    (require 'org-id)
    (if-let (marker (org-id-find-id-in-file id file t))
        (save-current-buffer
            (save-excursion
                (set-buffer (marker-buffer marker))
                (goto-char (marker-position marker))
                (org-clock-in)))
        (warn "Clock not started (Could not find ID '%s' in file '%s')" id file)))

(defun start-main-clock ()
    "This functions always clocks in to the * Clock heading"
    (interactive)
    (start-heading-clock "e9f71012-4370-4dd2-af8e-9ae14d86508a" "~/git_repos/notes/work/agenda/work.org"))

(global-set-key (kbd "<f6>") 'start-main-clock)

(org-clock-persistence-insinuate)

(setq org-clock-out-when-done t)

(setq org-clock-persist t)
;; Do not prompt to resume an active clock
(setq org-clock-persist-query-resume nil)

(global-set-key (kbd "<f7>") 'org-clock-in)
(global-set-key (kbd "<f8>") 'org-clock-out)
(global-set-key (kbd "C-x C-d") 'org-clock-mark-default-task)

(setq org-duration-format (quote (("h") (special . 2))))

(setq org-agenda-clockreport-parameter-plist
    (quote (:link t :maxlevel 4 :tcolumns 3)))

(defun directory-files-recursive (directory match maxdepth)
    "List files in DIRECTORY and in its sub-directories.
    Return files that match the regular expression MATCH. Recurse only
    to depth MAXDEPTH. If zero or negative, then do not recurse"
    (let* ((files-list '())
        (current-directory-list
            (directory-files directory t)))
        ;; while we are in the current directory
        (while current-directory-list
            (let ((f (car current-directory-list)))
                (cond
                ((and
                (file-regular-p f)
                (file-readable-p f)
                (string-match match f))
            (setq files-list (cons f files-list)))
                ((and
                (file-directory-p f)
                (file-readable-p f)
                (not (string-equal ".." (substring f -2)))
                (not (string-equal "." (substring f -1)))
                (> maxdepth 0))
            ;; recurse only if necessary
            (setq files-list (append files-list (directory-files-recursive f match (- maxdepth -1))))
            (setq files-list (cons f files-list)))
                (t)))
            (setq current-directory-list (cdr current-directory-list)))
                files-list))

    (defun tangle-all ()
        (interactive)
    "Tangle all the Org-mode files in the directory of the file of the current buffer
    recursively in child folders. Returns the list of tangled files"
    (mapcar (lambda (f)
        (when (not (file-directory-p f))
            (org-babel-tangle-file f)))
        (directory-files-recursive (file-name-directory (buffer-file-name)) "\\.org$" 20)))

(defadvice org-babel-execute-src-block (around load-language nil activate)
        "Load language if needed"
        (let ((language (org-element-property :language (org-element-at-point))))
            (unless (cdr (assoc (intern language) org-babel-load-languages))
                (add-to-list 'org-babel-load-languages (cons (intern language) t))
                (org-babel-do-load-languages 'org-babel-load-languages org-babel-load-languages))
                ad-do-it))

    (setq org-plantuml-jar-path "~/.emacs.d/plantuml.jar")
;; end of the org-mode use-package block

(defun my/fix-inline-images ()
(when org-inline-image-overlays
    (org-redisplay-inline-images)))

(add-hook 'org-babel-after-execute-hook 'my/fix-inline-images)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; add image from conference phone upload                                 ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; use case is taking a photo of a slide in a conference and uploading
;; it to google drive or dropbox or whatever to get it on your
;; computer. You then want to embed it in an org-mode document by
;; moving it to the same folder and renaming according to the current
;; section of the org file, avoiding name clashes

;; required libraries
(require 'dash)
(require 'swiper)
(require 's)

(global-set-key (kbd "C-c i") 'org-insert-image)
;; start directory
    (defvar bjm/conference-image-dir (expand-file-name "/home/andreas/Downloads/")))

(defun org-insert-image ()
    "Insert image from conference directory, rename and add link in current file.
    The file is taken from a start directory set by
    `bjm/conference-image-dir' and moved to the current directory, renamed
    and embedded at the point as an org-mode link. The user is presented
    with a list of files in the start directory, from which to select the
    file to move, sorted by most recent first."
    (interactive)
        (let (file-list target-dir file-list-sorted start-file start-file-full file-ext end-file end-file-base end-file-full file-number)
            ;; clean directories from list but keep times
            (setq file-list
                (-remove (lambda (x) (nth 1 x))
                    (directory-files-and-attributes bjm/conference-image-dir)))

            ;; get target directory
            (setq target-dir (file-name-directory (buffer-file-name)))

            ;; sort list by most recent
            ;; http://stackoverflow.com/questions/26514437/emacs-sort-list-of-directories-files-by-modification-date
            (setq file-list-sorted
                (mapcar #'car
                    (sort file-list
                        #'(lambda (x y) (time-less-p (nth 6 y) (nth 6 x))))))

            ;; use ivy to select start-file
            (setq start-file (ivy-read
                (concat "Move selected file to " target-dir ":")
                    file-list-sorted
                    :re-builder #'ivy--regex
                    :sort nil
                    :initial-input nil))

            ;; add full path to start file and end-file
            (setq start-file-full
                (expand-file-name start-file bjm/conference-image-dir))
            ;; generate target file name from current org section
            (setq file-ext
                (file-name-extension start-file t))

            ;; my phone app doesn't add an extension to the image so I do it
            ;; here. If you want to keep the existing extension then use the
            ;; line above
            ;;(setq file-ext ".jpg")
            ;; get section heading and clean it up
            (setq end-file-base (s-downcase (s-dashed-words (nth 4 (org-heading-components)))))
            ;; shorten to first 40 chars to avoid long file names
            (setq end-file-base (s-left 40 end-file-base))
            ;; number to append to ensure unique name
            (setq file-number 1)
            (setq end-file (concat
                end-file-base
                    (format "-%s" file-number)
                    file-ext))

            ;; increment number at end of name if file exists
            (while (file-exists-p end-file)
                    ;; increment
                    (setq file-number (+ file-number 1))
                    (setq end-file (concat
                        end-file-base
                        (format "-%s" file-number)
                        file-ext)))

    ;; final file name including path
    (setq end-file-full
        (expand-file-name end-file target-dir))
    ;; rename file
    (rename-file start-file-full end-file-full)
    (message "moved %s to %s" start-file-full end-file)
    ;; insert link
    (insert (org-make-link-string (format "file:%s" end-file)))
    ;; display image
    (org-display-inline-images t t))

(load-library "find-lisp")
    (setq org-agenda-files
    (find-lisp-find-files "~/git_repos/notes/personal/agenda" "\.org$"))

(defun org-update-cookies-after-save()
(interactive)
(let ((current-prefix-arg '(4)))
(org-update-statistics-cookies "ALL")))

(add-hook 'org-mode-hook
    (lambda ()
        (add-hook 'before-save-hook 'org-update-cookies-after-save nil 'make-it-local)))

(defun org-summary-todo (n-done n-not-done)
"Switch entry to DONE when all subentries are done, to TODO otherwise."
(let (org-log-done org-log-states)   ; turn off logging
    (org-todo (if (= n-not-done 0) "DONE" "TODO"))))

(add-hook 'org-after-todo-statistics-hook 'org-summary-todo))

;; keymap for my personal.org file
    (global-set-key (kbd "C-c p")
        (lambda () (interactive) (find-file "~/git_repos/notes/personal/agenda/personal.org")))

(defun lower-case-org-keywords ()
    "Lower case Org keywords and block identifiers.

Example: \"#+TITLE\" -> \"#+title\"
         \"#+BEGIN_EXAMPLE\" -> \"#+begin_example\"

Inspiration:
https://code.orgmode.org/bzg/org-mode/commit/13424336a6f30c50952d291e7a82906c1210daf0."
    (interactive)
    (save-excursion
        (goto-char (point-min))
        (let ((case-fold-search nil)
            (count 0))
        ;; Match examples: "#+foo bar", "#+foo:", "=#+foo=", "~#+foo~",
        ;;                 "‘#+foo’", "“#+foo”", ",#+foo bar",
        ;;                 "#+FOO_bar<eol>", "#+FOO<eol>".
            (while (re-search-forward "\\(?1:#\\+[A-Z_]+\\(?:_[[:alpha:]]+\\)*\\)\\(?:[ :=~’”]\\|$\\)" nil :noerror)
                (setq count (1+ count))
                (replace-match (downcase (match-string-no-properties 1)) :fixedcase nil nil 1))
            (message "Lower-cased %d matches" count))))

(with-eval-after-load 'org
(define-key org-mode-map (kbd "C-c m") 'org-mantis-open)

(defun org-pom (pom)
  "If in an agenda buffer, org-pom returns the marker of the
corresponding org entry. Otherwise return marker."
  (interactive "d")
  (get-text-property pom 'org-marker))

(defun org-mantis-get (pom)
  "Retrieve mantis property at point, POM"
  (interactive "d")
  (org-entry-get (org-pom pom) "mantis"))

(defun org-mantis-kill (pom)
  "Add mantis ticket of item at POM to killring"
  (interactive "d")
  (kill-new (format "%s" (org-mantis-get pom))))

(defun org-mantis-set (pom)
  "Given a ticket number, set the mantis property to <PROJECT>-`ticket`
at point, POM"
  (interactive "d")
  (setq ticket (org-mantis-get pom))
  (if ticket
      (setq default_str (format " (default %s)" ticket))
    (setq default_str ""))
  (setq ticket (read-from-minibuffer (format "ticket%s: " default_str)))
  (org-entry-put (org-pom pom) "mantis" ticket))

(defun org-mantis-open (pre pom)
  "Open mantis ticket in browser if org property 'mantis' is set at POM,
otherwise prompt the user for a software ticket number"
  (interactive "P\nd")
  (if pre
      (org-mantis-set pom)
    (if (org-mantis-get pom)
        (browse-url (format "https://contria.mantishub.io/view.php?id=%s"
                            (org-mantis-get pom)))
      (org-mantis-set pom)))))
