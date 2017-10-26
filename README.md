# Emacs config

This is my Emacs configuration.

Actually, it's highly personalized, with the key binding setup.

This config is easy to use, perhaps easier than most starter kits out there.  But it's not meant for Emacs novices.

Now it can be used for:

- Ruby and RoR development;
- Making presentations with org-mode and reveal.js;

I'm using on MacOS, but there's no reason for it not to work on other systems.

## Org-mode configuration file

The config a fully configured with `org-mode` and `use-package` setup that includes major packages like:

- `Evil-mode`: Emulates the main features of Vim;
- `Projectile`: Project interaction library for Emacs;
- `Use-package`: Isolate package configuration in Emacs;
- `Magit`: Git porcelain inside Emacs;
- `Avy`: Jumps to visible text using a char-based decision tree;
- `Hydra`: Tie related commands into a family of short bindings with a common prefix;
- `Company`: Modular in-buffer completion framework for Emacs;

## Keybindings
Since i'm using `Evil-mode` please see [KEYBINDINGS.md][keybindings].

[keybindings]: https://github.com/0xk175un3/dotfiles/blob/master/KEYBINDINGS.md
