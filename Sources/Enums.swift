//
//  Enums.swift
//  Swirl
//
//  Created by Alejandro Alonso
//  Copyright © 2017 Alejandro Alonso. All rights reserved.
//

public extension Swirl {

  enum Term: UInt8 {
    case float = 70
    case smallInt = 97
    case int
    case atom = 100
    case nilObject = 106
    case string
    case list
    case binary
    case smallAtom = 115
    case map
    case atomUTF = 118
    case smallAtomUTF
  }

  enum ParseError: Error {
    case decoding(message: String), encoding(message: String)
  }

}
