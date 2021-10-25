//
//  accountDTO.swift
//  BankSimulator
//
//  Created by Caico Saler Oliveira Costa on 10/10/21.
//

import Foundation

struct AccountDTO: Codable {
    var id: String
    var userid: Int
    var number: Int
    var securityCod: Int
    var balance: Double
    var keys: [PixKeyDTO]
}
