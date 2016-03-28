var tinycolor = require('tinycolor2');

Elm.Native.TinyColor = {};
Elm.Native.TinyColor.make = function(localRuntime) {
  localRuntime.Native = localRuntime.Native || {};
  localRuntime.Native.TinyColor = localRuntime.Native.TinyColor || {};

  if (localRuntime.Native.TinyColor.values) {
    return localRuntime.Native.TinyColor.values;
  }

  var List = Elm.Native.List.make(localRuntime);

  function clone(color) {
    return tinycolor(color.toHexString());
  }

  function isLightW3C(color) {
    var ratio = ((color._r * 299 + color._g * 587 + color._b * 117) / 1000) / 255;
    var threshold = 0.7;

    return ratio > threshold;
  }

  function fromRGB(object) {
    return tinycolor(object);
  }

  function darken(percent, color) {
    return clone(color).darken(percent);
  }

  function lighten(percent, color) {
    return clone(color).lighten(percent);
  }

  function brighten(percent, color) {
    return clone(color).brighten(percent);
  }

  function saturate(percent, color) {
    return clone(color).saturate(percent);
  }

  function desaturate(percent, color) {
    return clone(color).desaturate(percent);
  }

  function greyscale(color) {
    return clone(color).greyscale();
  }

  function spin(degrees, color) {
    return clone(color).spin(degrees);
  }

  function updateRgb(color, attr, value) {
    var newRGB = clone(color).toRgb();
    newRGB[attr] = value;
    return tinycolor(newRGB);
  }

  function updateRed(color, value) {
    return updateRgb(clone(color), "r", value);
  }

  function updateGreen(color, value) {
    return updateRgb(clone(color), "g", value);
  }

  function updateBlue(color, value) {
    return updateRgb(clone(color), "b", value);
  }

  function updateBrightness(color, value) {
    var newHSL = clone(color).toHsl();
    newHSL.l = value/100;
    return tinycolor(newHSL);
  }

  function toHexString(c) {
    return c.toHexString();
  }

  function toHex(c) {
    return c.toHex();
  }

  function complement(color) {
    return clone(color).complement();
  }

  function jsArrayToList(array) {
    var list = List.Nil;

    array.forEach(function(i) {
      list = List.Cons(i, list);
    });

    return list;
  }

  function triad(c) {
    return jsArrayToList(c.triad());
  }

  function tetrad(c) {
    return jsArrayToList(c.tetrad());
  }

  function splitComplement(c) {
    return jsArrayToList(c.splitcomplement());
  }

  function analogous(c) {
    return jsArrayToList(c.analogous());
  }

  function monochromatic(c) {
    return jsArrayToList(c.monochromatic());
  }

  return localRuntime.Native.TinyColor.values = {
    fromString: tinycolor,
    fromRGB: fromRGB,

    darken: F2(darken),
    lighten: F2(lighten),
    brighten: F2(brighten),
    saturate: F2(saturate),
    desaturate: F2(desaturate),
    spin: F2(spin),
    updateRed: F2(updateRed),
    updateGreen: F2(updateGreen),
    updateBlue: F2(updateBlue),
    updateBrightness: F2(updateBrightness),
    greyscale: greyscale,

    toHexString: toHexString,
    toHex: toHex,
    isLightW3C: isLightW3C,
    equals: F2(tinycolor.equals),

    complement: complement,
    triad: triad,
    tetrad: tetrad,
    splitComplement: splitComplement,
    analogous: analogous,
    monochromatic: monochromatic,
  };
};
