module Test.IntDict (tests) where

{-| Copied and modified from `Dict`s test suite. -}

import Basics (..)
import IntDict
import List
import Maybe (..)

import ElmTest.Assertion (..)
import ElmTest.Test (..)

numbers : IntDict.IntDict String
numbers = IntDict.fromList [ (2, "2"), (3, "3") ]

tests : Test
tests =
  let buildTests = suite "build Tests"
        [ test "empty" <| assertEqual (IntDict.fromList []) (IntDict.empty)
        , test "singleton" <| assertEqual (IntDict.fromList [(1,"v")]) (IntDict.singleton 1 "v")
        , test "insert" <| assertEqual (IntDict.fromList [(1,"v")]) (IntDict.insert 1 "v" IntDict.empty)
        , test "insert replace" <| assertEqual (IntDict.fromList [(1,"vv")]) (IntDict.insert 1 "vv" (IntDict.singleton 1 "v"))
        , test "update" <| assertEqual (IntDict.fromList [(1,"vv")]) (IntDict.update 1 (\v->Just "vv") (IntDict.singleton 1 "v"))
        , test "update Nothing" <| assertEqual IntDict.empty (IntDict.update 1 (\v->Nothing) (IntDict.singleton 1 "v"))
        , test "remove" <| assertEqual IntDict.empty (IntDict.remove 1 (IntDict.singleton 1 "v"))
        , test "remove not found" <| assertEqual (IntDict.singleton 1 "v") (IntDict.remove 342 (IntDict.singleton 1 "v"))
        ]
      queryTests = suite "query Tests"
        [ test "member 1" <| assertEqual True (IntDict.member 2 numbers)
        , test "member 2" <| assertEqual False (IntDict.member 5234 numbers)
        , test "get 1" <| assertEqual (Just "2") (IntDict.get 2 numbers)
        , test "get 2" <| assertEqual Nothing (IntDict.get 5234 numbers)
        ]
      combineTests = suite "combine Tests"
        [ test "union" <| assertEqual numbers (IntDict.union (IntDict.singleton 3 "3") (IntDict.singleton 2 "2"))
        , test "union collison" <| assertEqual (IntDict.singleton 2 "2") (IntDict.union (IntDict.singleton 2 "2") (IntDict.singleton 2 "3"))
        , test "intersect" <| assertEqual (IntDict.singleton 2 "2") (IntDict.intersect numbers (IntDict.singleton 2 "2"))
        , test "diff" <| assertEqual (IntDict.singleton 3 "3") (IntDict.diff numbers (IntDict.singleton 2 "2"))
        ]
      transformTests = suite "transform Tests"
        [ test "filter" <| assertEqual (IntDict.singleton 2 "2") (IntDict.filter (\k v -> k == 2) numbers)
        , test "partition" <| assertEqual (IntDict.singleton 2 "2", IntDict.singleton 3 "3") (IntDict.partition (\k v -> k == 2) numbers)
        ]
  in
    suite "IntDict Tests"
    [ buildTests
    , queryTests
    , combineTests
    , transformTests
    ]