# japan-util package

Utilities for Japanese.
[![Build Status](https://travis-ci.org/aki77/atom-japan-util.svg?branch=master)](https://travis-ci.org/aki77/atom-japan-util)

![](http://i.gyazo.com/f1d6bb0a1cbfa79e35b9368fc1a893dc.gif)

Inspired by japan-util.el

## Keymap

No keymap by default.

edit `~/.atom/keymap.cson`

## Commands

selected text

```
ＡＢＣabcあいうアイウｱｲｳ123
```

* `japan-util:hiragana`: `ＡＢＣabcあいうあいうあいう123`
* `japan-util:katakana`: `ＡＢＣabcアイウアイウｱｲｳ123`
* `japan-util:katakana-hankaku`: `ＡＢＣabcｱｲｳｱｲｳｱｲｳ123`
* `japan-util:hankaku`: `ABCabcｱｲｳｱｲｳｱｲｳ123`
* `japan-util:hankaku-only-ascii`: `ABCabcあいうアイウｱｲｳ123`
* `japan-util:hankaku-only-katakana`: `ＡＢＣabcあいうｱｲｳｱｲｳ123`
* `japan-util:zenkaku`: `ＡＢＣａｂｃあいうアイウアイウ１２３`
* `japan-util:zenkaku-only-katakana`: `ＡＢＣabcあいうアイウアイウ123`
