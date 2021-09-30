//
//  main.swift
//  BankSimulator
//
//  Created by Caico Saler Oliveira Costa on 27/09/21.
//

import Foundation

var accounts = [Account]()
var users = [Users]()
var viewAccount = AccountView()
var viewUser = UserView()
private var userLoggedIn = 0
var userNameLogged = ""
var numberAccountLogged = 0
populabanco()
firstMenu()

func menu(){
    var option = 0
    var repeate =  true
    
    while repeate {
        print("######   Seja bem-vindo \(userNameLogged) ao seu ambiente de contas   ###### \n")
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
                if accounts.count > 0 {
                    print("####CONTAS CADASTRADAS####")
                    for acc in accounts {
                        acc.financialReport()
                    }
                } else {
                    print("Nenhuma conta cadastrada")
                }
                readLine()
            case 7:
                if let account = accounts.firstIndex(where: {$0.userId == userLoggedIn}) {
                    accounts[account].registeredKeys()
                }
            case 8:
                viewAccount.deleteAccount()
            case 0:
                firstMenu()
            default:
                print("Voce precisa digitar um numero correspodente as acoes")
        }
    }
}

func firstMenu() {
    var option = 0
    var repeate =  true
    
    while repeate {
        print("######Seja bem-vindo ao Bank Simulator###### ")
        print("1 - Cadastrar uma nova conta ")
        print("2 - Fazer login ")
        print("0 - Sair do aplicativo")
        if let op = readLine() {
            option = Int(op) ?? 0
        }
        
        switch option {
            case 1:
                userLoggedIn = viewUser.createUser()
                if userLoggedIn > 0 {
                    menu()
                }
            case 2:
                userLoggedIn = viewUser.login()
                if userLoggedIn > 0 {
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

func updateUserLoggedIn(){
    if let index = accounts.firstIndex(where: {$0.userId == userLoggedIn}) {
        numberAccountLogged = accounts[index].number
    }
    
    if let index = users.firstIndex(where: {$0.identifier == userLoggedIn}) {
        userNameLogged = users[index].name
    }
    
}

func populabanco(){
    let user = Users(identifier: 1, name: "CAICO", lastName: "COSTA", btDate: "01/01/2000", document: "123", login: "123", password: "123")
    let user2 = Users(identifier: 2, name: "GABI", lastName: "COSTA", btDate: "01/01/2000", document: "321", login: "321", password: "321")
    
    let account = Account(userId: 1)
    let account2 = Account(userId: 2)
    
    users.append(user)
    users.append(user2)
    
    accounts.append(account)
    accounts.append(account2)
}
