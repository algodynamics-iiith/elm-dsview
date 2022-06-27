module Main exposing (..)

import Array
import ArrayView exposing (directionAttr, draw, heightDictAttr, widthAttr, widthDictAttr)
import Dagre.Attributes exposing (RankDir(..))
import Dict
import Html exposing (Html)
import Render as R
import Render.StandardDrawers as RSD
import Render.StandardDrawers.Attributes as RSDA


main : Html msg
main =
    draw
        [ directionAttr LR
        , widthAttr 10
        , widthDictAttr <| Dict.fromList [ ( 0, 50 ), ( 1, 60 ), ( 2, 70 ), ( 3, 80 ), ( 4, 90 ), ( 5, 100 ) ]
        , heightDictAttr <| Dict.fromList [ ( 0, 40 ), ( 1, 50 ), ( 2, 60 ), ( 3, 70 ), ( 4, 80 ), ( 5, 90 ) ]
        ]
        [ R.nodeDrawer
            (RSD.svgDrawNode
                [ RSDA.label (\n -> String.fromInt n.label)
                , RSDA.xLabel (\n -> String.fromInt n.id)
                , RSDA.xLabelPos (\n _ _ -> ( 0, 65 ))
                ]
            )
        ]
        (Array.fromList [ 0, 1, 2, -1, 5 ])
