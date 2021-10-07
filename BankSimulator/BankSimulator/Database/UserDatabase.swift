//
//  UserDatabase.swift
//  BankSimulator
//
//  Created by Caico Saler Oliveira Costa on 05/10/21.
//

import Foundation

class UserDatabase {
    
    private var users: [Users] = []
    private var error = ""
    
    static var shared: UserDatabase = {
        let instance = UserDatabase()
        return instance
    }()
    
    private init() {}
    
    func addUser(user: Users) -> (status: Bool, cod: DataBaseErrors, msg: String) {
        //Aqui estou criando as validacoes simulando o funcionamento de um banco, nao permitindo chaves primarias duplicadas, e nem permitindo nulo.
        
        if users.contains(where: {$0.document == user.document}) {
            error = "already registered"
            return (false, .ALREADY_REGISTERED, error)
        } else if user.name.isEmpty || user.lastName.isEmpty || user.password.isEmpty {
            error = "unfilled fields"
            return (false, .UNFILLED_FIELDS, error)
        }
        users.append(user)
        return (true, .NO_ERROR, "")
    }
    
    func IsPresent(login: String) -> Users? {
        guard let index = users.firstIndex(where: {$0.document == login}) else {return nil}
        return users[index]
    }
    
}
