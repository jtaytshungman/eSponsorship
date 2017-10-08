//  Firebase_Eureka_Bridge.swift
//  eSponsorship
//
//  Created by Jeremy Tay on 06/10/2017.
//  Copyright © 2017 Jeremy Tay. All rights reserved.
//

import UIKit
import Eureka
import ImageRow
import FirebaseDatabase
import Firebase

public extension Form {
    public func valuesForFirebase(includeHidden: Bool = false) -> [String: Any?] {
        let rows = includeHidden ? self.allRows : self.rows
        return rows.filter({ $0.tag != nil })
            .reduce([:], { (dictionary, row) -> [String: Any?] in
                var dictionary = dictionary
                dictionary[row.tag!] = row.firebaseValue
                return dictionary
            })
    }
}

public extension Dictionary {
    func valuesForEureka(forForm form: Form) -> [String: Any?] {
        return self.reduce([:], { (dictionary, tuple) -> [String: Any?] in
            var dictionary = dictionary
            let row = form.rowBy(tag: tuple.key as! String)
            if row is SwitchRow || row is CheckRow {
                let typedValue = tuple.value as! Int
                dictionary[tuple.key as! String] = (typedValue == 1) ? true : false
            } else if row is DateRow || row is TimeRow || row is DateTimeRow {
                let typedValue = tuple.value as! TimeInterval
                dictionary[tuple.key as! String] = Date(timeIntervalSince1970: typedValue)
            } else {
                dictionary[tuple.key as! String] = tuple.value
            }
            return dictionary
        })
    }
}

private extension BaseRow {
    var firebaseValue: Any? {
        get {
            if self is SwitchRow || self is CheckRow {
                return (self.baseValue as! Bool) ? 1:0
            } else if self is DateRow || self is TimeRow || self is DateTimeRow || self is DateTimeInlineRow {
                return (self.baseValue as! Date).timeIntervalSince1970
            } else if self is ImageRow {
                return nil
            } else {
                return self.baseValue
            }
            
        }
    }
}


