//
//  Users.swift
//  BankSimulator
//
//  Created by Caico Saler Oliveira Costa on 29/09/21.
//

import Foundation

class Users {
    var identifier: Int = 0
    var name: String
    var lastName: String
    var btDate: String
    var document: String
    var login: String
    var password: String
    
    init(identifier: Int, name: String, lastName: String, btDate: String, document: String, login: String, password: String) {
        self.identifier = identifier
        self.name = name
        self.lastName = lastName
        self.btDate = btDate
        self.document = document
        self.login = login
        self.password = password
    }
}
