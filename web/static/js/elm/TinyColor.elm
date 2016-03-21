module TinyColor (..) where

import Native.TinyColor


type TinyColor
  = RGB { r : Int, g : Int, b : Int }
  | HSL { h : Int, s : Int, l : Int }


fromString : String -> TinyColor
fromString =
  Native.TinyColor.fromString


darken : Int -> TinyColor -> TinyColor
darken =
  Native.TinyColor.darken


lighten : Int -> TinyColor -> TinyColor
lighten =
  Native.TinyColor.lighten


brighten : Int -> TinyColor -> TinyColor
brighten =
  Native.TinyColor.brighten


saturate : Int -> TinyColor -> TinyColor
saturate =
  Native.TinyColor.saturate


desaturate : Int -> TinyColor -> TinyColor
desaturate =
  Native.TinyColor.desaturate


spin : Int -> TinyColor -> TinyColor
spin =
  Native.TinyColor.spin


greyscale : TinyColor -> TinyColor
greyscale =
  Native.TinyColor.greyscale


complement : TinyColor -> TinyColor
complement =
  Native.TinyColor.complement


triad : TinyColor -> List TinyColor
triad =
  Native.TinyColor.triad


tetrad : TinyColor -> List TinyColor
tetrad =
  Native.TinyColor.tetrad


splitComplement : TinyColor -> List TinyColor
splitComplement =
  Native.TinyColor.splitComplement


analogous : TinyColor -> List TinyColor
analogous =
  Native.TinyColor.analogous


monochromatic : TinyColor -> List TinyColor
monochromatic =
  Native.TinyColor.monochromatic


toHexString : TinyColor -> String
toHexString =
  Native.TinyColor.toHexString