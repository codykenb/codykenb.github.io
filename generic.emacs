(if window-system (require 'font-latex))
(setq font-lock-maximum-decoration t)
(setq auto-mode-alist (cons '("\\.tex$" . latex-mode) auto-mode-alist))
(setq latex-run-command "pdflatex")

(require 'org-install)
(require 'org)
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)
(setq TeX-PDF-mode t)

; Some initial langauges we want org-babel to support
(org-babel-do-load-languages
 'org-babel-load-languages
 '(
   (sh . t)
   (python . t)
   (R . t)
   (sqlite . t)
   (perl . t)
      ))

  (add-hook 'LaTeX-mode-hook (lambda ()
                              (push 
                               '("pdflatex" "pdflatex %s" TeX-run-command nil t 
                                 :help "Run pdfLatex on file")
                               TeX-command-list)))

(desktop-save-mode 1)

(put 'upcase-region 'disabled nil)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(background-color "#7f7f7f")
 '(background-mode dark)
 '(cursor-color "#5c5cff")
 '(custom-safe-themes
   (quote
    ("9a3c51c59edfefd53e5de64c9da248c24b628d4e78cc808611abd15b3e58858f" "2d16f85f22f1841390dfc1234bd5acfcce202d9bb1512aa8eabd0068051ac8c3" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" "e93d61fac6b09f8cf81e18fd441db4a72f45fd53e5ec1f28ef7bd7bfe4954126" "d79ece4768dfc4bab488475b85c2a8748dcdc3690e11a922f6be5e526a20b485" "cc60d17db31a53adf93ec6fad5a9cfff6e177664994a52346f81f62840fe8e23" "a455366c5cdacebd8adaa99d50e37430b0170326e7640a688e9d9ad406e2edfd" "a1289424bbc0e9f9877aa2c9a03c7dfd2835ea51d8781a0bf9e2415101f70a7e" "2d5c40e709543f156d3dee750cd9ac580a20a371f1b1e1e3ecbef2b895cf0cd2" "604648621aebec024d47c352b8e3411e63bdb384367c3dd2e8db39df81b475f5" "6bb466c89b7e3eedc1f19f5a0cfa53be9baf6077f4d4a6f9b5d087f0231de9c8" "fad38808e844f1423c68a1888db75adf6586390f5295a03823fa1f4959046f81" "2882cf41c12276b5875879a71cc670d1468653e342586075a48ed68cfed15bea" "7f5837a7dbf54c2b7c41d94f5eb1373cf63274847d1971037faa24d7f2231eea" "39dd7106e6387e0c45dfce8ed44351078f6acd29a345d8b22e7b8e54ac25bac4" "97d039a52cfb190f4fd677f02f7d03cf7dbd353e08ac8a0cb991223b135ac4e6" "2639cb70bf4e45246fc7330d1809536b79cd9078050119d97477d7bdc779adb3" "ffc01b1b3a7cc43c6d0f25ff5573c21fe6cdf2e4e6ab0e4667856f1a90b98c60" "b2db1708af2a7d50cac271be91908fffeddb04c66cb1a853fff749c7ad6926ae" "98cc377af705c0f2133bb6d340bf0becd08944a588804ee655809da5d8140de6" "d606ac41cdd7054841941455c0151c54f8bff7e4e050255dbd4ae4d60ab640c1" "1e7e097ec8cb1f8c3a912d7e1e0331caeed49fef6cff220be63bd2a6ba4cc365" "fc5fcb6f1f1c1bc01305694c59a1a861b008c534cae8d0e48e4d5e81ad718bc6" default)))
 '(desktop-save-mode t)
 '(org-export-backends (quote (ascii html icalendar latex md)))
 '(org-startup-truncated nil)
 '(package-selected-packages
   (quote
    (w3m seoul256-theme quasi-monochrome-theme phoenix-dark-mono-theme monochrome-theme suscolors-theme kooten-theme labburn-theme danneskjold-theme abyss-theme foggy-night-theme realgud anaconda-mode elpy w3 color-theme-solarized auctex)))
 '(python-shell-interpreter "python3")
 '(safe-local-variable-values (quote ((TeX-master . "../thesis")))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:background nil))))
 '(highlight-indentation-face ((t (:inherit variable-pitch)))))

(setq inhibit-startup-screen t)
(add-hook 'emacs-startup-hook 'delete-other-windows)

;;(add-hook 'window-setup-hook 'delete-other-windows)
  (global-set-key (kbd "C-x f") 'find-file-at-point) ;; I hardly ever set the fill-column
(org-agenda-list)

(add-hook 'LaTeX-mode-hook 'turn-on-reftex)   ; with AUCTeX LaTeX mode
(add-hook 'latex-mode-hook 'turn-on-reftex)   ; with Emacs latex mode
(setq reftex-plug-into-AUCTeX t)
(setq reftex-mode t)

(eval-after-load "tex" 
   '(setcdr (assoc "LaTeX" TeX-command-list)
               '("%`%l%(mode) -shell-escape%' %t"
                           TeX-run-TeX nil (latex-mode doctex-mode) :help "Run LaTeX")
                   )
     )

(add-hook 'LaTeX-mode-hook (lambda ()
                              (push 
                                   '("Latexmk" "latexmk -pdf %s" TeX-run-TeX nil t
                                           :help "Run Latexmk on file")
                                       TeX-command-list)))


