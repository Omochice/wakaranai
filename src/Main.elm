module Main exposing (main)

import Browser
import Html exposing (Html, blockquote, button, div, h1, input, label, node, p, span, text)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput)



-- MODEL


type alias Model =
    { name : String
    , firstWord : String
    , secondWord : String
    }


init : Model
init =
    { name = "メロス"
    , firstWord = "政治"
    , secondWord = "邪悪"
    }



-- UPDATE


type Msg
    = Name String
    | FirstWord String
    | SecondWord String


update : Msg -> Model -> Model
update msg model =
    case msg of
        Name name ->
            { model | name = name }

        FirstWord firstWord ->
            { model | firstWord = firstWord }

        SecondWord secondWord ->
            { model | secondWord = secondWord }



-- VIEW


view : Model -> Html Msg
view model =
    div
        [ style "background" "white"
        , style "border-radius" "20px"
        , style "padding" "40px"
        , style "box-shadow" "0 20px 40px rgba(0,0,0,0.1)"
        , style "backdrop-filter" "blur(10px)"
        ]
        [ node "style"
            [ type_ "text/css" ]
            [ text """
                body {
                  font-family: 'Helvetica Neue', Arial, sans-serif;
                  max-width: 800px;
                  margin: 0 auto;
                  padding: 20px;
                  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                  min-height: 100vh;
                  color: #333;
                }
            """ ]
        , h1
            [ style "text-align" "center"
            , style "color" "#2c3e50"
            , style "font-size" "2.5em"
            , style "margin-bottom" "30px"
            , style "font-weight" "300"
            ]
            [ text "激怒した！！！！！！！！！！" ]
        , div []
            [ inputGroup "主人公の名前（元：メロス）" "name" Name model
            , inputGroup "最初の単語（元：政治）" "firstWord" FirstWord model
            , inputGroup "二番目の単語（元：邪悪）" "secondWord" SecondWord model
            , div
                [ style "background" "#f8f9fa"
                , style "border" "2px solid #e9ecef"
                , style "border-radius" "15px"
                , style "padding" "30px"
                , style "font-size" "18px"
                , style "line-height" "1.8"
                , style "margin-top" "30px"
                , style "font-family" "'Georgia', serif"
                , style "color" "#2c3e50"
                , style "box-shadow" "inset 0 2px 4px rgba(0,0,0,0.06)"
                ]
                [ show model.name
                , text "には"
                , show model.firstWord
                , text "がわからぬ。"
                , show model.name
                , text "は、村の牧人である。笛を吹き、羊と遊んで暮して来た。けれども"
                , show model.secondWord
                , text "に対しては、人一倍に敏感であった。"
                ]
            , div
                [ style "margin-top" "30px"
                , style "padding" "20px"
                , style "background" "#ecf0f1"
                , style "border-radius" "10px"
                , style "border-left" "4px solid #3498db"
                ]
                [ div
                    [ style "font-weight" "600"
                    , style "color" "#2c3e50"
                    , style "margin-bottom" "10px"
                    ]
                    [ text "元の文章（太宰治「走れメロス」）" ]
                , blockquote []
                    [ text "メロスには政治がわからぬ。メロスは、村の牧人である。笛を吹き、羊と遊んで暮して来た。けれども邪悪に対しては、人一倍に敏感であった。"
                    ]
                ]
            ]
        ]


show : String -> Html Msg
show t =
    span
        [ style "background" "linear-gradient(120deg, #a8edea 0%, #fed6e3 100%)"
        , style "padding" "2px 6px"
        , style "border-radius" "6px"
        , style "font-weight" "600"
        ]
        [ text t ]


inputGroup : String -> String -> (String -> Msg) -> Model -> Html Msg
inputGroup labelText inputId msg model =
    div [ style "margin-bottom" "25px" ]
        [ label
            [ for inputId
            , style "display" "block"
            , style "margin-bottom" "8px"
            , style "font-weight" "600"
            , style "color" "#34495e"
            , style "font-size" "1.1em"
            ]
            [ text labelText
            ]
        , input
            [ style "width" "100%"
            , style "padding" "15px"
            , style "border" "2px solid #e1e8ed"
            , style "border-radius" "12px"
            , style "font-size" "16px"
            , style "transition" "all 0.3s ease"
            , style "box-sizing" "border-box"
            , type_ "text"
            , id inputId
            , value
                (case inputId of
                    "name" ->
                        model.name

                    "firstWord" ->
                        model.firstWord

                    "secondWord" ->
                        model.secondWord

                    _ ->
                        ""
                )
            , onInput msg
            ]
            []
        ]



-- MAIN


main : Program () Model Msg
main =
    Browser.sandbox
        { init = init
        , update = update
        , view = view
        }
