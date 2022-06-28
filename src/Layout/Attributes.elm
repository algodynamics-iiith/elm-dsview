module Layout.Attributes exposing (..)

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

{-| To individually set the width of each element based on their id -}
widthDict : Dict Int Float -> Attribute { b | widthDict : Dict Int Float }
widthDict wdict =
    \rec -> { rec | widthDict = wdict }

{-| To individually set the height of each element based on their id -}
heightDict : Dict Int Float -> Attribute { b | heightDict : Dict Int Float }
heightDict hdict =
    \rec -> { rec | heightDict = hdict }

{-| To set a common width for each array element if widthDict does not specify their width -}
width : Float -> Attribute { b | width : Float }
width w =
    \rec -> { rec | width = w }

{-| To set a common height for each array element if heightDict does not specify their height -}
height : Float -> Attribute { b | height : Float }
height h =
    \rec -> { rec | height = h }

{-| To set margin in X-diretion of layout -}
marginX : Float -> Attribute { b | marginX : Float }
marginX mX =
    \rec -> { rec | marginX = mX }

{-| To set margin in Y-direction of layout -}
marginY : Float -> Attribute { b | marginY : Float }
marginY mY =
    \rec -> { rec | marginY = mY }

{-| To specify distance between elements in X-direction -}
elemDistX : Float -> Attribute { b | elemDistX : Float }
elemDistX dx =
    \rec -> { rec | elemDistX = dx }

{-| To specify distance between elements in Y-direction -}
elemDistY : Float -> Attribute { b | elemDistY : Float }
elemDistY dy =
    \rec -> { rec | elemDistY = dy }

{-| To specify the orientation of representation of array elements -}
direction : Direction -> Attribute { b | direction : Direction }
direction dir =
    \rec -> { rec | direction = dir }

{-| To set the maximum number of elements that can be displayed in one row -}
wrapVal : Maybe Int -> Attribute { b | wrapVal : Maybe Int }
wrapVal wv =
    \rec -> { rec | wrapVal = wv }
