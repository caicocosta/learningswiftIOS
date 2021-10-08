//
//  Menu.swift
//  BankSimulator
//
//  Created by Caico Saler Oliveira Costa on 07/10/21.
//

import Foundation

class Menu {
    var viewAccount = AccountView()
    var viewUser = UserView()
    private var userLoggedIn = 0
    private var user = ""

    func menu(){
        var option = 0
        var repeate =  true
        
        guard let userLogged = UserDatabase.shared.IsPresent(login: String(user)) else {
            
            print("Houve ume erro fatal ao tentar abrir o menu, por favor repetir o processo de cadastro.")
            return
            
        }
        
        userLoggedIn = userLogged.identifier
        
        while repeate {
            print("######   Seja bem-vindo \(userLogged.name) ao seu ambiente de contas   ###### \n")
            print("1 - Cadastrar chaves pix: ")
            print("2 - Depositar em conta: ")
            print("3 - Sacar da conta: ")
            print("4 - Transferencia entre contas: ")
            print("5 - Pagar com o Pix: ")
            print("6 - Imprimir saldo")
            print("7 - Imprimir chaves cadastradas no pix: ")
            print("8 - Excluir conta: ")
            print("0 - Sair ")
            if let op = readLine() {
                option = Int(op) ?? 0
            }
            switch option {
                case 1:
                    viewAccount.addPixKey(userLoggedIn: userLoggedIn)
                case 2:
                    viewAccount.deposit()
                case 3:
                    viewAccount.withDraw(userLoggedIn: userLoggedIn)
                case 4:
                    viewAccount.transfer(userLoggedIn: userLoggedIn)
                case 5:
                    viewAccount.payWithPix(userLoggedIn: userLoggedIn)
                case 6:
                    viewAccount.balance(userLoggedIn: userLoggedIn)
                case 7:
                    viewAccount.keysRegistered(userLoggedIn: userLoggedIn)
                case 8:
                    viewAccount.deleteAccount(login: user, userLoggedIn: userLoggedIn)
                case 0:
                    repeate = false
                default:
                    print("Voce precisa digitar um numero correspodente as acoes")
            }
        }
    }

    func firstMenu() {
        var option = 0
        var repeate =  true
        
        while repeate {
            print("###### Seja bem-vindo ao Bank Simulator ###### ")
            print("1 - Cadastrar uma nova conta ")
            print("2 - Fazer login ")
            print("0 - Sair do aplicativo")
            if let op = readLine() {
                option = Int(op) ?? 0
            }
            
            switch option {
                case 1:
                    user = viewUser.createUser()
                    if user != "" {
                        menu()
                    }
                case 2:
                    user = viewUser.login()
                    if user != "" {
                        menu()
                    }
                case 0:
                    print("Saindo do app")
                    repeate = false
                    break
                default:
                    print("Voce precisa digitar um numero correspodente as acoes")
            }
        }
        
    }

    func populabanco(){
        let user = Users(identifier: 1, name: "CAICO", lastName: "COSTA", btDate: "01/01/2000", document: "123", login: "123", password: "123")
        let user2 = Users(identifier: 2, name: "GABI", lastName: "COSTA", btDate: "01/01/2000", document: "321", login: "321", password: "321")
        
        let account = Account(userId: 1)
        let account2 = Account(userId: 2)
        
        UserDatabase.shared.addUser(user: user)
        UserDatabase.shared.addUser(user: user2)
        
        AccountDatabase.shared.addAccount(account: account)
        AccountDatabase.shared.addAccount(account: account2)
    }

}
