import Html exposing (..)
import Html.App as Html
import Html.Attributes exposing (..)
import Html.Events exposing (onInput, onClick)
import String exposing (toUpper, toLower, any, toInt)
import Char exposing (isDigit)

main =
  Html.beginnerProgram
    { model = model
    , view = view
    , update = update
    }



-- MODEL


type alias Model =
  { name : String
  , password : String
  , passwordAgain : String
  , age : String
  , submitState : Bool
  }


model : Model
model =
  Model "" "" "" "" False



-- UPDATE


type Msg
    = Name String
    | Password String
    | PasswordAgain String
    | Age String
    | SubmitForm


update : Msg -> Model -> Model
update msg model =
  case msg of
    Name name ->
      { model | name = name, submitState = False }

    Password password ->
      { model | password = password, submitState = False }

    PasswordAgain password ->
      { model | passwordAgain = password, submitState = False }

    Age age ->
      { model | age = age, submitState = False }

    SubmitForm ->
      { model | submitState = True }

-- VIEW

view : Model -> Html Msg
view model =
  div []
    [ input [ type' "text", placeholder "Name", onInput Name ] []
    , input [ type' "password", placeholder "Password", onInput Password ] []
    , input [ type' "password", placeholder "Re-enter Password", onInput PasswordAgain ] []
    , input [ type' "text", placeholder "Age", onInput Age ] []
    , input [ type' "button", value "Submit", onClick SubmitForm ] []
    , viewValidation model
    ]


viewValidation : Model -> Html msg
viewValidation model =
  let
    (color, message) =
      if not model.submitState then
        ("", "")
      else if String.length model.password < 8 then
        ("red", "Password is too short")
      else if model.password /= model.passwordAgain then
        ("red", "Passwords do not match!")
      else if (passwordInvalid model.password) then
        ("red", "Password must contain atleast one uppercase character, one lowercase character and one number")
      else if (ageValid model.age) then
        ("red", "Age must be a number")
      else
        ("green", "OK")
  in
    div [ style [("color", color)] ] [ text message ]

passwordInvalid : String -> Bool
passwordInvalid password =
  (String.toUpper password) == password || (String.toLower password) == password || not (any isDigit password)

ageValid : String -> Bool
ageValid age =
  case toInt age of
    Err msg -> True
    Ok val -> False