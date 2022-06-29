module Layout.Attributes exposing (widthDict, heightDict, width, height, marginX, marginY, elemDistX, elemDistY, direction, wrapVal, LayoutConfig, Direction(..))

{-| Layout Configuration Attributes


# Types

@docs Direction, LayoutConfig


# Attributes

These function set the respective attributes for the algorithm

@docs widthDict, heightDict, width, height, marginX, marginY, elemDistX, elemDistY, direction, wrapVal

-}

import Dict exposing (Dict)
import Render.StandardDrawers.Attributes exposing (Attribute)

{-| This type represents the directions of representation , wherein TB stands for Top-to-Bottom, BT stands for Bottom-to-Top, LR stands for Left-to-Right and RL stands for Right-to-Left-}
type Direction
    = TB
    | BT
    | LR
    | RL

{-| This type represents the layout configurations of the drawer -}
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

The default value is Dict.empty
-}
widthDict : Dict Int Float -> Attribute { b | widthDict : Dict Int Float }
widthDict wdict =
    \rec -> { rec | widthDict = wdict }

{-| The heightDict associates nodes with a height that will be used during the layout.

The default value is Dict.empty
-}
heightDict : Dict Int Float -> Attribute { b | heightDict : Dict Int Float }
heightDict hdict =
    \rec -> { rec | heightDict = hdict }

{-| Defines the default width that will be used during the layout.
This value will be used when no value is available in widthDict for some node.

The default value is 60 pixels
-}
width : Float -> Attribute { b | width : Float }
width w =
    \rec -> { rec | width = w }

{-| Defines the default height that will be used during the layout.
This value will be used when no value is available in heightDict for some node.

The default value is 60 pixels
-}
height : Float -> Attribute { b | height : Float }
height h =
    \rec -> { rec | height = h }

{-| Defines the number of pixels to use as a margin around the left and right
of the Array.

The default value is 50 pixels
-}
marginX : Float -> Attribute { b | marginX : Float }
marginX mX =
    \rec -> { rec | marginX = mX }

{-| Defines the number of pixels to use as a margin around the top and bottom
of the Array.

The default value is 50 pixels
-}
marginY : Float -> Attribute { b | marginY : Float }
marginY mY =
    \rec -> { rec | marginY = mY }

{-| Defines Relative distance between elements of array in x-axis direction

The default value is 50 pixels
-}
elemDistX : Float -> Attribute { b | elemDistX : Float }
elemDistX dx =
    \rec -> { rec | elemDistX = dx }

{-| Defines Relative distance between elements of array in y-axis direction

The default value is 50 pixels
-}
elemDistY : Float -> Attribute { b | elemDistY : Float }
elemDistY dy =
    \rec -> { rec | elemDistY = dy }

{-| Defines array layout direction i.e LR, RL, TB, BT

The default value is LR
-}
direction : Direction -> Attribute { b | direction : Direction }
direction dir =
    \rec -> { rec | direction = dir }

{-| Defines the number of nodes to be wrapped in a row before moving to next row 

The default value is Nothing
-}
wrapVal : Maybe Int -> Attribute { b | wrapVal : Maybe Int }
wrapVal wv =
    \rec -> { rec | wrapVal = wv }
