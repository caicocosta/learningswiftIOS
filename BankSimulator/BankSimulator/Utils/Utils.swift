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
    
    func parseJsonToAccountDTO(json: Data) -> [AccountDTO] {
        var accountsDTOs = [AccountDTO]()
        let decoder = JSONDecoder()
        if let jsonAccounts = try? decoder.decode(AccountsDTO.self, from: json) {
            accountsDTOs = jsonAccounts.accounts
        }
        return accountsDTOs
    }
    
    func parseDictionaryToData(dic: [String: Any]) -> Data {
        var data: Data?
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: dic, options: .prettyPrinted)
            // here "jsonData" is the dictionary encoded in JSON data

            data = jsonData
        } catch {
            print(error.localizedDescription)
        }
        return data!
    }
}
