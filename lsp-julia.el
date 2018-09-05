;;; lsp-julia.el --- Julia support for lsp-mode

;; Copyright (C) 2017 Martin Wolke, 2018 Adam Beckmeyer

;; Author: Martin Wolke <vibhavp@gmail.com>
;;         Adam Beckmeyer <adam_git@thebeckmeyers.xyz>
;; Maintainer: Adam Beckmeyer <adam_git@thebeckmeyers.xyz>
;; Version: 0.1.0
;; Package-Requires: (lsp-mode)
;; Keywords: languages, tools
;; URL: https://github.com/non-Jedi/lsp-julia

;;; Code:
(require 'lsp-mode)

(defcustom lsp-julia-command "julia"
  "Command to invoke julia with."
  :type 'string
  :group 'lsp-julia)

(defcustom lsp-julia-flags '("--startup-file=no" "--history-file=no")
  "List of additional flags to call julia with."
  :type '(repeat (string :tag "argument"))
  :group 'lsp-julia)

(defcustom lsp-julia-timeout 30
  "Time before lsp-mode should assume julia just ain't gonna start."
  :group 'lsp-julia)

(defun lsp-julia--get-root ()
  "Try to find the package directory by searching for a .gitignore file.
If no .gitignore file can be found use the default directory "
  (let ((dir (locate-dominating-file default-directory ".gitignore")))
    (if dir
        (expand-file-name dir)
      default-directory)))

(defun lsp-julia--rls-command ()
  `(,lsp-julia-command ,@lsp-julia-flags "-e using LanguageServer; server = LanguageServer.LanguageServerInstance(STDIN, STDOUT, false); server.runlinter = true; run(server);"))


(defconst lsp-julia--handlers
  '(("window/setStatusBusy" .
     (lambda (w _p)))
    ("window/setStatusReady" .
     (lambda(w _p)))))

(defun lsp-julia--initialize-client(client)
  (mapcar #'(lambda (p) (lsp-client-on-notification client (car p) (cdr p))) lsp-julia--handlers)
  (setq-local lsp-response-timeout lsp-julia-timeout))

(lsp-define-stdio-client lsp-julia "julia" #'lsp-julia--get-root nil
                         :command-fn #'lsp-julia--rls-command
                         :initialize #'lsp-julia--initialize-client)

(provide 'lsp-julia)
;;; lsp-julia.el ends here
