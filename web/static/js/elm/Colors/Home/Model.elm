module Colors.Home.Model (..) where


type alias Model =
  { searchColor : Maybe String }


initialModel : Model
initialModel =
  { searchColor = Nothing }
