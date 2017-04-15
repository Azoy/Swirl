//
//  Enums.swift
//  Swirl
//
//  Created by Alejandro Alonso
//  Copyright © 2017 Alejandro Alonso. All rights reserved.
//

extension Swirl {

  /// Acceptable ETF Terms that can be used
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

  /// Error from either encoding or decoding a byte array
  public enum ParseError: Error {
    case decoding(message: String), encoding(message: String)
  }

}
