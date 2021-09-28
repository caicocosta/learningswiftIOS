//
//  main.swift
//  BankSimulator
//
//  Created by Caico Saler Oliveira Costa on 27/09/21.
//

import Foundation

var accounts = [Account]()
var viewAccount = AccountView()
menu()

func menu(){
    var option = 0
    var repeate =  true

    while repeate {
        print("######Seja bem-vindo ao ambiente de contas###### ")
        print("1 - Cadastrar conta: ")
        print("2 - Depositar em conta: ")
        print("3 - Sacar da conta: ")
        print("4 - Pagar com Pix: ")
        print("5 - Excluir conta: ")
        print("6 - Imprimir contas cadastradas")
        print("0 - Sair ")
        if let op = readLine() {
            option = Int(op) ?? 0
        }
        switch option {
            case 1:
                viewAccount.createAccount()
            case 2:
                viewAccount.deposit()
            case 3:
                viewAccount.withDraw()
            case 4:
                viewAccount.payWithPix()
            case 5:
                viewAccount.deleteAccount()
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
            case 0:
                repeate = false
            default:
                print("Voce precisa digitar um numero correspodente as acoes")
        }
    }
}
