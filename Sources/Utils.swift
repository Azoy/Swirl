//
//  Utils.swift
//  Swirl
//
//  Created by Alejandro Alonso
//  Copyright © 2017 Alejandro Alonso. All rights reserved.
//

extension Array {

  func shifted(by amount: Int) -> ArraySlice<Element> {
    return self.dropFirst(amount)
  }

}
