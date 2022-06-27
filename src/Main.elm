module Main exposing (..)

import Array
import ArrayView exposing (directionAttr, draw)
import Dagre.Attributes exposing (RankDir(..))


main =
    draw
        [ directionAttr LR ]
        []
        (Array.fromList [ 0, 1, 2, 3, 5 ])
