//
//  UserView.swift
//  BankSimulator
//
//  Created by Caico Saler Oliveira Costa on 30/09/21.
//

import Foundation

class UserView {
    
    private var userController = Usercontroller()
    
    func createUser() -> String {
        var repeate = true
        var name = ""
        var lastName = ""
        var btDate = ""
        var document = ""
        var password = ""
        
        while repeate {
            print("Digite o seu primeiro nome: ")
            guard let str = readLine() else {return ""}
            name = str
            if name.count < 5 {
                print("----- O primeiro nome precisa ter no mínimo 5 caracteres! -----\n")
            } else {
                repeate = false
            }
        }
        
        print("Digite o seu sobrenome: ")
        if let str = readLine() {
            lastName = str
        }
        print("Digite sua data de nascimento: ")
        if let str = readLine() {
            btDate = str
        }
        print("Digite o seu CPF: ")
        if let str = readLine() {
            document = str
        }
        print("Digite a sua senha: ")
        if let str = readLine() {
            password = str
        }
        
        let user = userController.createUser(name: name, lastName: lastName, btDate: btDate, document: document, login: document, password: password)
        return user
    }
    
    func login() -> Int {
        var user = ""
        var password = ""
        print("Digite o seu usuario: ")
        if let str = readLine() {
            user = str
        }
        print("Digite a sua senha: ")
        if let str = readLine() {
            password = str
        }
        
        let userLoggedIn = userController.login(user: user, password: password)
        return userLoggedIn
    }
}
