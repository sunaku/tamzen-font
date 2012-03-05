Tamzen font
===========

This is [my personal fork][1] of the wonderful [Tamsyn font][2] by Scott Fial.
It is programatically forked from Tamsyn version 1.8 by the `Tamzen.rb` script
(needs `gem install grit` library) and diverges from it in the following ways:

* Medium "g" is backported from Tamsyn 1.6.
* Medium "h" is backported from Tamsyn 1.6.
* Medium "m" is backported from Tamsyn 1.6.
* Bold and medium "l" are backported from Tamsyn 1.6.
* Bold and medium "w" are backported from Tamsyn 1.6.
* Bold and medium "y" are backported from Tamsyn 1.6.
* Deliberately empty glyphs are deleted (marked as unimplemented) so that they
  do not block secondary fonts from supplying real glyphs at those codepoints.

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

Installation
------------

Copy the `Tamzen*.bdf` files into your `~/.fonts` directory and run:

    mkfontdir ~/.fonts
    xset +fp ~/.fonts
    xset fp rehash

Now you should be able to access the "Tamzen" font family in xfontsel.

License
-------

Distributed under the same terms as Tamsyn itself.  See `LICENSE` file.

[1]: http://snk.tuxfamily.org/log/tamsyn-1.7b-review.html
[2]: http://www.fial.com/~scott/tamsyn-font/
