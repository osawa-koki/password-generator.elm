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
  String


init : Model
init =
  ""



-- UPDATE


type Msg
  = ToggleText


update : Msg -> Model -> Model
update msg model =
  case msg of
    ToggleText ->
      if model == "" then
        "Hello World!"

      else
        ""



-- VIEW


view : Model -> Html Msg
view model =
  main_ []
    [
      div [ class "a" ]
      [
        table []
        [
          tr [] -- 使用する文字の列
          [
            th []
            [ text "使用する文字" ],
            td []
            [
              button [ onClick ToggleText ] [ text "Toggle" ]
            ]
          ],
          tr [] -- 文字数の列
          [
            th []
            [ text "文字数" ],
            td []
            [
              button [ onClick ToggleText ] [ text "Toggle" ]
            ]
          ]
        ]
      ],
      div [ class "a" ]
      [ button [ onClick ToggleText ] [ text "Toggle" ]
      , button [ onClick ToggleText ] [ text "Toggle Text" ]
      , div [ class "text" ] [ text model ]
      ]
    ]
