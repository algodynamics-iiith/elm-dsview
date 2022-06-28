module Attributes exposing (LayoutConfig, direction, elemDistX, elemDistY, height, heightDict, marginX, marginY, width, widthDict, wrapVal)

import Array exposing (Array)
import Dagre as D
import Dagre.Attributes as DA
import Dict exposing (Dict)
import Graph as G exposing (Node)
import Html exposing (Html)
import Render.StandardDrawers as RSD
import Render.StandardDrawers.Attributes exposing (Attribute)
import Render.Types exposing (..)
import TypedSvg as TS
import TypedSvg.Attributes as TA
import TypedSvg.Core as TC


type alias Direction =
    DA.RankDir


type alias LayoutConfig =
    { widthDict : Dict Int Float
    , heightDict : Dict Int Float
    , width : Float
    , height : Float
    , marginX : Float
    , marginY : Float
    , elemDistX : Float
    , elemDistY : Float
    , direction : Direction
    , wrapVal : Maybe Int
    }


widthDict : Dict Int Float -> Attribute { b | widthDict : Dict Int Float }
widthDict wdict =
    \rec -> { rec | widthDict = wdict }


heightDict : Dict Int Float -> Attribute { b | heightDict : Dict Int Float }
heightDict hdict =
    \rec -> { rec | heightDict = hdict }


width : Float -> Attribute { b | width : Float }
width w =
    \rec -> { rec | width = w }


height : Float -> Attribute { b | height : Float }
height h =
    \rec -> { rec | height = h }


marginX : Float -> Attribute { b | marginX : Float }
marginX mX =
    \rec -> { rec | marginX = mX }


marginY : Float -> Attribute { b | marginY : Float }
marginY mY =
    \rec -> { rec | marginY = mY }


elemDistX : Float -> Attribute { b | elemDistX : Float }
elemDistX dx =
    \rec -> { rec | elemDistX = dx }


elemDistY : Float -> Attribute { b | elemDistY : Float }
elemDistY dy =
    \rec -> { rec | elemDistY = dy }


direction : Direction -> Attribute { b | direction : Direction }
direction dir =
    \rec -> { rec | direction = dir }


wrapVal : Maybe Int -> Attribute { b | wrapVal : Maybe Int }
wrapVal wv =
    \rec -> { rec | wrapVal = wv }