(setq x-select-enable-clipboard t)

(if (eq system-type 'gnu-linux)
	(progn  
		(load-file "/home/bck/.emacs.d/xclip.el")
		;;;;(xclip-mode 1)
		(turn-on-xclip)
		(setq x-select-enable-clipboard t) (setq interprogram-paste-function 'x-cut-buffer-or-selection-value)
	)
)

(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))
(let ((my-cabal-path (expand-file-name "~/.cabal/bin")))
  (setenv "PATH" (concat my-cabal-path ":" (getenv "PATH")))
  (add-to-list 'exec-path my-cabal-path))
;; (custom-set-variables '(haskell-tags-on-save t))

(add-to-list 'auto-mode-alist '("/mutt" . mail-mode))
(add-hook 'term-setup-hook
          (lambda () (define-key input-decode-map "\e[Z" [backtab])))
(add-hook 'term-setup-hook
          (lambda () (define-key input-decode-map "\e[z" [backtab])))

; Execute babel source blocks asynchronously by just opening a new emacs.
(defun bab/org-babel-execute-src-block-new-emacs ()
  "Execute the current source block in a separate emacs,
so we do not block the current emacs."
  (interactive)
  (let ((line (line-number-at-pos))
        (file (buffer-file-name)))
    (async-shell-command (concat 
                          "TERM=vt200 emacs -nw --find-file " 
                          file 
                          " --eval '(goto-line "
                          (number-to-string line) 
                          ")' --eval "
     "'(let ((org-confirm-babel-evaluate nil))(org-babel-execute-src-block t))' "
                          "--eval '(kill-emacs 0)'"))))

(require 'package)
;;(add-to-list 'package-archives
;;	     '("melpa" . "http://stable.melpa.org/packages/") t)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)

(when (>= emacs-major-version 24)
  (require 'package)
  (add-to-list
   'package-archives
   '("melpa" . "http://melpa.org/packages/")
   t)
    (package-initialize))

;; ====================
;; insert date and time


(defvar current-date-time-format "%d %b %Y" ;%a %d %H:%M:%S %Z %Y"
  "Format of date to insert with `insert-current-date-time' func
See help of `format-time-string' for possible replacements")

(defvar current-time-format "%H:%M:%S"
  "Format of date to insert with `insert-current-time' func.
Note the weekly scope of the command's precision.")

(defun insert-current-date-time ()
  "insert the current date and time into current buffer.
Uses `current-date-time-format' for the formatting the date/time."
       (interactive)
;       (insert "==========\n")
;       (insert (let () (comment-start)))
       (insert (format-time-string current-date-time-format (current-time)))
;       (insert "\n")
       )

(defun insert-current-time ()
  "insert the current time (1-week scope) into the current buffer."
       (interactive)
       (insert (format-time-string current-time-format (current-time)))
;       (insert "\n")
       )

(global-set-key "\C-x\C-d" 'insert-current-date-time)
(global-set-key "\C-x\C-t" 'insert-current-time)
(setq tramp-default-method "ssh")
(global-set-key (kbd "C-x g") 'magit-status)
(eval-after-load 'shell
  '(progn
     (autoload 'ansi-color-for-comint-mode-on "ansi-color" nil t)
     (add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on t)
           t))
;; Tramp (http://www.emacswiki.org/emacs/TrampMode) for remote files
;; http://stackoverflow.com/questions/13997965/bizzarre-emacs-tramp-fix
(require 'tramp)
(add-to-list 'tramp-remote-path 'tramp-own-remote-path)
(setq tramp-default-method "ssh")
;; Backup (file~) disabled and auto-save (#file#) locally to prevent delays in editing remote files
(add-to-list 'backup-directory-alist
             (cons tramp-file-name-regexp nil))
(setq tramp-auto-save-directory temporary-file-directory)
(setq tramp-verbose 10)
;;  (add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)


  (require 'cl-lib)

;; Makes *scratch* empty.
(setq initial-scratch-message "")

;; Removes *scratch* from buffer after the mode has been set.
(defun remove-scratch-buffer ()
  (if (get-buffer "*scratch*")
      (kill-buffer "*scratch*")))
(add-hook 'after-change-major-mode-hook 'remove-scratch-buffer)

;; Removes *messages* from the buffer.
(setq-default message-log-max nil)
(kill-buffer "*Messages*")

;; Removes *Completions* from buffer after you've opened a file.
(add-hook 'minibuffer-exit-hook
      '(lambda ()
         (let ((buffer "*Completions*"))
           (and (get-buffer buffer)
                (kill-buffer buffer)))))

;; Don't show *Buffer list* when opening multiple files at the same time.
(setq inhibit-startup-buffer-menu t)

;; Show only one active window when opening multiple files at the same time.
(add-hook 'window-setup-hook 'delete-other-windows)
(setq initial-buffer-choice "~/org/index.org")
(setq initial-buffer-choice
      (lambda ()
        (get-buffer "*index*")))
(setq tramp-auto-save-directory "~/.emacs.d/tramp-autosave/")
(setq-default indent-tabs-mode nil)
(setq tab-stop-list (number-sequence 4 120 4))

(require 'ox-latex)
(add-to-list 'org-latex-packages-alist '("" "minted"))
(setq org-latex-listings 'minted)

(setq org-latex-pdf-process
      '("pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
	"pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
	        "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"))

(add-hook 'python-mode-hook
	  (lambda ()
	    (setq tab-width 4)
	    (setq python-indent 4)))

(require 'flymake)

(defun flymake-get-tex-args (file-name)
  (list "pdflatex"
	(list "-file-line-error" "-draftmode" "-interaction=nonstopmode" file-name)))

(add-hook 'LaTeX-mode-hook 'flymake-mode)
(setq ispell-program-name "aspell") ; could be ispell as well, depending on your preferences
(setq ispell-dictionary "english") ; this can obviously be set to any language your spell-checking program supports

(add-hook 'LaTeX-mode-hook 'flyspell-mode)
(add-hook 'LaTeX-mode-hook 'flyspell-buffer)

(defun turn-on-outline-minor-mode ()
  (outline-minor-mode 1))

(add-hook 'LaTeX-mode-hook 'turn-on-outline-minor-mode)
(add-hook 'latex-mode-hook 'turn-on-outline-minor-mode)
(setq outline-minor-mode-prefix "\C-c \C-o") ; Or something else

;; (global-auto-revert-mode t) ;; refresh all buffers (reread changed files)

(load-theme 'tango-dark)
(windmove-default-keybindings)

  (add-to-list 'load-path "/usr/bin") (add-to-list 'exec-path "/usr/bin")


(server-start)


;; python setup
(require 'package)

(add-to-list 'package-archives
       '("melpa" . "http://melpa.org/packages/") t)

;; (package-initialize)
;; (when (not package-archive-contents)
;;  (package-refresh-contents))

(defvar myPackages
  '(better-defaults
    ein
    elpy
    flycheck
    material-theme
    py-autopep8))

(mapc #'(lambda (package)
    (unless (package-installed-p package)
      (package-install package)))
      myPackages)

;; BASIC CUSTOMIZATION
;; --------------------------------------

(setq inhibit-startup-message t) ;; hide the startup message
;; (load-theme 'material t) ;; load material theme
;; (global-linum-mode t) ;; enable line numbers globally

;; PYTHON CONFIGURATION
;; --------------------------------------

(elpy-enable)
;;(elpy-use-ipython)

;; use flycheck not flymake with elpy
(when (require 'flycheck nil t)
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))

;; enable autopep8 formatting on save
(require 'py-autopep8)
(add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save)

;; init.el ends here

(setq py-python-command "python3")
(setq gud-pdb-command-name "python3 -m pdb")

(setq split-height-threshold nil)
(setq split-width-threshold 160)

(defun annotate-pdb ()
  (interactive)
  (highlight-lines-matching-regexp "import pdb")
  (highlight-lines-matching-regexp "pdb.set_trace()"))

(add-hook 'python-mode-hook 'annotate-pdb)


(defvar gud-overlay
  (let* ((ov (make-overlay (point-min) (point-min))))
    (overlay-put ov 'face 'secondary-selection)
    ov)
  "Overlay variable for GUD highlighting.")
(defadvice gud-display-line (after my-gud-highlight act)
  "Highlight current line."
  (let* ((ov gud-overlay)
         (bf (gud-find-file true-file)))
    (with-current-buffer bf
      (move-overlay ov (line-beginning-position) (line-beginning-position 2)
                    ;;(move-overlay ov (line-beginning-position) (line-end-position)
                    (current-buffer)))))
(defun gud-kill-buffer ()
  (if (derived-mode-p 'gud-mode)
      (delete-overlay gud-overlay)))
  (add-hook 'kill-buffer-hook 'gud-kill-buffer)


(set-face-attribute 'highlight-indentation-face nil
                    :stipple (list 7 4 (string 16 0 0 0))
                    :inherit nil)

(set-face-attribute 'highlight-indentation-current-column-face nil
                    :stipple (list 7 4 (string 16 0 0 0))
                    :inherit nil
                    :foreground "yellow")



(defun pdb-restart ()
  (interactive)
  (comint-insert-send "restart")
  (sleep-for .5)
  (when
      (or
       (last-lines-match "raise Restart.*
Restart")
       (last-lines-match "restart")
       (not (get-buffer-process (current-buffer)))
       )

    (let (
      (kill-buffer-query-functions nil );disable confirming for process kill
      (pdbcmd (car-safe (symbol-value (gud-symbol 'history nil 'pdb))))
      (default-directory default-directory)
      )
      (kill-this-buffer)
      (cd default-directory)
      (pdb pdbcmd))
    )
  (comint-insert-send "n")
)
(defun comint-insert-send (input)
  (insert input)
  (comint-send-input)
)
(defun last-lines-match (regexp &optional n)
  (setq n (or n 3))
  (re-search-backward regexp (line-beginning-position (- 0 n)) t))

(define-key gud-mode-map "R" 'pdb-restart)

;;----------------------------------------------------------------------------
;; ipdb
;; from: pedrokroger.net/2010/07/configuring-emacs-as-a-python-ide-2/
;; Highlight ipdb lines:
(defun annotate-pdb ()
  (interactive)
  (highlight-lines-matching-regexp "import pdb")
  (highlight-lines-matching-regexp "pdb.set_trace()"))
 
(add-hook 'python-mode-hook 'annotate-pdb)
 
;;----------
;; Keybinding to add breakpoint:
(defun python-add-breakpoint ()
  (interactive)
  (newline-and-indent)
  (insert "import ipdb; ipdb.set_trace()")
  (highlight-lines-matching-regexp "^[ ]*import ipdb; ipdb.set_trace()"))
 
(define-key python-mode-map (kbd "C-c C-t") 'python-add-breakpoint)
