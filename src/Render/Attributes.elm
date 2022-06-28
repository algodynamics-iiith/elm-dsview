module Render.Attributes exposing (Shape(..), label, onClick, strokeColor, strokeWidth, strokeDashArray, style, title, shape, fill, xLabel, xLabelPos, elemDrawer, svgDrawNode, DrawConfig)

import Color exposing (Color)
import Graph exposing (Node)
import Render as R
import Render.StandardDrawers as RSD
import Render.StandardDrawers.Attributes exposing (Attribute)
import Render.StandardDrawers.Types as RSDT exposing (..)
import Render.Types exposing (..)
import TypedSvg.Core exposing (Svg)


type alias DrawConfig n e msg =
    { edgeDrawer : EdgeDrawer e msg
    , nodeDrawer : NodeDrawer n msg
    , style : String
    , id : String
    }


type alias NodeDrawerConfig n msg =
    { label : Node n -> String
    , shape : RSDT.Shape
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

type Shape
    = Circle
    | Ellipse
    | Box
    | RoundedBox Float



shapeConvert : Shape -> RSDT.Shape
shapeConvert dir =
    case dir of
        Circle ->
            RSDT.Circle

        RoundedBox n ->
            RSDT.RoundedBox n

        Box ->
            RSDT.Box
        
        Ellipse ->
            RSDT.Ellipse



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
        { ndc | shape = (shapeConvert s) }


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
