Tamzen font
===========

This is [my personal fork][1] of the wonderful [Tamsyn font by Scott Fial][2].
It is programatically forked from Tamsyn version 1.11 by the `Rakefile` script
(see the "Building" section below) which backports glyphs from older versions
while deleting deliberately empty glyphs (which are marked as unimplemented)
to allow secondary/fallback fonts to provide real glyphs at those codepoints.

The "TamzenForPowerline" fonts provide additional [Powerline symbols][5],
which are programatically injected with [ZyX_I's bitmap-font-patcher][6].
I later hand-tweaked those symbols to perfection in the gbdfed(1) editor:

* For all icons, I expanded them to occupy the maximum available space.
* For the fork icon ( U+E0A0), I made the branch larger than the trunk.
* For the newline icon ( U+E0A1), I made the "N" at the bottom larger.
* For the padlock icon ( U+E0A2), I replaced the keyhole with // lines.

Overview
--------

<!-- vim-markdown-toc GFM -->

* [Screenshots](#screenshots)
  * [TamzenForPowerline-20](#tamzenforpowerline-20)
  * [TamzenForPowerline-16](#tamzenforpowerline-16)
  * [TamzenForPowerline-15](#tamzenforpowerline-15)
  * [TamzenForPowerline-14](#tamzenforpowerline-14)
  * [TamzenForPowerline-13](#tamzenforpowerline-13)
  * [TamzenForPowerline-12](#tamzenforpowerline-12)
  * [TamzenForPowerline-9](#tamzenforpowerline-9)
  * [Tamzen-20](#tamzen-20)
  * [Tamzen-16](#tamzen-16)
  * [Tamzen-15](#tamzen-15)
  * [Tamzen-14](#tamzen-14)
  * [Tamzen-13](#tamzen-13)
  * [Tamzen-12](#tamzen-12)
  * [Tamzen-9](#tamzen-9)
* [Installation](#installation)
  * [Linux VT integration](#linux-vt-integration)
  * [XTerm integration](#xterm-integration)
  * [URxvt integration](#urxvt-integration)
* [Building](#building)
  * [Requirements](#requirements)
* [License](#license)

<!-- vim-markdown-toc -->

Screenshots
-----------

![man manual page](https://sunaku.github.io/gruvbox-terminal-color-scheme-man.png)
![tmux, vim, etc.](https://sunaku.github.io/tmux-layout-dwindle.png)

```sh
$ cat screenshot.txt
ABCDEFGHIJKLMNOPQRSTUVWXYZ 12345
abcdefghijklmnopqrstuvwxyz 67890
{}[]()<>$*-+=/#_%^@\&|~?'"`!,.;:
Illegal1i = oO0          
The quick brown fox, (..) Hello,
jumps over lazy dog. /__\ World!
```

### TamzenForPowerline-20
![TamzenForPowerline10x20r.bdf](https://github.com/sunaku/tamzen-font/raw/master/png/TamzenForPowerline10x20r.png)
![TamzenForPowerline10x20b.bdf](https://github.com/sunaku/tamzen-font/raw/master/png/TamzenForPowerline10x20b.png)

### TamzenForPowerline-16
![TamzenForPowerline8x16r.bdf](https://github.com/sunaku/tamzen-font/raw/master/png/TamzenForPowerline8x16r.png)
![TamzenForPowerline8x16b.bdf](https://github.com/sunaku/tamzen-font/raw/master/png/TamzenForPowerline8x16b.png)

### TamzenForPowerline-15
![TamzenForPowerline8x15r.bdf](https://github.com/sunaku/tamzen-font/raw/master/png/TamzenForPowerline8x15r.png)
![TamzenForPowerline8x15b.bdf](https://github.com/sunaku/tamzen-font/raw/master/png/TamzenForPowerline8x15b.png)

### TamzenForPowerline-14
![TamzenForPowerline7x14r.bdf](https://github.com/sunaku/tamzen-font/raw/master/png/TamzenForPowerline7x14r.png)
![TamzenForPowerline7x14b.bdf](https://github.com/sunaku/tamzen-font/raw/master/png/TamzenForPowerline7x14b.png)

### TamzenForPowerline-13
![TamzenForPowerline7x13r.bdf](https://github.com/sunaku/tamzen-font/raw/master/png/TamzenForPowerline7x13r.png)
![TamzenForPowerline7x13b.bdf](https://github.com/sunaku/tamzen-font/raw/master/png/TamzenForPowerline7x13b.png)

### TamzenForPowerline-12
![TamzenForPowerline6x12r.bdf](https://github.com/sunaku/tamzen-font/raw/master/png/TamzenForPowerline6x12r.png)
![TamzenForPowerline6x12b.bdf](https://github.com/sunaku/tamzen-font/raw/master/png/TamzenForPowerline6x12b.png)

### TamzenForPowerline-9
![TamzenForPowerline5x9r.bdf](https://github.com/sunaku/tamzen-font/raw/master/png/TamzenForPowerline5x9r.png)
![TamzenForPowerline5x9b.bdf](https://github.com/sunaku/tamzen-font/raw/master/png/TamzenForPowerline5x9b.png)

### Tamzen-20
![Tamzen10x20r.bdf](https://github.com/sunaku/tamzen-font/raw/master/png/Tamzen10x20r.png)
![Tamzen10x20b.bdf](https://github.com/sunaku/tamzen-font/raw/master/png/Tamzen10x20b.png)

### Tamzen-16
![Tamzen8x16r.bdf](https://github.com/sunaku/tamzen-font/raw/master/png/Tamzen8x16r.png)
![Tamzen8x16b.bdf](https://github.com/sunaku/tamzen-font/raw/master/png/Tamzen8x16b.png)

### Tamzen-15
![Tamzen8x15r.bdf](https://github.com/sunaku/tamzen-font/raw/master/png/Tamzen8x15r.png)
![Tamzen8x15b.bdf](https://github.com/sunaku/tamzen-font/raw/master/png/Tamzen8x15b.png)

### Tamzen-14
![Tamzen7x14r.bdf](https://github.com/sunaku/tamzen-font/raw/master/png/Tamzen7x14r.png)
![Tamzen7x14b.bdf](https://github.com/sunaku/tamzen-font/raw/master/png/Tamzen7x14b.png)

### Tamzen-13
![Tamzen7x13r.bdf](https://github.com/sunaku/tamzen-font/raw/master/png/Tamzen7x13r.png)
![Tamzen7x13b.bdf](https://github.com/sunaku/tamzen-font/raw/master/png/Tamzen7x13b.png)

### Tamzen-12
![Tamzen6x12r.bdf](https://github.com/sunaku/tamzen-font/raw/master/png/Tamzen6x12r.png)
![Tamzen6x12b.bdf](https://github.com/sunaku/tamzen-font/raw/master/png/Tamzen6x12b.png)

### Tamzen-9
![Tamzen5x9r.bdf](https://github.com/sunaku/tamzen-font/raw/master/png/Tamzen5x9r.png)
![Tamzen5x9b.bdf](https://github.com/sunaku/tamzen-font/raw/master/png/Tamzen5x9b.png)

Installation
------------

Using a package manager:

[![Packaging status](https://repology.org/badge/vertical-allrepos/fonts:tamzen.svg)](https://repology.org/project/fonts:tamzen/versions)

Manually, in Linux:

* [Download a release]( https://github.com/sunaku/tamzen-font/releases )
  or clone this Git repository into `~/.fonts/tamzen-font` and then run:

      xset +fp ~/.fonts/tamzen-font/bdf
      xset fp rehash

* You should now be able to see the "Tamzen" font family in `xfontsel`.

Manually, in Windows:

* Copy the files from the `ttf/` folder into your Windows Fonts folder.

Manually, in macOS:

* Drag & drop the files from the `ttf/` folder into your Font Book app.

### Linux VT integration

1. Switch to a Linux VT (virtual terminal) by pressing Control-Alt-F1.

2. Run `showconsolefont` to see how the character map currently looks.

3. Run `setfont ~/.fonts/tamzen-font/psf/TamzenForPowerline10x20.psf`.

4. See how the character map now displays glyphs from the Tamzen font.

5. Try running `setfont` with other Tamzen fonts in the `psf/` folder.

See <https://wiki.archlinux.org/index.php/Fonts#Console_fonts> for details.

### XTerm integration

The following Xresources let you dynamically switch between the various Tamzen
fonts by holding down Control and right-clicking in [the XTerm terminal][3].

    XTerm*font  : -*-tamzen-medium-*-*-*-16-*-*-*-*-*-*-*
    XTerm*font1 : -*-tamzen-medium-*-*-*-9-*-*-*-*-*-*-*
    XTerm*font2 : -*-tamzen-medium-*-*-*-12-*-*-*-*-*-*-*
    XTerm*font3 : -*-tamzen-medium-*-*-*-13-*-*-*-*-*-*-*
    XTerm*font4 : -*-tamzen-medium-*-*-*-15-*-*-*-*-*-*-*
    XTerm*font5 : -*-tamzen-medium-*-*-*-16-*-*-*-*-*-*-*
    XTerm*font6 : -*-tamzen-medium-*-*-*-20-*-*-*-*-*-*-*

    ! Tamzen fonts for use with Powerline
    XTerm*font  : -*-tamzenforpowerline-medium-*-*-*-16-*-*-*-*-*-*-*
    XTerm*font1 : -*-tamzenforpowerline-medium-*-*-*-9-*-*-*-*-*-*-*
    XTerm*font2 : -*-tamzenforpowerline-medium-*-*-*-12-*-*-*-*-*-*-*
    XTerm*font3 : -*-tamzenforpowerline-medium-*-*-*-13-*-*-*-*-*-*-*
    XTerm*font4 : -*-tamzenforpowerline-medium-*-*-*-15-*-*-*-*-*-*-*
    XTerm*font5 : -*-tamzenforpowerline-medium-*-*-*-16-*-*-*-*-*-*-*
    XTerm*font6 : -*-tamzenforpowerline-medium-*-*-*-20-*-*-*-*-*-*-*

Feed the above snippet into the xrdb(1) program and then start a new XTerm to
see its effect.  Afterwards, you can add this snippet to your ~/.Xdefaults or
~/.Xresources files to have these settings be automatically applied by XTerm.

### URxvt integration

The following aliases let you dynamically switch between the various Tamzen
fonts when run inside a shell that is attached to [the URxvt terminal][4].

    alias font="printf '\e]710;%s\007'"

    alias Tamzen-9=Tamzen5x9r
    alias Tamzen5x9r='font -misc-tamzen-medium-r-normal--9-65-100-100-c-50-iso8859-1'
    alias Tamzen5x9b='font -misc-tamzen-bold-r-normal--9-65-100-100-c-50-iso8859-1'

    alias Tamzen-12=Tamzen6x12r
    alias Tamzen6x12r='font -misc-tamzen-medium-r-normal--12-87-100-100-c-60-iso8859-1'
    alias Tamzen6x12b='font -misc-tamzen-bold-r-normal--12-87-100-100-c-60-iso8859-1'

    alias Tamzen-13=Tamzen7x13r
    alias Tamzen7x13r='font -misc-tamzen-medium-r-normal--13-101-100-100-c-70-iso8859-1'
    alias Tamzen7x13b='font -misc-tamzen-bold-r-normal--13-101-100-100-c-70-iso8859-1'

    alias Tamzen-14=Tamzen7x14r
    alias Tamzen7x14r='font -misc-tamzen-medium-r-normal--14-101-100-100-c-70-iso8859-1'
    alias Tamzen7x14b='font -misc-tamzen-bold-r-normal--14-101-100-100-c-70-iso8859-1'

    alias Tamzen-15=Tamzen8x15r
    alias Tamzen8x15r='font -misc-tamzen-medium-r-normal--15-108-100-100-c-80-iso8859-1'
    alias Tamzen8x15b='font -misc-tamzen-bold-r-normal--15-108-100-100-c-80-iso8859-1'

    alias Tamzen-16=Tamzen8x16r
    alias Tamzen8x16r='font -misc-tamzen-medium-r-normal--16-108-100-100-c-80-iso8859-1'
    alias Tamzen8x16b='font -misc-tamzen-bold-r-normal--16-108-100-100-c-80-iso8859-1'

    alias Tamzen-20=Tamzen10x20r
    alias Tamzen10x20r='font -misc-tamzen-medium-r-normal--20-145-100-100-c-100-iso8859-1'
    alias Tamzen10x20b='font -misc-tamzen-bold-r-normal--20-145-100-100-c-100-iso8859-1'

    # Tamzen fonts for use with Powerline
    alias TamzenForPowerline-9=TamzenForPowerline5x9r
    alias TamzenForPowerline5x9r='font -misc-tamzenforpowerline-medium-r-normal--9-65-100-100-c-50-iso10646-1'
    alias TamzenForPowerline5x9b='font -misc-tamzenforpowerline-bold-r-normal--9-65-100-100-c-50-iso10646-1'

    alias TamzenForPowerline-12=TamzenForPowerline6x12r
    alias TamzenForPowerline6x12r='font -misc-tamzenforpowerline-medium-r-normal--12-87-100-100-c-60-iso10646-1'
    alias TamzenForPowerline6x12b='font -misc-tamzenforpowerline-bold-r-normal--12-87-100-100-c-60-iso10646-1'

    alias TamzenForPowerline-13=TamzenForPowerline7x13r
    alias TamzenForPowerline7x13r='font -misc-tamzenforpowerline-medium-r-normal--13-101-100-100-c-70-iso10646-1'
    alias TamzenForPowerline7x13b='font -misc-tamzenforpowerline-bold-r-normal--13-101-100-100-c-70-iso10646-1'

    alias TamzenForPowerline-14=TamzenForPowerline7x14r
    alias TamzenForPowerline7x14r='font -misc-tamzenforpowerline-medium-r-normal--14-101-100-100-c-70-iso10646-1'
    alias TamzenForPowerline7x14b='font -misc-tamzenforpowerline-bold-r-normal--14-101-100-100-c-70-iso10646-1'

    alias TamzenForPowerline-15=TamzenForPowerline8x15r
    alias TamzenForPowerline8x15r='font -misc-tamzenforpowerline-medium-r-normal--15-108-100-100-c-80-iso10646-1'
    alias TamzenForPowerline8x15b='font -misc-tamzenforpowerline-bold-r-normal--15-108-100-100-c-80-iso10646-1'

    alias TamzenForPowerline-16=TamzenForPowerline8x16r
    alias TamzenForPowerline8x16r='font -misc-tamzenforpowerline-medium-r-normal--16-108-100-100-c-80-iso10646-1'
    alias TamzenForPowerline8x16b='font -misc-tamzenforpowerline-bold-r-normal--16-108-100-100-c-80-iso10646-1'

    alias TamzenForPowerline-20=TamzenForPowerline10x20r
    alias TamzenForPowerline10x20r='font -misc-tamzenforpowerline-medium-r-normal--20-145-100-100-c-100-iso10646-1'
    alias TamzenForPowerline10x20b='font -misc-tamzenforpowerline-bold-r-normal--20-145-100-100-c-100-iso10646-1'

Building
--------

You can build the Tamzen fonts for yourself by running these commands:

    bundle exec rake                 # build things only when necessary
    bundle exec rake clobber         # destroy everything that we built
    bundle exec rake clobber default # rebuild everything from scratch

### Requirements

    sudo apt-get install ruby git imagemagick mercurial bdftopcf bdf2psf fonttosfnt default-jre
    gem install bundler
    bundle install

Requirements for [bitmap-font-patcher][6]:

    sudo apt-get install python python-fontforge python-pip python-dev libfreetype6-dev
    pip install --user bdflib
    pip install --user Pillow

License
-------

[Spare A Life]: https://sunaku.github.io/vegan-for-life.html
> Like my work? 👍 Please [spare a life] today as thanks! 🐄🐖🐑🐔🐣🐟✨🙊✌  
> Why? For 💕 ethics, the 🌎 environment, and 💪 health; see link above. 🙇

Copyright 2011 Suraj N. Kurapati <https://github.com/sunaku>

Copyright 2010 Scott Fial <http://www.fial.com/~scott/>

Distributed under the same terms as the Tamsyn font.  See `LICENSE` file.

[1]: https://sunaku.github.io/tamsyn-1.7b-font-review.html
[2]: http://www.fial.com/~scott/tamsyn-font/
[3]: http://invisible-island.net/xterm/
[4]: http://software.schmorp.de/pkg/rxvt-unicode.html
[5]: https://powerline.readthedocs.org/en/master/overview.html#screenshots
[6]: https://bitbucket.org/ZyX_I/bitmap-font-patcher
