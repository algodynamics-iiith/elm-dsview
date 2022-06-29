module Layout.Attributes exposing (..)

{-| Layout Configuration Attributes


# Types

@docs Direction, LayoutConfig


# Attributes

These function set the respective attributes for the algorithm

@docs widthDict, heightDict, width, height, marginX, marginY, elemDistX, elemDistY, direction, wrapVal

-}

import Dict exposing (Dict)
import Render.StandardDrawers.Attributes exposing (Attribute)

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

{-| The widthDict associates nodes with a width that will be used during the layout.
The defualt value is Dict.empty
-}
widthDict : Dict Int Float -> Attribute { b | widthDict : Dict Int Float }
widthDict wdict =
    \rec -> { rec | widthDict = wdict }

{-| The heightDict associates nodes with a height that will be used during the layout.
The defualt value is Dict.empty
-}
heightDict : Dict Int Float -> Attribute { b | heightDict : Dict Int Float }
heightDict hdict =
    \rec -> { rec | heightDict = hdict }

{-| Defines the default width that will be used during the layout.
This value will be used when no value is available in widthDict for some node.
-}
width : Float -> Attribute { b | width : Float }
width w =
    \rec -> { rec | width = w }

{-| Defines the default height that will be used during the layout.
This value will be used when no value is available in heightDict for some node.
-}
height : Float -> Attribute { b | height : Float }
height h =
    \rec -> { rec | height = h }

{-| Defines the number of pixels to use as a margin around the left and right
of the Array.
-}
marginX : Float -> Attribute { b | marginX : Float }
marginX mX =
    \rec -> { rec | marginX = mX }

{-| Defines the number of pixels to use as a margin around the top and bottom
of the Array.
-}
marginY : Float -> Attribute { b | marginY : Float }
marginY mY =
    \rec -> { rec | marginY = mY }

{-| Defines Relative distance between elements of array in x-axis direction
-}
elemDistX : Float -> Attribute { b | elemDistX : Float }
elemDistX dx =
    \rec -> { rec | elemDistX = dx }

{-| Defines Relative distance between elements of array in y-axis direction
-}
elemDistY : Float -> Attribute { b | elemDistY : Float }
elemDistY dy =
    \rec -> { rec | elemDistY = dy }

{-| Defines array layout direction i.e LR, RL, TB, BT
-}
direction : Direction -> Attribute { b | direction : Direction }
direction dir =
    \rec -> { rec | direction = dir }

{-| Defines the no of nodes to be wrapped in a row before moving to next row 
-}
wrapVal : Maybe Int -> Attribute { b | wrapVal : Maybe Int }
wrapVal wv =
    \rec -> { rec | wrapVal = wv }
