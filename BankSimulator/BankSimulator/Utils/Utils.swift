//
//  Utils.swift
//  BankSimulator
//
//  Created by Caico Saler Oliveira Costa on 08/10/21.
//

import Foundation

struct Utils {
    func parseJsonToUserDTO(json: Data) -> [userDTO] {
        var usersDTOs = [userDTO]()
        let decoder = JSONDecoder()
        if let jsonUsers = try? decoder.decode(UsersDTOs.self, from: json) {
            usersDTOs = jsonUsers.users
        }
        return usersDTOs
    }
}