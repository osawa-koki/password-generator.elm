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
  { description_en: String
  , description_ja: String
  , content: String
  , ison: Bool
  }


type alias Model =
  { passwordlength : Int
  , numeric : Bool
  , alphemeric : Bool
  , symbol : Bool
  , symbolset : List CharRecord
  , resultlist : List String
  }


init : Model
init =
  { passwordlength = 8
  , numeric = True
  , alphemeric = True
  , symbol = True
  , symbolset = [
    { description_en = "Ampersand", description_ja = "アンド", content = "&", ison = True }
    , { description_en = "Apostrophe", description_ja = "アポストロフィ", content = "'", ison = True }
    , { description_en = "At", description_ja = "アット", content = "@", ison = True }
    , { description_en = "Backslash", description_ja = "バックスラッシュ", content = "\\", ison = True }
    , { description_en = "Backtick", description_ja = "バックティック", content = "`", ison = True }
    , { description_en = "Bar", description_ja = "バー", content = "|", ison = True }
    , { description_en = "Caret", description_ja = "キャレット", content = "^", ison = True }
    , { description_en = "Colon", description_ja = "コロン", content = ":", ison = True }
    , { description_en = "Comma", description_ja = "コンマ", content = ",", ison = True }
    , { description_en = "Dollar", description_ja = "ドル", content = "$", ison = True }
    , { description_en = "Double quote", description_ja = "ダブルクォート", content = "\"", ison = True }
    , { description_en = "Equal", description_ja = "イコール", content = "=", ison = True }
    , { description_en = "Exclamation", description_ja = "エクスクラメーション", content = "!", ison = True }
    , { description_en = "Greater than", description_ja = "グレーター", content = ">", ison = True }
    , { description_en = "Hash", description_ja = "ハッシュ", content = "#", ison = True }
    , { description_en = "Left brace", description_ja = "左ブレース", content = "{", ison = True }
    , { description_en = "Left bracket", description_ja = "左ブラケット", content = "[", ison = True }
    , { description_en = "Left parenthesis", description_ja = "左パランテーシス", content = "(", ison = True }
    , { description_en = "Less than", description_ja = "レス", content = "<", ison = True }
    , { description_en = "Minus", description_ja = "マイナス", content = "-", ison = True }
    , { description_en = "Percent", description_ja = "パーセント", content = "%", ison = True }
    , { description_en = "Period", description_ja = "ピリオド", content = ".", ison = True }
    , { description_en = "Plus", description_ja = "プラス", content = "+", ison = True }
    , { description_en = "Question", description_ja = "クエスチョン", content = "?", ison = True }
    , { description_en = "Right brace", description_ja = "右ブレース", content = "}", ison = True }
    , { description_en = "Right bracket", description_ja = "右ブラケット", content = "]", ison = True }
    , { description_en = "Right parenthesis", description_ja = "右パランテーシス", content = ")", ison = True }
    , { description_en = "Semicolon", description_ja = "セミコロン", content = ";", ison = True }
    , { description_en = "Slash", description_ja = "スラッシュ", content = "/", ison = True }
    , { description_en = "Space", description_ja = "スペース", content = " ", ison = True }
    , { description_en = "Tilde", description_ja = "チルダ", content = "~", ison = True }
  ]
  , resultlist = []
  }



-- UPDATE


type Msg
  = PasswordLengthChange String
  | NumericChange Bool
  | AlphemericChange Bool
  | SymbolChange Bool
  | SymbolSetChange String Bool
  | Clicked


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
    SymbolSetChange a b ->
      { model | symbolset = List.map (\x -> if x.description_en == a then { x | ison = b } else x) model.symbolset }
    Clicked ->
      { model | resultlist = createCharSet model }


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


createCharSet : Model -> List String
createCharSet model =
  let
    numeric =
      if model.numeric then
        List.repeat charCount.numeric "0123456789"
      else
        []

    alphemeric =
      if model.alphemeric then
        List.repeat charCount.alphemeric "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
      else
        []

    symbol =
      if model.symbol then
        List.map .content <| List.filter .ison model.symbolset
      else
        []
  in
    List.concat [ numeric, alphemeric, symbol ]


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
          tr [ class (if model.symbol then "on" else "off"){-, style "display" (if model.symbol then "block" else "none")-} ] -- 使用するシンボル
          [
            th []
            [ text "使用する記号" ],
            td [] <| List.map (\x -> label [] [
              input [ type_ "checkbox", checked x.ison, onCheck <| SymbolSetChange x.description_en ] [],
              span [] [ text <| x.content ++ " " ++ "(" ++ x.description_ja ++ ")" ]
            ]) model.symbolset
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
      [ button [ onClick Clicked ] [ text "generate!" ]
      , ul [] <| List.map (\x -> li [] [ text x ]) model.resultlist
      ]
    ]


