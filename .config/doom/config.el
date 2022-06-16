;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Antonio Petrillo"
      user-mail-address "antonio.petrillo4@studenti.unina.it")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;;(setq doom-theme 'spacemacs-dark)
;;(setq doom-theme 'gruber-darker)
(setq doom-theme 'modus-vivendi)
;;(setq doom-theme 'doom-one)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/Documents/Org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; (add-to-list 'initial-frame-alist '(fullscreen . maximized))

(use-package! dired-hide-dotfiles
  :hook (dired-mode . dired-hide-dotfiles-mode)
  :custom ((dired-listing-switches "-agho --group-directories-first"))
  :config (evil-collection-define-key 'normal 'dired-mode-map
            "H" 'dired-hide-dotfiles-mode))

(evil-define-key 'normal dired-mode-map
  (kbd "h") 'dired-up-directory
  (kbd "l") 'dired-find-file
  (kbd "m") 'dired-mark
  (kbd "t") 'dired-toggle-marks
  (kbd "u") 'dired-unmark
  (kbd "C") 'dired-do-copy
  (kbd "D") 'dired-do-delete
  (kbd "J") 'dired-goto-file
  (kbd "M") 'dired-chmod
  (kbd "O") 'dired-chown
  (kbd "R") 'dired-rename
  (kbd "T") 'dired-do-touch
  (kbd "Y") 'dired-copy-filename-as-kill ; copies filename to kill ring.
  (kbd "+") 'dired-create-directory
  (kbd "-") 'dired-up-directory
  (kbd "% l") 'dired-downcase
  (kbd "% u") 'dired-upcase
  (kbd "; d") 'epa-dired-do-decrypt
  (kbd "; e") 'epa-dired-do-encrypt)

;; chage font
;; (setq doom-font (font-spec :family "Victor Mono Nerd Font" :size 15)
;;       doom-big-font (font-spec :family "Victor Mono Nerd Font" :size 24)
;;       doom-variable-pitch-font (font-spec :family "Victor Mono Nerd Font" :size 15))

(setq doom-font (font-spec :family "Terminus" :style "Regular" :size 24)
      doom-big-font (font-spec :family "Terminus" :size 36)
      doom-variable-pitch-font (font-spec :family "Terminus" :size 24))

(after! doom-themes
  (setq doom-themes-enable-bold t
        doom-themes-enable-italic t))
(custom-set-faces!
  '(font-lock-comment-face :slant italic)
  '(font-lock-keyword-face :slant italic))

;; use trash can in dired
(setq delete-by-moving-to-trash t)


;; keybindings to eval s-exp
(map! :leader
      (:prefix-map ("e" . "eval s-exp")
       :desc "eval s-expression" "e" #'eval-last-sexp
       :desc "eval region" "r" #'eval-region
       :desc "eval defun" "d" #'eval-defun
       :desc "eval buffer" "b" #'eval-buffer))

;; window management with hydra
;; inspired/borrowed from [[https://github.com/jakebox/jake-emacs][JakeB]]  --> for the future literate config

(general-define-key "M-o" 'nto/hydra-window-management/body)

;;  basic window management with hydra (what an awesome package!)
;;  TODO integrate (or improve):
;;  + ace window
;;  + edwina
;;  + eyebrowse
;;  + other basic app

(defhydra nto/hydra-window-management (:pre (message "window management")
                                       :color pink
                                       :hint nil
                                       :post (message "bye bye"))
  "
Movement^^      ^Split^         ^Switch^                ^Resize^                ^Action^
----------------------------------------------------------------------------------------
_h_ ← _H_ ← m   _v_ertical      _b_uffer                _=_  H ↑                _q_uit
_j_ ↓ _J_ ↓ m   _s_ horizontal  _f_ind files            _-_  H ↓                _t_erminal v
_k_ ↑ _K_ ↑ m   _d_ delete      _[_ next buffer         _._  W →                _T_erminal h
_l_ → _L_ → m   _c_ delete      _]_ prev buffer         _,_  W ←
^ ^             ^ ^             _C-k_ kill buffer       _e_ balance window
^ ^             ^ ^             _K_ kill this buffer    ^ ^
"

  ;; quit wm mode
  ("q" nil :color blue)
  ;; buffer & file
  ( "b" consult-buffer)
  ("[" previous-buffer)
  ("]" next-buffer)
  ("K" kill-this-buffer)
  ("C-k" kill-buffer)
  ("f" find-file)

  ;; window size
  ("=" evil-window-increase-height) ;; = so I don't need to use shift
  ("-" evil-window-decrease-height)
  ("." evil-window-increase-width)
  ("," evil-window-decrease-width)
  ("e" balance-windows)

  ;; split & swap
  ("c" evil-window-delete)
  ("d" evil-window-delete)
  ("S" ace-swap-window)
  ("v" evil-window-vsplit)
  ("s" evil-window-split)

  ;; split, then open app
  ;; I could have used progn or lambda, but this is cleaner
  ("t" nto/open-terminal-vertical)
  ("T" nto/open-terminal-horizontal)

  ;; movement
  ("h" evil-window-left)
  ("H" +evil/window-move-left)
  ("j" evil-window-down)
  ("J" +evil/window-move-down)
  ("k" evil-window-up)
  ("K" +evil/window-move-up)
  ("l" evil-window-right)
  ("L" +evil/window-move-right))

;; for me the split-window-vertically & split-window-horizontally don't make sense, so I have inverted them
;; they don't work as I expected!
(defun nto/open-terminal-horizontal ()
  (interactive)
  (split-window-vertically)
  (other-window 1)
  (eshell))

(defun nto/open-terminal-vertical ()
  (interactive)
  (split-window-horizontally)
  (other-window 1)
  (eshell))

;; battery in modeline
(display-battery-mode)

;; jumping around in the file with avy ;; maybe bind M-j
(map! :leader
      (:prefix-map ("j" . "jumping around")
       :desc "multi-char" "j" #'avy-goto-char-timer
       :desc "char" "J" #'avy-goto-char
       :desc "2char" "c" #'avy-goto-char-2))

;; make org pretty
(setq org-ellipsis " ▾")
(setq org-startup-folded t)
(setq org-startup-indented t)
(setq org-startup-with-inline-images t)

(add-hook! 'org-mode-hook #'org-superstar-mode)
(add-hook! 'org-mode-hook #'org-appear-mode)
(add-hook! 'org-mode-hook #'org-modern-mode)
(add-hook! 'org-agenda-finalize-hook #'org-modern-agenda)

(setq transparency 't
      transparency-level 85)

(defun nto/toggle-transparency ()
  "toggle transparency"
  (interactive)
  (if (eq transparency t)
      (progn
        (set-frame-parameter (selected-frame) 'alpha (list transparency-level transparency-level))
        (message "transparency on")
        (setq transparency nil))
    (set-frame-parameter (selected-frame) 'alpha '(100 100))
    (message "transparency off")
    (setq transparency t)))

;; utility
(map! :leader
      (:prefix-map ("T" . "nTo")
       :desc "transparency" "t" #'nto/toggle-transparency
       :desc "woman" "w" #'woman))

(use-package! org-auto-tangle
  :defer t
  :hook (org-mode . org-auto-tangle-mode)
  :config (setq org-auto-tangle-default t))
