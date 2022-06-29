module Main exposing (..)

import Array
import ArrayView as AV
import Dict
import Html exposing (Html)
import Layout.Attributes exposing (Direction(..), direction, heightDict, width, widthDict)
import Render.Attributes as A exposing (elemDrawer, svgDrawNode)
import Render.StandardDrawers.Types exposing (Shape)
import Color



main : Html msg
main =
    AV.draw
        [ direction LR
        --, width 10
        {- , widthDict <| Dict.fromList [ ( 0, 50 ), ( 1, 60 ), ( 2, 70 ), ( 3, 80 ), ( 4, 90 ), ( 5, 100 ) ]
        , heightDict <| Dict.fromList [ ( 0, 40 ), ( 1, 50 ), ( 2, 60 ), ( 3, 70 ), ( 4, 80 ), ( 5, 90 ) ] -}
        ]
        [ elemDrawer
            (svgDrawNode
                [ A.label (\n -> String.fromInt n.label)
                , A.xLabel (\n -> String.fromInt n.id)
                , A.xLabelPos (\_ _ _ -> ( 0, 65 ))
                {- , A.shape A.Box
                , A.fill (\_ -> Color.rgb 255 255 255)
                , A.strokeColor (\_ -> Color.rgb 0 0 0)
                , A.strokeDashArray (\_ -> "hi")
                , A.xLabelPos (\_ _ _-> (0, 40)) -}
                ]
            )
        ]
        (Array.fromList [ 0, 1, 2, -1, 5 ])
