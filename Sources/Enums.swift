//
//  Enums.swift
//  Swirl
//
//  Created by Alejandro Alonso
//  Copyright © 2017 Alejandro Alonso. All rights reserved.
//

public extension Swirl {

  enum Term: UInt8 {
    case smallInt = 97
    case int
    case float
    case atom
    case smallTuple = 104
    case largeTuple
    case nilObject
    case string
    case list
    case binary
    case smallBig
    case largeBig
    case smallAtom = 115
    case map
    case atomUTF = 118
    case smallAtomUTF
  }

  enum ParseError: Error {
    case decoding(message: String), encoding(message: String)
  }

}
