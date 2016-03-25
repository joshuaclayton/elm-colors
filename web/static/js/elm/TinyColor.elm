module TinyColor (..) where

import Native.TinyColor
import Random


type TinyColor
  = TinyColor


random : Random.Seed -> ( TinyColor, Random.Seed )
random seed =
  Random.generate randomTinyColor seed


randomList : Int -> Random.Seed -> ( List TinyColor, Random.Seed )
randomList count seed =
  Random.generate (Random.list count randomTinyColor) seed


randomTinyColor : Random.Generator TinyColor
randomTinyColor =
  let
    colorRange =
      Random.int 0 255

    randomRGB =
      Random.map3 (,,) colorRange colorRange colorRange

    randomTinyColor ( r, g, b ) =
      fromRGB { r = r, g = g, b = b }
  in
    Random.map randomTinyColor randomRGB


normalizeHex : String -> String
normalizeHex =
  (fromString >> toHex)


normalizeHexString : String -> String
normalizeHexString =
  (fromString >> toHexString)


fromString : String -> TinyColor
fromString =
  Native.TinyColor.fromString


fromRGB : { a | r : Int, g : Int, b : Int } -> TinyColor
fromRGB =
  Native.TinyColor.fromRGB


isLightW3C : TinyColor -> Bool
isLightW3C =
  Native.TinyColor.isLightW3C


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


toHex : TinyColor -> String
toHex =
  Native.TinyColor.toHex
