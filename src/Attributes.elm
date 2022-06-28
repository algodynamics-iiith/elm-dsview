module Attributes exposing (Direction(..), DrawConfig, LayoutConfig, direction, elemDistX, elemDistY, elemDrawer, fill, height, heightDict, label, marginX, marginY, onClick, shape, strokeColor, strokeDashArray, strokeWidth, style, svgDrawNode, title, width, widthDict, wrapVal, xLabel, xLabelPos)

import Color exposing (Color)
import Dict exposing (Dict)
import Graph exposing (Node)
import Render as R
import Render.StandardDrawers as RSD
import Render.StandardDrawers.Attributes exposing (Attribute)
import Render.StandardDrawers.Types exposing (..)
import Render.Types exposing (..)
import TypedSvg.Core exposing (Svg)


type Direction
    = TB
    | BT
    | LR
    | RL


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


type alias DrawConfig n e msg =
    { edgeDrawer : EdgeDrawer e msg
    , nodeDrawer : NodeDrawer n msg
    , style : String
    , id : String
    }


type alias NodeDrawerConfig n msg =
    { label : Node n -> String
    , shape : Shape
    , onClick : Maybe (Node n -> msg)
    , strokeColor : Node n -> Color
    , strokeWidth : Node n -> Float
    , strokeDashArray : Node n -> String
    , style : Node n -> String
    , fill : Node n -> Color
    , title : Node n -> String
    , xLabel : Node n -> String
    , xLabelPos : Node n -> Float -> Float -> ( Float, Float )
    }


type alias Attribute c =
    c -> c


{-| The following attribute can be used to set label on both Nodes and Edges.
-}
label : (a -> String) -> Attribute { c | label : a -> String }
label f =
    \edc ->
        { edc | label = f }


{-| To add event handlers to Nodes and Edges
-}
onClick : (a -> msg) -> Attribute { c | onClick : Maybe (a -> msg) }
onClick f =
    \edc ->
        { edc | onClick = Just f }


{-| To set the stroke color of a node/edge
-}
strokeColor : (a -> Color) -> Attribute { c | strokeColor : a -> Color }
strokeColor f =
    \edc ->
        { edc | strokeColor = f }


{-| To set the stroke width of a node/edge
-}
strokeWidth : (a -> Float) -> Attribute { c | strokeWidth : a -> Float }
strokeWidth f =
    \edc ->
        { edc | strokeWidth = f }


{-| To set the stroke dash array of a node/edge
-}
strokeDashArray : (a -> String) -> Attribute { c | strokeDashArray : a -> String }
strokeDashArray f =
    \edc ->
        { edc | strokeDashArray = f }


{-| To add any inline css to path element of the edge, or polygon of node.
-}
style : (a -> String) -> Attribute { c | style : a -> String }
style f =
    \edc ->
        { edc | style = f }


{-| To set the title (appears as a tooltip) of a node/edge
-}
title : (a -> String) -> Attribute { c | title : a -> String }
title f =
    \edc ->
        { edc | title = f }



{- Node specific attributes -}


{-| This attributes sets the type of arrow head used for drawing the edge.
The possible values are None, Triangle, Vee.
-}
shape : Shape -> Attribute (NodeDrawerConfig n msg)
shape s =
    \ndc ->
        { ndc | shape = s }


{-| To add fill color to Node
-}
fill : (a -> Color) -> Attribute { c | fill : a -> Color }
fill f =
    \ndc ->
        { ndc | fill = f }


{-| Set the Extra Label for a node.
-}
xLabel : (Node n -> String) -> Attribute (NodeDrawerConfig n msg)
xLabel f =
    \ndc ->
        { ndc | xLabel = f }


xLabelPos : (Node n -> Float -> Float -> ( Float, Float )) -> Attribute (NodeDrawerConfig n msg)
xLabelPos f =
    \ndc ->
        { ndc | xLabelPos = f }


elemDrawer : NodeDrawer n msg -> DrawConfig n e msg -> DrawConfig n e msg
elemDrawer =
    R.nodeDrawer


svgDrawNode : List (Attribute (NodeDrawerConfig n msg)) -> NodeAttributes n -> Svg msg
svgDrawNode =
    RSD.svgDrawNode
