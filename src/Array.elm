import Dagre as D
import Dagre.Acyclic as DAC
import Dagre.Attributes as DA
import Dagre.Normalize as DN
import Dagre.Order as DO
import Dagre.Position as DP
import Dagre.Rank as DR
import Dagre.Utils as DU
import Dict exposing (Dict)

import Dagre.Attribute as DA
import Render.StandardDrawers.Types as RSDT
import Render.StandardDrawers.Attribute as RSDA exposing (Attribute)
import Render.StandardDrawers as RSD
import Array 

type alias Direction =
    DA.RankDir

type alias DagreConfig =
    { widthDict : Dict Float Float
    , heightDict : Dict Float Float
    , width : Float
    , height : Float
    , marginX : Float
    , marginY : Float
    , elemDistX : Float
    , elemDistY : Float
    , direction : DA.RankDir
    , wrapVal : Maybe Int
    }

layoutDagreAttr : DagreConfig -> List DA.Attribute
layoutDagreAttr config = 
    {
        DA.widthDict <| config.widthDict
        , DA.heightDict <| config.heightDict
        , DA.width <| config.width
        , DA.height <| config.height
        , DA.marginX <| config.marginX
        , DA.marginY <| config.marginY
        , DA.rankSep <| config.elemDistX
        , DA.nodeSep <| config.elemDistY
        , DA.direction <| config.direction
    }

type ArrayLayout = 
    {
        width : Float 
        , height : Float
        , coordDict : Dict Int DU.Coordinates   
        , arrayGraph : G.Graph Int ()
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


arrayToGraph : Array Int -> Maybe Int -> G.Graph Int ()
arrayToGraph arr wv = 
    G.fromNodeLabelsAndEdgePairs 
        (Array.toList arr)
        (List.range 1 (Array.length arr - 1)
            |> List.indexedMap (\i el -> (i,el))
            |> List.filter 
                (\(_,y) ->
                    case wv of 
                        Just n -> 
                            remainderBy n y /= 0

                        Nothing ->
                            True
                )
        )


runArrayLayout : Attribute (DagreConfig) -> Array a -> ArrayLayout 
runArrayLayout config array = 
    let
        editsDagre = layoutDagreAttr config
        g = arraytoGraph array config.wrapVal
        {width, height, coordict, _ } = D.runLayout 
    in
    { width, height, coordict, g }


draw : List (Attribute (DagreConfig)) -> List (Attribute (DrawConfig n msg)) -> Array a -> Html msg
draw edits1 edits2 array =
    let
        editD = layoutDagreAttr edits1
        { width, height, coordDict, arrGraph } =
            runArrayLayout edits1 array

        dagreConfig =
            List.foldl (\f a -> f a) D.defaultConfig editsD

        drawConfig =
            List.foldl (\f a -> f a) defDrawConfig edits2

        nodesSvg =
            TS.g [ TA.class [ "nodes" ] ] <| List.map (\n -> nodeDrawing n drawConfig.nodeDrawer coordDict dagreConfig) <| arrGraph
    in
    TS.svg
        [ TA.viewBox 0 0 width height
        , TA.style drawConfig.style
        ]
        [ TS.g [ TA.id drawConfig.id ] [ nodesSvg ]
        ]