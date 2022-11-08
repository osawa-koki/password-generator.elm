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
  , input : String
  }


init : Model
init =
  { passwordlength = 8
  , input = ""
  }



-- UPDATE


type Msg
  = PasswordLengthIncrement
  | PasswordLengthDecrement
  | PasswordLengthChange
  | Password String


update : Msg -> Model -> Model
update msg model =
  case msg of
    PasswordLengthIncrement ->
      { model | passwordlength = model.passwordlength + 1 }
    PasswordLengthDecrement ->
      { model | passwordlength = model.passwordlength - 1 }
    PasswordLengthChange ->
      { model | passwordlength = model.passwordlength + 1 }
    Password input ->
      { model | input = input }



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
                input [ type_ "checkbox", value "checked" ] [],
                span [] [ text "数字" ]
              ],
              label [] [
                input [ type_ "checkbox", value "checked" ] [],
                span [] [ text "英字" ]
              ],
              label [] [
                input [ type_ "checkbox", value "checked" ] [],
                span [] [ text "記号" ]
              ]
            ]
          ],
          -- tr [] -- 文字数の列
          -- [
          --   th []
          --   [ text "文字数" ],
          --   td []
          --   [
          --     button [ onClick PasswordLengthDecrement ] [ text "-" ],
          --     span [] [ text (String.fromInt(model.passwordlength)) ],
          --     button [ onClick PasswordLengthIncrement ] [ text "+" ]
          --   ]
          -- ]
          tr [] -- 文字数の列
          [
            th []
            [ text "文字数" ],
            td []
            [
              input [ type_ "range", Html.Attributes.min "8", Html.Attributes.max "32", step "1", value (String.fromInt(model.passwordlength)) ] [],
              span [] [ text (String.fromInt(model.passwordlength)) ]
            ]
          ]
        ]
      ],
      div [ class "resultContainer" ]
      [ button [ onClick PasswordLengthDecrement ] [ text "Toggle" ]
      , button [ onClick PasswordLengthDecrement ] [ text "Toggle Text" ]
      , div [ class "text" ] [ text "model" ]
      ]
    ]

viewInput : String -> String -> String -> (String -> msg) -> Html msg
viewInput t p v toMsg =
  input [ type_ t, placeholder p, value v, onInput toMsg ] []

