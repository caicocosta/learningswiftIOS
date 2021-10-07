//
//  UsersController.swift
//  BankSimulator
//
//  Created by Caico Saler Oliveira Costa on 30/09/21.
//

import Foundation

class Usercontroller {
    let stringValidators = StringValidators()
    let retype = Retype()
    let minCh = 5
    
    func createUser(name: String, lastName: String, btDate: String, document: String, login: String, password: String) -> String{
        
        let user = Users(identifier: accounts.count + 1, name: name, lastName: lastName, btDate: btDate, document: document, login: login, password: password)
        
        let isValid = stringValidators.minCharacter(text: [name, lastName], minCh: minCh)
        if !isValid.status {
            print("----- Dados preenchidos incorretamente, o \(isValid.text) precisa ter no mínimo \(minCh) -----")
            readLine()
            return ""
        }
        
        if !user.document.isCPF {
            print("----- O CPF informado e invalido -----")
            readLine()
            //user.document = retype.retyping(str: "Digite o CPF novamente: ") ?? ""
            return ""
        }

        
        let result = UserDatabase.shared.addUser(user: user)
        if result.status {
            let account = Account(userId: user.identifier)
            AccountDatabase.shared.addAccount(account: account)
            return user.login
        } else {
            print("Houve um erro ao tentar cadastrar o usuário: \(result.msg) \n\n\n")
            readLine()
        }
        return ""
    }
    
    func login(user: String, password: String) -> Int{
        guard let user = UserDatabase.shared.IsPresent(login: user) else {
                print("Usuario ou senha inválido")
                return 0
            }
        if user.password == password {
            return user.identifier
        } else {
            print("Usuario ou senha invalido")
            return 0
        }
    }
}
