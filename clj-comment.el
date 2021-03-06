;;; clj-comment.el --- Comment out Clojure forms with the "ignore" macro   -*- lexical-binding: t -*-
;;
;; Copyright © 2019 Micah Elliott
;;
;; Author: Micah Elliott <mde@micahelliott.com>
;; URL: https://github.com/MicahElliott/clj-comment
;; Version: 0.1.0-snapshot
;; Keywords: commenting comments clojure
;; Package-Requires: ((emacs "25.1") (smartparens "1.11.0") (clojure-mode "5.9.0"))

;; This file is not part of GNU Emacs.

;;; Commentary:
;;
;; Do a Clojure-style `#_' un/commenting of “ignore” macro for sexps,
;; including most any pair that is treated by smartparens.
;; Helpful for debugging.
;;
;; See the README for more details:
;; https://github.com/micahelliott/clj-comment

;;; TODO:
;; + enable `(comment ...)'-style
;;

;;; License:

;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License
;; as published by the Free Software Foundation; either version 3
;; of the License, or (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to the
;; Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
;; Boston, MA 02110-1301, USA.

;;; Code:

(require 'smartparens)




(defun clj-comment-action ()
  "Simplistic original non-recursive version, still useful."
  (interactive)
  (save-excursion
    (when (not (= (char-after) ?\())
      ;; (backward-sexp) ; not far enough and weird error sometimes
      (sp-backward-up-sexp)) ; smartparens is easier
    (if (= (char-before) ?_)
        (delete-char -2)
      (progn
        (message "commenting form")
        (insert "#_")))))

;; (global-set-key (kbd "C-c ;") 'clj-comment-action)

(defun clj-recurse-to-top ()
  "Search up tree for ignore-comment macro until found or give up at top."
  (if (sp-backward-up-sexp) ; returns nil when reaches top
      ;; Work our way up tree till top or found existing comment
      (if (not (equal (char-before) ?_))
          ;; recursing up, no symbol yet
          (clj-recurse-to-top)
        (progn
          (message "uncommenting form")
          (delete-char -2)
          nil))  ; be explicit about returning nil
    ;; Made it all the way to top; getting out now; no symbol found
    ;; FIXME: still might need to check for symbol
    t))

;;;###autoload
(defun clj-comment ()
  "Do a Clojure-style `#_' un/commenting of “ignore” macro for sexps.
Somewhat helpful for debugging.
Requires smartparens (for now)."
  (interactive)
  (let ((beg (point)))
    (if (clj-recurse-to-top)
        (progn
          ;; must have returned true; action to take!
          (goto-char beg)
          ;; (message "inserting inside at %s now" beg)
          (clj-comment-action))
      ;; action already taken
      (goto-char (- beg 2)))))

;; (global-set-key (kbd "C-c ;") 'clj-comment)

(provide 'clj-comment)

;;; clj-comment.el ends here
