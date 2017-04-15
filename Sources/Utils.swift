//
//  Utils.swift
//  Swirl
//
//  Created by Alejandro Alonso
//  Copyright © 2017 Alejandro Alonso. All rights reserved.
//

extension Array {

  /**
   Removes a number of bytes from the beginning of the array

   - parameter amount: How many bytes to remove
  */
  @discardableResult
  mutating func shift(by amount: Int) -> ArraySlice<Element> {
    let removed = self[0 ..< amount]
    self.replaceSubrange(0 ..< amount, with: EmptyCollection())
    return removed
  }

}

extension Double {

  /**
   Creates a Double with bytes in big-endian format

   - parameter bytes: Bytes to make into Double
  */
  init(bytes: [UInt8]) {
    let bigEndian = bytes.withUnsafeBufferPointer {
      $0.baseAddress!.withMemoryRebound(to: UInt64.self, capacity: bytes.count) {
        $0.pointee
      }
    }
    self.init(bitPattern: UInt64(bigEndian: bigEndian))
  }

}

extension Int {

  /**
   Creates an Int with bytes in big-endian format

   - parameter bytes: Bytes to make into Int
  */
  init(bytes: [UInt8]) {
    let binary = bytes.map {
      String($0, radix: 2).pad(to: 8)
    }.joined(separator: "")
    self.init(binary, radix: 2)!
  }

}

extension String {

  /**
   Creates a String with bytes in Latin-1 format

   - parameter bytes: Bytes to make into String
  */
  init(bytes: [UInt8]) {
    let string = bytes.map {
      UnicodeScalar($0).description
    }.joined(separator: "")
    self.init(string)!
  }

  /**
   Adds 0's to the beginning of the String to create a certain bit count

   - parameter size: Bit count to create with leading 0's
  */
  func pad(to size: Int) -> String {
    var string = self
    for _ in 0 ..< size - self.characters.count {
      string = "0" + string
    }
    return string
  }

}
