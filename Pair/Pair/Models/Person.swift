//
//  Person.swift
//  Pair
//
//  Created by Natalie Hall on 9/18/21.
//

import Foundation

class Person: Codable {
    var person: String
    var uuid: String
    
    init(person: String, uuid: String = UUID().uuidString) {
        self.person = person
        self.uuid = uuid
    }
    
}  // End of Class

extension Person: Equatable {
    static func == (lhs: Person, rhs: Person) -> Bool {
        return lhs.uuid == rhs.uuid
    }
}
