//
//  UsersController.swift
//  BankSimulator
//
//  Created by Caico Saler Oliveira Costa on 30/09/21.
//

import Foundation

class Usercontroller {
    let stringValidators = StringValidators()
    let minCh = 5
    
    func createUser(name: String, lastName: String, btDate: String, document: String, login: String, password: String) -> String{
        
        let user = Users(identifier: UserDatabase.shared.lastIdentifier() + 1, name: name, lastName: lastName, btDate: btDate, document: document, login: login, password: password)
        
        let isValid = stringValidators.minCharacter(text: [name, lastName], minCh: minCh)
        if !isValid.status {
            print("----- Dados preenchidos incorretamente, o \(isValid.text) precisa ter no mínimo \(minCh) -----")
            readLine()
            return ""
        }
        
        if !user.document.isCPF {
            print("----- O CPF informado e invalido -----")
            readLine()
            return ""
        }

        
        let result = UserDatabase.shared.addUser(user: user)
        if result.status {
            let account = Account(userId: user.identifier)
            AccountDatabase.shared.addAccount(account: account)
            return user.login
        } else {
            print("Houve um erro ao tentar cadastrar o usuário: \(result.message) \n\n\n")
            readLine()
        }
        return ""
    }
    
    func login(user: String, password: String) -> String {
        guard let user = UserDatabase.shared.IsPresent(login: user) else {
                print("\nUsuario ou senha inválido\n")
                readLine()
                return ""
            }
        if user.password == password {
            return user.login
        } else {
            print("\nUsuario ou senha invalido\n")
            readLine()
            return ""
        }
    }
}
