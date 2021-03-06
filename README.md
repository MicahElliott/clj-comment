# clj-comment

Clojure's `#_` ["discard"
macro](https://clojure.org/guides/weird_characters#__code_code_discard)
is a convenient way to disable pieces of code during debugging
sessions.  But typing `#_` is a pain, and you shouldn't have to jump
around (much) to insert it or remove it.  Instead, just _toggle_ it on
and off with _clj-comment_'s <kbd>C-c ;</kbd>.

## Installation

This package is available on [Melpa](melpa.org):

    M-x package-install clj-comment

Enable this in your Emacs config.  You should bind it to something
like <kbd>C-c ;</kbd> (I don't see that one being used elsewhere, and
it's similar to the `;`-style Clojure comment.)

``` el
(add-hook 'clojure-mode-hook #'clj-comment)
(global-set-key (kbd "C-c ;") 'clj-comment)
```

## Caveats
Although the `#_` can have whitespace between it and its discarded
form, clj-comment does not presently support the whitespace.

There is no nesting/stacking of `#_` supported very well.

## See Also

I like using <kbd>M-;</kbd> for
[comment-dwim-2](https://github.com/remyferre/comment-dwim-2).

[comment-line](https://www.gnu.org/software/emacs/manual/html_node/emacs/Comment-Commands.html)
is built into Emacs now.

[Cursive is trying to get this feature.](https://github.com/cursive-ide/cursive/issues/1047)
