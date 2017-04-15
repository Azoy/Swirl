//
//  Swirl.swift
//  Swirl
//
//  Created by Alejandro Alonso
//  Copyright © 2017 Alejandro Alonso. All rights reserved.
//

public final class Swirl {

  static var bytes: [UInt8] = []

  static let version: UInt8 = 131

  public static func unpack(_ bytes: [UInt8]) throws -> Any? {
    self.bytes = bytes
    let version = self.bytes.shift(by: 1)

    guard version[0] == self.version else {
      throw ParseError.decoding(message: "Encountered unexpected version number")
    }

    guard bytes.count > 0 else {
      throw ParseError.decoding(message: "Data provided was invalid ETF")
    }

    do {
      return try self.decode()
    }catch let ParseError.decoding(message) {
      throw ParseError.decoding(message: message)
    }
  }

  static func decode() throws -> Any {
    guard let tag = Term(rawValue: self.bytes.shift(by: 1)[0]) else {
      throw ParseError.decoding(message: "Unsupported term encountered")
    }

    switch tag {
      case .float:
        return Double(bytes: Array(self.bytes.shift(by: 8)))

      case .smallInt:
        return UInt8(self.bytes.shift(by: 1)[0])

      case .int:
        return Int(bytes: Array(self.bytes.shift(by: 4)))

      case .atom:
        let length = Int(bytes: Array(self.bytes.shift(by: 2)))
        let unicode = Array(self.bytes.shift(by: length))
        return String(bytes: unicode)

      case .nilObject:
        return []

      case .string:
        let length = Int(bytes: Array(self.bytes.shift(by: 2)))
        let unicode = Array(self.bytes.shift(by: length))
        return String(bytes: unicode)

      case .list:
        return self.createList()

      case .binary:
        let length = Int(bytes: Array(self.bytes.shift(by: 4)))
        let unicode = Array(self.bytes.shift(by: length))
        return String(bytes: unicode)

      case .smallAtom:
        let length = Int(bytes: Array(self.bytes.shift(by: 1)))
        let unicode = Array(self.bytes.shift(by: length))
        return String(bytes: unicode)

      case .map:
        return self.createMap()

      default:
        throw ParseError.decoding(message: "sup")
    }
  }

  static func createList() -> [Any] {
    let length = Int(bytes: Array(self.bytes.shift(by: 4)))
    var array = [Any]()

    for _ in 0 ..< length {
      array.append(try! self.decode())
    }

    self.bytes.shift(by: 1) //Gets rid of tail

    return array
  }

  static func createMap() -> [AnyHashable: Any] {
    let length = Int(bytes: Array(self.bytes.shift(by: 4)))
    var dictionary = [AnyHashable: Any]()

    for _ in 0 ..< length {
      let key = try! self.decode() as! AnyHashable
      let value = try! self.decode()
      dictionary[key] = value
    }

    return dictionary
  }

}
