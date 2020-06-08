//
//  Array+Identifiable.swift
//  memorize
//
//  Created by sriram on 07/06/20.
//  Copyright © 2020 iWeds. All rights reserved.
//

import Foundation

extension Array where Element : Identifiable {
    func firstIndex(of item: Element) -> Int? {
        for index in 0..<self.count {
            if self[index].id == item.id {
                return index
            }
        }
        return nil
    }
}
