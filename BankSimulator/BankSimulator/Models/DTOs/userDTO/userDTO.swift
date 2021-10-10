//
//  userDTO.swift
//  BankSimulator
//
//  Created by Caico Saler Oliveira Costa on 08/10/21.
//

import Foundation

struct userDTO: Codable {
    var name: String
    var lastname: String
    var btdate: String
    var document: String
    var login: String
    var password: String
    var identifier: Int
}
