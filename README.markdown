Tamzen font
===========

[![screenshot](http://omploader.org/tYzBqcQ)](http://omploader.org/vYzBqcQ)

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
