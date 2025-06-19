module Main exposing (main)

import Browser
import Browser.Navigation as Nav
import Html exposing (Html, blockquote, button, div, h1, input, label, node, p, span, text)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput)
import Url
import Url.Builder as Builder
import Url.Parser.Query as Query



-- MODEL


type alias Model =
    { name : String
    , firstWord : String
    , secondWord : String
    , key : Nav.Key
    , url : Url.Url
    }


init : () -> Url.Url -> Nav.Key -> ( Model, Cmd Msg )
init _ url key =
    let
        params =
            parseUrl url
    in
    ( { name = Maybe.withDefault "メロス" params.name
      , firstWord = Maybe.withDefault "政治" params.firstWord
      , secondWord = Maybe.withDefault "邪悪" params.secondWord
      , key = key
      , url = url
      }
    , Cmd.none
    )



-- UPDATE


type Msg
    = Name String
    | FirstWord String
    | SecondWord String
    | LinkClicked Browser.UrlRequest
    | UrlChanged Url.Url


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Name name ->
            let
                newModel =
                    { model | name = name }
            in
            ( newModel, updateUrl newModel )

        FirstWord firstWord ->
            let
                newModel =
                    { model | firstWord = firstWord }
            in
            ( newModel, updateUrl newModel )

        SecondWord secondWord ->
            let
                newModel =
                    { model | secondWord = secondWord }
            in
            ( newModel, updateUrl newModel )

        LinkClicked urlRequest ->
            case urlRequest of
                Browser.Internal url ->
                    ( model, Nav.pushUrl model.key (Url.toString url) )

                Browser.External href ->
                    ( model, Nav.load href )

        UrlChanged url ->
            let
                params =
                    parseUrl url
            in
            ( { model
                | url = url
                , name = Maybe.withDefault "メロス" params.name
                , firstWord = Maybe.withDefault "政治" params.firstWord
                , secondWord = Maybe.withDefault "邪悪" params.secondWord
              }
            , Cmd.none
            )



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
                , text "は激怒した。必ず、かの邪智暴虐の王を除かなければならぬと決意した。"
                , show model.name
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
                    [ text "メロスは激怒した。必ず、かの邪智暴虐の王を除かなければならぬと決意した。メロスには政治がわからぬ。メロスは、村の牧人である。笛を吹き、羊と遊んで暮して来た。けれども邪悪に対しては、人一倍に敏感であった。"
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
    Browser.application
        { init = init
        , update = update
        , view = \model -> { title = "激怒した！！！！！！！！！！", body = [ view model ] }
        , subscriptions = \_ -> Sub.none
        , onUrlChange = UrlChanged
        , onUrlRequest = LinkClicked
        }


type alias Params =
    { name : Maybe String
    , firstWord : Maybe String
    , secondWord : Maybe String
    }


parseUrl : Url.Url -> Params
parseUrl url =
    case url.query of
        Nothing ->
            { name = Nothing, firstWord = Nothing, secondWord = Nothing }

        Just query ->
            { name = parseQueryParam "name" query
            , firstWord = parseQueryParam "firstWord" query
            , secondWord = parseQueryParam "secondWord" query
            }


parseQueryParam : String -> String -> Maybe String
parseQueryParam key query =
    query
        |> String.split "&"
        |> List.filterMap
            (\param ->
                case String.split "=" param of
                    [ paramKey, value ] ->
                        if paramKey == key then
                            Just (decodeUri value)

                        else
                            Nothing

                    _ ->
                        Nothing
            )
        |> List.head


decodeUri : String -> String
decodeUri encoded =
    case Url.percentDecode encoded of
        Just decoded ->
            decoded

        Nothing ->
            encoded


updateUrl : Model -> Cmd Msg
updateUrl model =
    let
        queryParams =
            [ Builder.string "name" model.name
            , Builder.string "firstWord" model.firstWord
            , Builder.string "secondWord" model.secondWord
            ]
    in
    Nav.replaceUrl model.key (Builder.relative [] queryParams)
