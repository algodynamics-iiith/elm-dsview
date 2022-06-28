module ArrayView exposing (draw)

import Array exposing (Array)
import Attributes as A exposing (LayoutConfig, DrawConfig)
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
    , direction = A.LR
    , wrapVal = Nothing
    }


directionToRankDir : A.Direction -> DA.RankDir
directionToRankDir dir =
    case dir of
        A.TB ->
            DA.TB

        A.BT ->
            DA.BT

        A.LR ->
            DA.LR

        A.RL ->
            DA.RL


layoutDagreAttr : List (Attribute LayoutConfig) -> ( List DA.Attribute, Maybe Int )
layoutDagreAttr arrayConfig =
    let
        attr =
            List.foldl
                (\f a -> f a)
                defLayoutConfig
                arrayConfig

        rank =
            directionToRankDir attr.direction
    in
    ( [ DA.widthDict <| attr.widthDict
      , DA.heightDict <| attr.heightDict
      , DA.width <| attr.width
      , DA.height <| attr.height
      , DA.marginX <| attr.marginX
      , DA.marginY <| attr.marginY
      , DA.rankSep <| attr.elemDistX
      , DA.nodeSep <| attr.elemDistY
      , DA.rankDir <| rank
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





defDrawConfig : DrawConfig n e msg
defDrawConfig =
    { edgeDrawer = RSD.svgDrawEdge []
    , nodeDrawer = RSD.svgDrawNode []
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
        ( attrDagre, wrapval ) =
            layoutDagreAttr attr

        g =
            arrayToGraph array wrapval

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


draw : List (Attribute LayoutConfig) -> List (Attribute (DrawConfig n e msg)) -> Array n -> Html msg
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
