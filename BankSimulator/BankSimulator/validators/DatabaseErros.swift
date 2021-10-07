//
//  DatabaseErros.swift
//  BankSimulator
//
//  Created by Caico Saler Oliveira Costa on 06/10/21.
//

import Foundation

enum DataBaseErrors {
    case NO_ERROR
    case ALREADY_REGISTERED
    case UNFILLED_FIELDS
    case NOT_FOUND
    case GENERIC_ERROR
}

struct Response {
    var status: Bool
    var cod: DataBaseErrors
    var message: String
}
