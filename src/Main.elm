module Main exposing (..)

import Browser
import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing (..)
import Random


main : Program () Model Msg
main =
  Browser.sandbox { init = init, update = update, view = view }



-- MODEL


type alias CharRecord =
  { description: String
  , content: String
  , ison: Bool
  }


type alias Model =
  { passwordlength : Int
  , numeric : Bool
  , alphemeric : Bool
  , symbol : Bool
  , symbolset : List CharRecord
  }


init : Model
init =
  { passwordlength = 8
  , numeric = True
  , alphemeric = True
  , symbol = True
  , symbolset = [
    { description = "Ampersand", content = "&", ison = True }
    , { description = "Apostrophe", content = "'", ison = True }
    , { description = "At", content = "@", ison = True }
    , { description = "Backslash", content = "\\", ison = True }
    , { description = "Backtick", content = "`", ison = True }
    , { description = "Bar", content = "|", ison = True }
    , { description = "Caret", content = "^", ison = True }
    , { description = "Colon", content = ":", ison = True }
    , { description = "Comma", content = ",", ison = True }
    , { description = "Dollar", content = "$", ison = True }
    , { description = "Double Quote", content = "\"", ison = True }
    , { description = "Equal", content = "=", ison = True }
    , { description = "Exclamation", content = "!", ison = True }
    , { description = "Greater Than", content = ">", ison = True }
    , { description = "Hash", content = "#", ison = True }
    , { description = "Left Brace", content = "{", ison = True }
    , { description = "Left Bracket", content = "[", ison = True }
    , { description = "Left Parenthesis", content = "(", ison = True }
    , { description = "Less Than", content = "<", ison = True }
    , { description = "Minus", content = "-", ison = True }
    , { description = "Percent", content = "%", ison = True }
    , { description = "Period", content = ".", ison = True }
    , { description = "Plus", content = "+", ison = True }
    , { description = "Question", content = "?", ison = True }
    , { description = "Right Brace", content = "}", ison = True }
    , { description = "Right Bracket", content = "]", ison = True }
    , { description = "Right Parenthesis", content = ")", ison = True }
    , { description = "Semicolon", content = ";", ison = True }
    , { description = "Slash", content = "/", ison = True }
    , { description = "Space", content = " ", ison = True }
    , { description = "Tilde", content = "~", ison = True }
  ]
  }



-- UPDATE


type Msg
  = PasswordLengthChange String
  | NumericChange Bool
  | AlphemericChange Bool
  | SymbolChange Bool


update : Msg -> Model -> Model
update msg model =
  case msg of
    PasswordLengthChange a ->
      { model | passwordlength = numDefault <| String.toInt a }
    AlphemericChange a ->
      { model | alphemeric = a }
    NumericChange a ->
      { model | numeric = a }
    SymbolChange a ->
      { model | symbol = a }


type alias CharCount =
  { numeric : Int
  , alphemeric : Int
  , symbol : Int
  }

charCount : CharCount
charCount =
  { numeric = 10
  , alphemeric = 52
  , symbol = 0
  }


createRandomString : Int -> Model -> String
createRandomString length model =
  let
    randomString = String.fromInt model.passwordlength
  in
    randomString



numDefault : Maybe Int -> Int
numDefault maybezero =
  case maybezero of
    Just num -> num
    Nothing -> 8



-- VIEW


view : Model -> Html Msg
view model =
  main_ []
    [
      div [ class "settingContainer" ]
      [
        table []
        [
          tr [] -- 使用する文字の列
          [
            th []
            [ text "使用する文字" ],
            td []
            [
              label [] [
                input [ type_ "checkbox", checked model.numeric, onCheck NumericChange ] [],
                span [] [ text "数字" ]
              ],
              label [] [
                input [ type_ "checkbox", checked model.alphemeric, onCheck AlphemericChange ] [],
                span [] [ text "英字" ]
              ],
              label [] [
                input [ type_ "checkbox", checked model.symbol, onCheck SymbolChange ] [],
                span [] [ text "記号" ]
              ]
            ]
          ],
          tr [ class (if model.symbol then "on" else "off") ] -- 使用するシンボル
          [
            th []
            [ text "使用する記号" ],
            td []
            [
              div [] []
            ]
          ],
          tr [] -- 文字数の列
          [
            th []
            [ text "文字数" ],
            td []
            [
              input [ type_ "range", Html.Attributes.min "8", Html.Attributes.max "32", step "1", value (String.fromInt(model.passwordlength)), onInput PasswordLengthChange ] [],
              span [] [ text (String.fromInt(model.passwordlength)) ]
            ]
          ]
        ]
      ],
      div [ class "resultContainer" ]
      [ button [ ] [ text "Toggle" ]
      , button [ ] [ text "Toggle Text" ]
      , div [ class "text" ] [ text "model" ]
      ]
    ]

viewInput : String -> String -> String -> (String -> msg) -> Html msg
viewInput t p v toMsg =
  input [ type_ t, placeholder p, value v, onInput toMsg ] []

