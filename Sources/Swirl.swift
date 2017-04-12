//
//  Swirl.swift
//  Swirl
//
//  Created by Alejandro Alonso
//  Copyright © 2017 Alejandro Alonso. All rights reserved.
//

public final class Swirl {

  public static let version: UInt8 = 131

  public static func unpack(_ bytes: [UInt8]) throws -> Any {
    let version = bytes.shifted(by: 1)

    guard version[0] == Swirl.version else {
      throw ParseError.decoding(message: "Encountered unexpected version number")
    }

    guard bytes.count > 0 else {
      throw ParseError.decoding(message: "Data provided was invalid ETF")
    }

    do {
      return try self.decode(bytes)
    }catch let ParseError.decoding(message) {
      throw ParseError.decoding(message: message)
    }
  }

  static func decode(_ bytes: [UInt8]) throws -> Any {
    guard let tag = Term(rawValue: bytes.shifted(by: 1)[0]) else {
      throw ParseError.decoding(message: "Unsupported term encountered")
    }

    switch tag {
      case .smallInt:
        return UInt8(bytes[0])
      default:
        throw ParseError.decoding(message: "sup")
    }
  }

}
