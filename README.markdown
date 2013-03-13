Tamzen font
===========

This is [my personal fork][1] of the wonderful [Tamsyn font][2] by Scott Fial.
It is programatically forked from Tamsyn version 1.9 by the `Tamzen.rb` script
(needs `gem install grit` library) and diverges from it in the following ways:

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
* Bold and medium "g" is manually derived from Tamsyn 1.6.

Screenshots
-----------

[![Vim and Urxvt](http://omploader.org/tYzBqcQ)](http://omploader.org/vYzBqcQ)
![Tamzen6x11b.bdf](https://github.com/sunaku/tamzen-font/raw/master/Tamzen6x11b.png)
![Tamzen6x11r.bdf](https://github.com/sunaku/tamzen-font/raw/master/Tamzen6x11r.png)
![Tamzen7x12b.bdf](https://github.com/sunaku/tamzen-font/raw/master/Tamzen7x12b.png)
![Tamzen7x12r.bdf](https://github.com/sunaku/tamzen-font/raw/master/Tamzen7x12r.png)
![Tamzen7x14b.bdf](https://github.com/sunaku/tamzen-font/raw/master/Tamzen7x14b.png)
![Tamzen7x14r.bdf](https://github.com/sunaku/tamzen-font/raw/master/Tamzen7x14r.png)
![Tamzen8x15b.bdf](https://github.com/sunaku/tamzen-font/raw/master/Tamzen8x15b.png)
![Tamzen8x15r.bdf](https://github.com/sunaku/tamzen-font/raw/master/Tamzen8x15r.png)
![Tamzen8x17b.bdf](https://github.com/sunaku/tamzen-font/raw/master/Tamzen8x17b.png)
![Tamzen8x17r.bdf](https://github.com/sunaku/tamzen-font/raw/master/Tamzen8x17r.png)
![Tamzen10x20b.bdf](https://github.com/sunaku/tamzen-font/raw/master/Tamzen10x20b.png)
![Tamzen10x20r.bdf](https://github.com/sunaku/tamzen-font/raw/master/Tamzen10x20r.png)

Installation
------------

Copy the `Tamzen*.bdf` files into your `~/.fonts` directory and run:

    mkfontdir ~/.fonts
    xset +fp ~/.fonts
    xset fp rehash

Now you should be able to access the "Tamzen" font family in xfontsel.

### URxvt integration

The following aliases let you dynamically switch between the various Tamzen
fonts when run inside a shell that is attached to [the URxvt terminal][3].

```sh
function urxvt-change-font() { printf '\e]710;%s\007' "$@"; }
alias Tamzen5x9b='urxvt-change-font -misc-tamzen-bold-r-normal--9-65-100-100-c-50-iso8859-1'
alias Tamzen5x9r='urxvt-change-font -misc-tamzen-medium-r-normal--9-65-100-100-c-50-iso8859-1'
alias Tamzen-9='urxvt-change-font -misc-tamzen-medium-r-normal--9-65-100-100-c-50-iso8859-1'
alias Tamzen6x11b='urxvt-change-font -misc-tamzen-bold-r-normal--11-79-100-100-c-60-iso8859-1'
alias Tamzen6x11r='urxvt-change-font -misc-tamzen-medium-r-normal--11-79-100-100-c-60-iso8859-1'
alias Tamzen-11='urxvt-change-font -misc-tamzen-medium-r-normal--11-79-100-100-c-60-iso8859-1'
alias Tamzen6x12b='urxvt-change-font -misc-tamzen-bold-r-normal--12-87-100-100-c-60-iso8859-1'
alias Tamzen6x12r='urxvt-change-font -misc-tamzen-medium-r-normal--12-87-100-100-c-60-iso8859-1'
alias Tamzen-12='urxvt-change-font -misc-tamzen-medium-r-normal--12-87-100-100-c-60-iso8859-1'
alias Tamzen7x12b='urxvt-change-font -misc-tamzen-bold-r-normal--12-87-100-100-c-70-iso8859-1'
alias Tamzen7x12r='urxvt-change-font -misc-tamzen-medium-r-normal--12-87-100-100-c-70-iso8859-1'
alias Tamzen-13='urxvt-change-font -misc-tamzen-medium-r-normal--12-87-100-100-c-70-iso8859-1'
alias Tamzen7x14b='urxvt-change-font -misc-tamzen-bold-r-normal--14-101-100-100-c-70-iso8859-1'
alias Tamzen7x14r='urxvt-change-font -misc-tamzen-medium-r-normal--14-101-100-100-c-70-iso8859-1'
alias Tamzen-14='urxvt-change-font -misc-tamzen-medium-r-normal--14-101-100-100-c-70-iso8859-1'
alias Tamzen8x15b='urxvt-change-font -misc-tamzen-bold-r-normal--15-108-100-100-c-80-iso8859-1'
alias Tamzen8x15r='urxvt-change-font -misc-tamzen-medium-r-normal--15-108-100-100-c-80-iso8859-1'
alias Tamzen-15='urxvt-change-font -misc-tamzen-medium-r-normal--15-108-100-100-c-80-iso8859-1'
alias Tamzen8x17b='urxvt-change-font -misc-tamzen-bold-r-normal--17-123-100-100-c-80-iso8859-1'
alias Tamzen8x17r='urxvt-change-font -misc-tamzen-medium-r-normal--17-123-100-100-c-80-iso8859-1'
alias Tamzen-17='urxvt-change-font -misc-tamzen-medium-r-normal--17-123-100-100-c-80-iso8859-1'
alias Tamzen10x20b='urxvt-change-font -misc-tamzen-bold-r-normal--20-145-100-100-c-100-iso8859-1'
alias Tamzen10x20r='urxvt-change-font -misc-tamzen-medium-r-normal--20-145-100-100-c-100-iso8859-1'
alias Tamzen-20='urxvt-change-font -misc-tamzen-medium-r-normal--20-145-100-100-c-100-iso8859-1'
```

License
-------

Distributed under the same terms as Tamsyn itself.  See `LICENSE` file.

[1]: http://snk.tuxfamily.org/log/tamsyn-1.7b-review.html
[2]: http://www.fial.com/~scott/tamsyn-font/
[3]: http://software.schmorp.de/pkg/rxvt-unicode.html
