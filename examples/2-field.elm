import Html exposing (..)
import Html.App as Html
import Html.Attributes exposing (..)
import Html.Events exposing (onInput, onCheck)
import String



main =
  Html.beginnerProgram
    { model = model
    , view = view
    , update = update
    }



-- MODEL


type alias Model =
  { content : String
    , state: Bool
  }


model : Model
model =
  { content = ""
  , state = True}



-- UPDATE


type Msg
  = Change String
  | FlipState Bool

update : Msg -> Model -> Model
update msg model =
  case msg of
    Change newContent ->
      { model | content = newContent }

    FlipState newState ->
      { model | state = newState }



-- VIEW


view : Model -> Html Msg
view model =
  div []
    [
    input [ placeholder "Text to reverse", onInput Change ] []
    , div [] [ text (String.reverse model.content) ]
    , div [] [ text (model.content) ]
    ]