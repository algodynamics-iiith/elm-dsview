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

<<<<<<< HEAD
{-| The widthDict associates nodes with a width that will be used during the layout.
The defualt value is Dict.empty
-}
=======
{-| To individually set the width of each element based on their id -}
>>>>>>> main
widthDict : Dict Int Float -> Attribute { b | widthDict : Dict Int Float }
widthDict wdict =
    \rec -> { rec | widthDict = wdict }

<<<<<<< HEAD
{-| The heightDict associates nodes with a height that will be used during the layout.
The defualt value is Dict.empty
-}
=======
{-| To individually set the height of each element based on their id -}
>>>>>>> main
heightDict : Dict Int Float -> Attribute { b | heightDict : Dict Int Float }
heightDict hdict =
    \rec -> { rec | heightDict = hdict }

<<<<<<< HEAD
{-| Defines the default width that will be used during the layout.
This value will be used when no value is available in widthDict for some node.
-}
=======
{-| To set a common width for each array element if widthDict does not specify their width -}
>>>>>>> main
width : Float -> Attribute { b | width : Float }
width w =
    \rec -> { rec | width = w }

<<<<<<< HEAD
{-| Defines the default height that will be used during the layout.
This value will be used when no value is available in heightDict for some node.
-}
=======
{-| To set a common height for each array element if heightDict does not specify their height -}
>>>>>>> main
height : Float -> Attribute { b | height : Float }
height h =
    \rec -> { rec | height = h }

<<<<<<< HEAD
{-| Defines the number of pixels to use as a margin around the left and right
of the Array.
-}
=======
{-| To set margin in X-diretion of layout -}
>>>>>>> main
marginX : Float -> Attribute { b | marginX : Float }
marginX mX =
    \rec -> { rec | marginX = mX }

<<<<<<< HEAD
{-| Defines the number of pixels to use as a margin around the top and bottom
of the Array.
-}
=======
{-| To set margin in Y-direction of layout -}
>>>>>>> main
marginY : Float -> Attribute { b | marginY : Float }
marginY mY =
    \rec -> { rec | marginY = mY }

<<<<<<< HEAD
{-| Defines Relative distance between elements of array in x-axis direction
-}
=======
{-| To specify distance between elements in X-direction -}
>>>>>>> main
elemDistX : Float -> Attribute { b | elemDistX : Float }
elemDistX dx =
    \rec -> { rec | elemDistX = dx }

<<<<<<< HEAD
{-| Defines Relative distance between elements of array in y-axis direction
-}
=======
{-| To specify distance between elements in Y-direction -}
>>>>>>> main
elemDistY : Float -> Attribute { b | elemDistY : Float }
elemDistY dy =
    \rec -> { rec | elemDistY = dy }

<<<<<<< HEAD
{-| Defines array layout direction i.e LR, RL, TB, BT
-}
=======
{-| To specify the orientation of representation of array elements -}
>>>>>>> main
direction : Direction -> Attribute { b | direction : Direction }
direction dir =
    \rec -> { rec | direction = dir }

<<<<<<< HEAD
{-| Defines the no of nodes to be wrapped in a row before moving to next row 
-}
=======
{-| To set the maximum number of elements that can be displayed in one row -}
>>>>>>> main
wrapVal : Maybe Int -> Attribute { b | wrapVal : Maybe Int }
wrapVal wv =
    \rec -> { rec | wrapVal = wv }
