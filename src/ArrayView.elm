module ArrayView exposing (..)

import Array exposing (..)
import Dagre as D
import Dagre.Attributes as DA
import Dict exposing (Dict)
import Graph as G exposing (Node)
import Html exposing (..)
import Render.StandardDrawers as RSD
import Render.StandardDrawers.Attributes exposing (Attribute)
import Render.Types exposing (..)
import TypedSvg as TS
import TypedSvg.Attributes as TA
import TypedSvg.Core as TC
import TypedSvg.Types exposing (YesNo(..))


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


defLayoutConfig : LayoutConfig
defLayoutConfig =
    { widthDict = Dict.empty
    , heightDict = Dict.empty
    , width = 60
    , height = 60
    , marginX = 50
    , marginY = 50
    , elemDistX = 50
    , elemDistY = 50
    , direction = DA.TB
    , wrapVal = Nothing
    }


widthDictAttr : Dict Int Float -> Attribute { b | widthDict : Dict Int Float }
widthDictAttr wdict =
    \rec -> { rec | widthDict = wdict }


heightDictAttr : Dict Int Float -> Attribute { b | heightDict : Dict Int Float }
heightDictAttr hdict =
    \rec -> { rec | heightDict = hdict }


widthAttr : Float -> Attribute { b | width : Float }
widthAttr w =
    \rec -> { rec | width = w }


heightAttr : Float -> Attribute { b | height : Float }
heightAttr h =
    \rec -> { rec | height = h }


marginXAttr : Float -> Attribute { b | marginX : Float }
marginXAttr mX =
    \rec -> { rec | marginX = mX }


marginYAttr : Float -> Attribute { b | marginY : Float }
marginYAttr mY =
    \rec -> { rec | marginY = mY }


elemDistXAttr : Float -> Attribute { b | elemDistX : Float }
elemDistXAttr dx =
    \rec -> { rec | elemDistX = dx }


elemDistYAttr : Float -> Attribute { b | elemDistY : Float }
elemDistYAttr dy =
    \rec -> { rec | elemDistY = dy }


directionAttr : Direction -> Attribute { b | direction : Direction }
directionAttr dir =
    \rec -> { rec | direction = dir }


wrapValAttr : Maybe Int -> Attribute { b | wrapVal : Maybe Int }
wrapValAttr wv =
    \rec -> { rec | wrapVal = wv }


layoutDagreAttr : List (Attribute LayoutConfig) -> ( List DA.Attribute, Maybe Int )
layoutDagreAttr arrayConfig =
    let
        attr =
            List.foldl
                (\f a -> f a)
                defLayoutConfig
                arrayConfig
    in
    ( [ DA.widthDict <| attr.widthDict
      , DA.heightDict <| attr.heightDict
      , DA.width <| attr.width
      , DA.height <| attr.height
      , DA.marginX <| attr.marginX
      , DA.marginY <| attr.marginY
      , DA.rankSep <| attr.elemDistX
      , DA.nodeSep <| attr.elemDistY
      , DA.rankDir <| attr.direction
      ]
    , attr.wrapVal
    )


type alias ArrayLayout n =
    { width : Float
    , height : Float
    , coordDict : Dict Int ( Float, Float )
    , arrayGraph : G.Graph n ()
    , dagreAttr : List DA.Attribute
    }


type alias DrawConfig n msg =
    { nodeDrawer : NodeDrawer n msg
    , style : String
    , id : String
    }


defDrawConfig : DrawConfig n msg
defDrawConfig =
    { nodeDrawer = RSD.svgDrawNode []
    , style = ""
    , id = "array-0"
    }


arrayToGraph : Array a -> Maybe Int -> G.Graph a ()
arrayToGraph arr wv =
    G.fromNodeLabelsAndEdgePairs
        (Array.toList arr)
        (List.range 1 (Array.length arr - 1)
            |> List.indexedMap (\i el -> ( i, el ))
            |> List.filter
                (\( _, y ) ->
                    case wv of
                        Just num ->
                            remainderBy num y /= 0

                        Nothing ->
                            True
                )
        )


runArrayLayout : List (Attribute LayoutConfig) -> Array n -> ArrayLayout n
runArrayLayout attr array =
    let
        ( attrDagre, wrapVal ) =
            layoutDagreAttr attr

        g =
            arrayToGraph array wrapVal

        graphLayout =
            D.runLayout attrDagre g
    in
    { width = graphLayout.width
    , height = graphLayout.height
    , coordDict = graphLayout.coordDict
    , arrayGraph = g
    , dagreAttr = attrDagre
    }


nodeDrawing : Node n -> NodeDrawer n msg -> Dict.Dict G.NodeId ( Float, Float ) -> DA.Config -> TC.Svg msg
nodeDrawing node_ drawNode_ coordDict config =
    let
        pos =
            Maybe.withDefault ( -10, -10 ) (Dict.get node_.id coordDict)

        w =
            Maybe.withDefault config.width (Dict.get node_.id config.widthDict)

        h =
            Maybe.withDefault config.height (Dict.get node_.id config.heightDict)
    in
    drawNode_ (NodeAttributes node_ pos w h)


draw : List (Attribute LayoutConfig) -> List (Attribute (R.DrawConfig n msg)) -> Array n -> Html msg
draw edits1 edits2 array =
    let
        { width, height, coordDict, arrayGraph, dagreAttr } =
            runArrayLayout edits1 array

        dagreConfig =
            List.foldl (\f a -> f a) D.defaultConfig dagreAttr

        drawConfig =
            List.foldl (\f a -> f a) defDrawConfig edits2

        nodeLst =
            G.nodes arrayGraph

        nodesSvg =
            TS.g [ TA.class [ "nodes" ] ] <| List.map (\n -> nodeDrawing n drawConfig.nodeDrawer coordDict dagreConfig) nodeLst
    in
    TS.svg
        [ TA.viewBox 0 0 width height
        , TA.style drawConfig.style
        ]
        [ TS.g [ TA.id drawConfig.id ] [ nodesSvg ]
        ]
