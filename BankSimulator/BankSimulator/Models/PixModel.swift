//
//  PixModel.swift
//  BankSimulator
//
//  Created by Caico Saler Oliveira Costa on 30/09/21.
//

import Foundation

enum typeKeys: String {
    case UNKNOWN = "DESCONHECIDO", EMAIL = "EMAIL", CELPHONE = "CELULAR", DOCUMENT = "CPF/CNPJ"
}

class PixKeys {
    var type: typeKeys
    var userId: Int
    var key: String
    
    init(type: typeKeys, userId: Int, key: String) {
        self.type = type
        self.userId = userId
        self.key = key
    }
}
