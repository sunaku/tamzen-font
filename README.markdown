Tamzen font
===========

This is [my personal fork][1] of the wonderful [Tamsyn font][2] by Scott Fial.
It is programatically forked from Tamsyn version 1.9 by the `Tamzen.rb` script
(needs `gem install git` library) and diverges from it in the following ways:

* Medium "g" is backported from Tamsyn 1.6.
* Medium "h" is backported from Tamsyn 1.6.
* Medium "m" is backported from Tamsyn 1.6.
* Bold and medium "l" are backported from Tamsyn 1.6.
* Bold and medium "w" are backported from Tamsyn 1.6.
* Bold and medium "y" are backported from Tamsyn 1.6.
* Deliberately empty glyphs are deleted (marked as unimplemented) so that they
  do not block secondary fonts from supplying real glyphs at those codepoints.

For the new 10x20 size introduced in Tamsyn 1.9:
* Medium "U" is manually derived from Tamsyn 1.6.
* Bold and medium "g" are manually derived from Tamsyn 1.6.

Screenshots
-----------

### Tamzen-9
![Tamzen5x9r.bdf](https://github.com/sunaku/tamzen-font/raw/master/Tamzen5x9r.png)
![Tamzen5x9b.bdf](https://github.com/sunaku/tamzen-font/raw/master/Tamzen5x9b.png)

### Tamzen-11
![Tamzen6x11r.bdf](https://github.com/sunaku/tamzen-font/raw/master/Tamzen6x11r.png)
![Tamzen6x11b.bdf](https://github.com/sunaku/tamzen-font/raw/master/Tamzen6x11b.png)

### Tamzen-12
![Tamzen6x12r.bdf](https://github.com/sunaku/tamzen-font/raw/master/Tamzen6x12r.png)
![Tamzen6x12b.bdf](https://github.com/sunaku/tamzen-font/raw/master/Tamzen6x12b.png)

### Tamzen-13
![Tamzen7x12r.bdf](https://github.com/sunaku/tamzen-font/raw/master/Tamzen7x12r.png)
![Tamzen7x12b.bdf](https://github.com/sunaku/tamzen-font/raw/master/Tamzen7x12b.png)

### Tamzen-14
![Tamzen7x14r.bdf](https://github.com/sunaku/tamzen-font/raw/master/Tamzen7x14r.png)
![Tamzen7x14b.bdf](https://github.com/sunaku/tamzen-font/raw/master/Tamzen7x14b.png)

### Tamzen-15
![Tamzen8x15r.bdf](https://github.com/sunaku/tamzen-font/raw/master/Tamzen8x15r.png)
![Tamzen8x15b.bdf](https://github.com/sunaku/tamzen-font/raw/master/Tamzen8x15b.png)

### Tamzen-17
![Tamzen8x17r.bdf](https://github.com/sunaku/tamzen-font/raw/master/Tamzen8x17r.png)
![Tamzen8x17b.bdf](https://github.com/sunaku/tamzen-font/raw/master/Tamzen8x17b.png)

### Tamzen-20
![Tamzen10x20r.bdf](https://github.com/sunaku/tamzen-font/raw/master/Tamzen10x20r.png)
![Tamzen10x20b.bdf](https://github.com/sunaku/tamzen-font/raw/master/Tamzen10x20b.png)

Installation
------------

Copy the `Tamzen*.bdf` files into your `~/.fonts` directory and run:

    mkfontdir ~/.fonts
    xset +fp ~/.fonts
    xset fp rehash

Now you should be able to access the "Tamzen" font family in xfontsel.

### XTerm integration

The following Xresources let you dynamically switch between the various Tamzen
fonts by holding down Control and right-clicking in [the XTerm terminal][3].

    XTerm*font  : -*-tamzen-medium-*-*-*-15-*-*-*-*-*-*-*
    XTerm*font1 : -*-tamzen-medium-*-*-*-11-*-*-*-*-*-*-*
    XTerm*font2 : -*-tamzen-medium-*-*-*-12-*-*-*-*-*-*-*
    XTerm*font3 : -*-tamzen-medium-*-*-*-14-*-*-*-*-*-*-*
    XTerm*font4 : -*-tamzen-medium-*-*-*-15-*-*-*-*-*-*-*
    XTerm*font5 : -*-tamzen-medium-*-*-*-17-*-*-*-*-*-*-*
    XTerm*font6 : -*-tamzen-medium-*-*-*-20-*-*-*-*-*-*-*

Feed the above snippet into the xrdb(1) program and then start a new XTerm to
see its effect.  Afterwards, you can add this snippet to your ~/.Xdefaults or
~/.Xresources files to have these settings be automatically applied by XTerm.

### URxvt integration

The following aliases let you dynamically switch between the various Tamzen
fonts when run inside a shell that is attached to [the URxvt terminal][3].

```sh
alias font="printf '\e]710;%s\007'"

alias Tamzen-9=Tamzen5x9r
alias Tamzen5x9r='font -misc-tamzen-medium-r-normal--9-65-100-100-c-50-iso8859-1'
alias Tamzen5x9b='font -misc-tamzen-bold-r-normal--9-65-100-100-c-50-iso8859-1'

alias Tamzen-11=Tamzen6x11r
alias Tamzen6x11r='font -misc-tamzen-medium-r-normal--11-79-100-100-c-60-iso8859-1'
alias Tamzen6x11b='font -misc-tamzen-bold-r-normal--11-79-100-100-c-60-iso8859-1'

alias Tamzen-12=Tamzen6x12r
alias Tamzen6x12r='font -misc-tamzen-medium-r-normal--12-87-100-100-c-60-iso8859-1'
alias Tamzen6x12b='font -misc-tamzen-bold-r-normal--12-87-100-100-c-60-iso8859-1'

alias Tamzen-13=Tamzen7x12r
alias Tamzen7x12r='font -misc-tamzen-medium-r-normal--12-87-100-100-c-70-iso8859-1'
alias Tamzen7x12b='font -misc-tamzen-bold-r-normal--12-87-100-100-c-70-iso8859-1'

alias Tamzen-14=Tamzen7x14r
alias Tamzen7x14r='font -misc-tamzen-medium-r-normal--14-101-100-100-c-70-iso8859-1'
alias Tamzen7x14b='font -misc-tamzen-bold-r-normal--14-101-100-100-c-70-iso8859-1'

alias Tamzen-15=Tamzen8x15r
alias Tamzen8x15r='font -misc-tamzen-medium-r-normal--15-108-100-100-c-80-iso8859-1'
alias Tamzen8x15b='font -misc-tamzen-bold-r-normal--15-108-100-100-c-80-iso8859-1'

alias Tamzen-17=Tamzen8x17r
alias Tamzen8x17r='font -misc-tamzen-medium-r-normal--17-123-100-100-c-80-iso8859-1'
alias Tamzen8x17b='font -misc-tamzen-bold-r-normal--17-123-100-100-c-80-iso8859-1'

alias Tamzen-20=Tamzen10x20r
alias Tamzen10x20r='font -misc-tamzen-medium-r-normal--20-145-100-100-c-100-iso8859-1'
alias Tamzen10x20b='font -misc-tamzen-bold-r-normal--20-145-100-100-c-100-iso8859-1'
```

License
-------

Distributed under the same terms as the Tamsyn font.  See `LICENSE` file.

[1]: http://snk.tuxfamily.org/log/tamsyn-1.7b-review.html
[2]: http://www.fial.com/~scott/tamsyn-font/
[3]: http://software.schmorp.de/pkg/rxvt-unicode.html
[4]: http://invisible-island.net/xterm/
