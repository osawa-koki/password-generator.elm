module Main exposing (..)

import Browser
import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing (..)


main : Program () Model Msg
main =
  Browser.sandbox { init = init, update = update, view = view }



-- MODEL


type alias Model =
  { passwordlength : Int
  , numeric : Bool
  , alphemeric : Bool
  , symbol : Bool
  }


init : Model
init =
  { passwordlength = 8
  , numeric = True
  , alphemeric = True
  , symbol = True
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

