//
//  UsersController.swift
//  BankSimulator
//
//  Created by Caico Saler Oliveira Costa on 30/09/21.
//

import Foundation

class Usercontroller {
    
    func createUser(name: String, lastName: String, btDate: String, document: String, login: String, password: String) -> Int{
        
        let user = Users(identifier: accounts.count + 1, name: name, lastName: lastName, btDate: btDate, document: document, login: login, password: password)
        users.append(user)
        let account = Account(userId: user.identifier)
        accounts.append(account)
        return user.identifier
    }
    
    func login(user: String, password: String) -> Int{
        if let index = users.firstIndex(where: {$0.login == user}) {
            if users[index].password == password {
                return users[index].identifier
            } else {
                print("Usuario ou senha inválido")
                return 0
            }
        } else {
            print("Usuario ou senha invalido")
            return 0
        }
    }
}
