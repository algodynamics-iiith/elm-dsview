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
        ]
        [ elemDrawer
            (svgDrawNode
                [ A.label (\n -> String.fromInt n.label)
                , A.xLabel (\n -> String.fromInt n.id)
                , A.xLabelPos (\_ _ _ -> ( 0, 65 ))
                , A.shape A.Box
                , A.strokeColor (\_ -> Color.rgb 0 0 0)
                ]
            )
        ]
        (Array.fromList [ 0, 1, 2, -1, 5 ])
