//
//  File.swift
//  
//
//  Created by Mikhail Nikanorov on 3/26/22.
//

import Foundation

public extension Sequence where Iterator.Element : Hashable {
  func intersects<S : Sequence>(with sequence: S) -> Bool where S.Iterator.Element == Iterator.Element {
    let sequenceSet = Set(sequence)
    return self.contains(where: sequenceSet.contains)
  }
}
