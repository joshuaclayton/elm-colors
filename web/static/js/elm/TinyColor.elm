module TinyColor (TinyColor, RGBSpectrum, random, randomList, normalizeHex, normalizeHexString, fromString, isLightW3C, equals, darken, lighten, brighten, saturate, desaturate, spin, greyscale, complement, splitComplement, triad, tetrad, analogous, monochromatic, wheel, rgbSpectrum, toHexString, toHex) where

import Native.TinyColor
import Random
import Dict


type TinyColor
  = TinyColor


type alias RGBSpectrum =
  { base : TinyColor
  , reds : List TinyColor
  , greens : List TinyColor
  , blues : List TinyColor
  , brightness : List TinyColor
  }


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


equals : TinyColor -> TinyColor -> Bool
equals =
  Native.TinyColor.equals


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


spin : Float -> TinyColor -> TinyColor
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


rgbSpectrum : TinyColor -> RGBSpectrum
rgbSpectrum color =
  { base = color
  , reds = allReds color
  , greens = allGreens color
  , blues = allBlues color
  , brightness = allBrightnesses color
  }


allReds : TinyColor -> List TinyColor
allReds color =
  uniqBy toHex <| List.map (updateRed color) <| listWithStep 0 255 1


allGreens : TinyColor -> List TinyColor
allGreens color =
  uniqBy toHex <| List.map (updateGreen color) <| listWithStep 0 255 1


allBlues : TinyColor -> List TinyColor
allBlues color =
  uniqBy toHex <| List.map (updateBlue color) <| listWithStep 0 255 1


allBrightnesses : TinyColor -> List TinyColor
allBrightnesses color =
  uniqBy toHex <| List.map (updateBrightness color) <| listWithStep 0 100 5.0e-2


updateRed : TinyColor -> Float -> TinyColor
updateRed =
  Native.TinyColor.updateRed


updateGreen : TinyColor -> Float -> TinyColor
updateGreen =
  Native.TinyColor.updateGreen


updateBlue : TinyColor -> Float -> TinyColor
updateBlue =
  Native.TinyColor.updateBlue


updateBrightness : TinyColor -> Float -> TinyColor
updateBrightness =
  Native.TinyColor.updateBrightness


listWithStep : Float -> Float -> Float -> List Float
listWithStep start end step =
  let
    listWithStep' xs c m s =
      if c + s > m then
        xs
      else
        listWithStep' (xs ++ [ c + s ]) (c + s) m s
  in
    listWithStep' [ start ] start end step


wheel : Float -> TinyColor -> List TinyColor
wheel numberOfColors color =
  let
    incrementalDegrees =
      360 / numberOfColors

    degrees =
      listWithStep 0 360 incrementalDegrees
  in
    List.map (flip spin <| color) degrees


toHexString : TinyColor -> String
toHexString =
  Native.TinyColor.toHexString


toHex : TinyColor -> String
toHex =
  Native.TinyColor.toHex


uniqBy : (a -> comparable) -> List a -> List a
uniqBy fn xs =
  (Dict.values << Dict.fromList) <| List.map (\x -> ( fn x, x )) xs
