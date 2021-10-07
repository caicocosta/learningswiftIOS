//
//  AccountDatabase.swift
//  BankSimulator
//
//  Created by Caico Saler Oliveira Costa on 05/10/21.
//

import Foundation

class AccountDatabase{
    
    private var accounts: [Account] = []
    private var error = ""
    
    static var shared: AccountDatabase = {
        let instance = AccountDatabase()
        return instance
    }()
    
    func addAccount(account: Account) {
        accounts.append(account)
    }
    
    func isPresentIndex(userdId: Int) -> Int? {
        guard let index = accounts.firstIndex(where: {$0.userId == userdId}) else {return nil}
        return index
    }
    
    func addPixKeys(index: Int, pixKey: PixKeys) -> (status: Bool, cod: DataBaseErrors, msg: String) {
        if accounts[index].keys.contains(where: {$0.type == pixKey.type}) {
            error = "already registered"
            return (false, .ALREADY_REGISTERED, error)
        } else if accounts[index].keys.contains(where: {$0.key == pixKey.key}) {
            error = "already registered"
            return (false, .UNFILLED_FIELDS, error)
        }
        accounts[index].keys.append(pixKey)
        return (true, .NO_ERROR, "")
    }
    
    func registeredKeys(userLoggedIn: Int) -> [PixKeys]? {
        
        guard let index = isPresentIndex(userdId: userLoggedIn) else {return nil}
        
        if accounts[index].keys.count > 0 {
            return accounts[index].keys
        }
        return nil
    }
}
