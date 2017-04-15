//
//  Utils.swift
//  Swirl
//
//  Created by Alejandro Alonso
//  Copyright © 2017 Alejandro Alonso. All rights reserved.
//

extension Array {

  @discardableResult
  mutating func shift(by amount: Int) -> ArraySlice<Element> {
    let removed = self[0 ..< amount]
    self.replaceSubrange(0 ..< amount, with: EmptyCollection())
    return removed
  }

}

extension Double {

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

  init(bytes: [UInt8]) {
    let binary = bytes.map {
      String($0, radix: 2).pad(to: 8)
    }.joined(separator: "")
    self.init(binary, radix: 2)!
  }

}

extension String {

  init(bytes: [UInt8]) {
    let string = bytes.map {
      UnicodeScalar($0).description
    }.joined(separator: "")
    self.init(string)!
  }

  func pad(to size: Int) -> String {
    var string = self
    for _ in 0 ..< size - self.characters.count {
      string = "0" + string
    }
    return string
  }

}
