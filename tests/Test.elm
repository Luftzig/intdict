module Main where

import Basics (..)
import Signal (..)

import ElmTest.Assertion as A
import ElmTest.Run as R
import ElmTest.Runner.Console (runDisplay)
import ElmTest.Test (..)
import IO.IO (..)
import IO.Runner (Request, Response)
import IO.Runner as Run

import Test.IntDict as IntDict

tests : Test
tests =
    suite "IntDict tests"
    [ IntDict.tests
    ]

console : IO ()
console = runDisplay tests

port requests : Signal Request
port requests = Run.run responses console

port responses : Signal Response