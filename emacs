;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
;;              ZHUOZHAOJIN .emacs 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Misc setting
(global-font-lock-mode t)
(global-set-key [backspace] 'backward-delete-char)

(column-number-mode t)     ; display column number
(setq visible-bell t)     ; disable error bell
(show-paren-mode t)     ; parenthesis match
(setq inhibit-startup-message t)     ; disable emacs starting graphics
(setq gnus-inhibit-startup-message t) ; disable gnus starting graphics
(setq tab-width 4)

;;..............display time at minibuffer.................
(display-time-mode 1) 
(setq display-time-24hr-format t)
(setq display-time-day-and-date t)
(setq auto-save-default nil)
(setq-default make-backup-files nil)
(setq tab-width 4)
;;............ C language setting...................
(add-hook 'c-mode-hook  
	  '(lambda ()     
	     (c-set-style "bsd")))

;;................. C++ language setting
(add-hook 'c++-mode-hook  
	  '(lambda ()     
	     (c-set-style "stroustrup")     
	     (c-toggle-auto-state)))

(defun quick-compile ()
  "A quick compile funciton for C++"
  (interactive)
  (compile (concat "g++ -g -o -pg " 
		   (buffer-name (current-buffer)))))
(global-set-key [(f9)] 'quick-compile)  ;;快捷键F9

;;............ auto offset.... .......

(defun asm7090-font-lock ()
  (interactive)
  (setq font-lock-defaults nil
        font-lock-keywords nil)
  (font-lock-add-keywords nil
   (list
    (list
     (function search-asm7090-fields) ; parses an asm line.
     '(1 font-lock-function-name-face)       ; labels
     '(2 font-lock-keyword-face)             ; operation codes
     '(3 font-lock-reference-face)           ; arguments
     '(4 font-lock-comment-face)             ; comments
     '(5 font-lock-preprocessor-face)        ; ibsys
     '(6 font-lock-type-face)                ; cols 72-80
     ))))

(defun asm7090 ()
  (interactive)
  (asm7090-font-lock)
  (make-local-variable 'tab-stop-list)
  (setf tab-stop-list '(0 7 15 34 72)
        asm-comment-char   ?*)
  (local-set-key (kbd "TAB") (function tab-to-tab-stop))
  (local-set-key (kbd "RET") (lambda ()
                               (interactive)
                               (asm7090-describe-codop)
                               (newline-and-indent)))
  (font-lock-mode 1)
  (message "asm7090 activated")) 

;;add on 2011 by fengyun done
;;; plugin setting: color-theme
(add-to-list 'load-path "~/emacs.d/.emacs.d/color-theme-6.6.0")
(require 'color-theme)
(eval-after-load "color-theme"
  '(progn
     (color-theme-initialize)
     (color-theme-hober)
     ;;(color-theme-pok-wob)
     )
  )

;;; plugin setting: xcscope
(add-to-list 'load-path "~/emacs.d/.emacs.d/xcscope")
(require 'xcscope)


;;;------------------auto-complate----------------------
(add-to-list 'load-path "~/emacs.d/.emacs.d/auto-complete-1.3.1")
(require 'auto-complete)
(require 'auto-complete-config)
(global-auto-complete-mode t)
(setq-default ac-sources '(ac-source-words-in-same-mode-buffers))
(add-hook 'emacs-lisp-mode-hook (lambda () (add-to-list 'ac-sources 'ac-source-symbols)))
(add-hook 'auto-complete-mode-hook (lambda () (add-to-list 'ac-sources 'ac-source-filename)))
(set-face-background 'ac-candidate-face "lightgray")
(set-face-underline 'ac-candidate-face "darkgray")
(set-face-background 'ac-selection-face "steelblue") ;;; 设置比上面截图中更好看的背景颜色
(define-key ac-completing-map "\M-n" 'ac-next)  ;;; 列表中通过按M-n来向下移动
(define-key ac-completing-map "\M-p" 'ac-previous)
(setq ac-auto-start 2)
(setq ac-dwim t)
(define-key ac-mode-map (kbd "M-TAB") 'auto-complete)

;;...............括号自动补齐...............  
(defun my-c-mode-auto-pair ()  
  (interactive)  
  (make-local-variable 'skeleton-pair-alist)  
  (setq skeleton-pair-alist '(  
			      (?` ?` _ "''")  
			      (?\( _ ")")  
			      (?\[ _ "]")  
			      (?\{ _ "}")  
			      (?\" _ "\"")))  
  (setq skeleton-pair t)  
  (local-set-key (kbd "(") 'skeleton-pair-insert-maybe)  
  (local-set-key (kbd "{") 'skeleton-pair-insert-maybe)  
  (local-set-key (kbd "'") 'skeleton-pair-insert-maybe)  
  (local-set-key (kbd "[") 'skeleton-pair-insert-maybe)  
  (local-set-key (kbd "\"") 'skeleton-pair-insert-maybe))  
(add-hook 'c-mode-hook 'my-c-mode-auto-pair)  
(add-hook 'c++-mode-hook 'my-c-mode-auto-pair) 

;;.............auto mark...................................
(bookmark-bmenu-list);;..... 打开书签列表
(switch-to-buffer "*Bookmark List*") ;;切换到书签列表

(defun auto-mark-quit () 
  (interactive)
  (bookmark-save (bookmark-set))
  (save-buffers-kill-terminal)) ;;原来退出执行的命令
(global-set-key (kbd "C-x C-c") 'auto-mark-quit) 

(put 'upcase-region 'disabled nil)
;;...............................................
;;.........add by myself.........................

;; ...........display time.......................
(display-time-mode t)  
(setq display-time-24hr-format t)  
(setq display-time-day-and-date t)  

;;........ 显示行号..............................：

(require 'linum)
(global-linum-mode t)
(column-number-mode t)
(setq column-number-mode t)
(setq line-number-mode t)

(set-face-background 'default "black")
(set-face-foreground 'default "gray")
(set-cursor-color "white")

;;;..........close the start windows............
;;;..........close the menu and tool............

(setq inhibit-startup-message t)
(setq frame-title-format "My Emacs world! ")
(tool-bar-mode -1)
(set-scroll-bar-mode nil)
(setq gnus-inhibit-startup-message t)

;;..............Full screen or Maximized.........

;;.....full screen with F11
(global-set-key [f11] 'my-fullscreen)

(defun my-fullscreen ()
  (interactive)
  (x-send-client-message
   nil 0 nil "_NET_WM_STATE" 32
   '(2 "_NET_WM_STATE_FULLSCREEN" 0))
  )

;;....maximized with F12
(global-set-key [f12] 'my-maximized)

(defun my-maximized ()
  (interactive)
  (x-send-client-message
   nil 0 nil "_NET_WM_STATE" 32
   '(2 "_NET_WM_STATE_MAXIMIZED_HORZ" 0))
  (x-send-client-message
   nil 0 nil "_NET_WM_STATE" 32
   '(2 "_NET_WM_STATE_MAXIMIZED_VERT" 0))
  )
;;..........yasnippet mode...........

(add-to-list 'load-path 
	     "~/emacs.d/.emacs.d/yasnippet-0.6.1c")
(require 'yasnippet)
(yas/initialize)
(yas/load-directory "~/emacs.d/.emacs.d/yasnippet-0.6.1c/snippets")
(yas/global-mode 1)

;;...................................
;;............cedet setting..........
(add-to-list 'load-path
	     "~/emacs.d/.emacs.d/cedet-1.1/common")
(load-file "~/emacs.d/.emacs.d/cedet-1.1/common/cedet.el")
(global-ede-mode 1)
(semantic-load-enable-code-helpers)

;;...............ecb setting..........
(add-to-list 'load-path
    "~/emacs.d/.emacs.d/ecb-2.40")

(require 'ecb)
(require 'ecb-autoloads)
(setq stack-trace-on-error nil)
(setq ecb-auto-activate t
      ecb-tip-of-the-day nil)

(global-set-key [M-left] 'windmove-left)
(global-set-key [M-right] 'windmove-right)
(global-set-key [M-up]    'windmove-up)
(global-set-key [M-down]  'windmove-down)

 ;;.........show&hide window.............
(global-set-key [C-f1] 'ecb-hide-ecb-windows)
(global-set-key [C-f2] 'ecb-show-ecb-windows)

(global-set-key (kbd "C-x C-;") 'ecb-activate)
(global-set-key (kbd "C-x C-'") 'ecb-deactivate)

(ecb-layout-define "george-layout" left-right
    (ecb-set-directories-buffer)
    (ecb-split-ver 0.6)
  (ecb-set-sources-buffer)
  (select-window (next-window (next-window)))
  (ecb-set-methods-buffer)
  (ecb-split-ver 0.6)
  (ecb-set-history-buffer)
  (select-window (previous-window (selected-window) 0)))

(setq ecb-history-make-buckets 'never)
(setq ecb-layout-name "george-layout")
 
;;.............end ecb...........................
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ecb-layout-window-sizes (quote (("george-layout" (0.19014084507042253 . 0.5675675675675675) (0.19014084507042253 . 0.40540540540540543) (0.19718309859154928 . 0.5675675675675675) (0.19718309859154928 . 0.40540540540540543)))))
 '(ecb-options-version "2.40"))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(put 'scroll-left 'disabled nil)

;;...............markdown mode........................
;;...............added by phycles.....................
(add-to-list 'load-path
	     "~/emacs.d/.emacs.d/markdown-mode")
(autoload 'markdown-mode "markdown-mode"
   "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

;;.................ibus setting..........
;;.................Chinese input..........
(require 'ibus)
    (add-hook 'after-init-hook 'ibus-mode-on)
(put 'set-goal-column 'disabled nil)
