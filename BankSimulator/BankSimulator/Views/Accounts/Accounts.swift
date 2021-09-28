//
//  Accounts.swift
//  BankSimulator
//
//  Created by Caico Saler Oliveira Costa on 27/09/21.
//

import Foundation

class AccountView {
    
    private var accountController = AccountsController()

    func createAccount(){

        var name = ""
        var btDate = ""
        var document = ""
        
        print("######Seja bem-vindo ao Bank Simulator, o que deseja fazer? ")
        print("Digite o seu nome: ")
        if let str = readLine() {
            name = str
        }
        print("Digite sua data de nascimento: ")
        if let str = readLine() {
            btDate = str
        }
        print("Digite o seu cpf: ")
        if let str = readLine() {
            document = str
        }
        
        let account = Account(name: name, btDate: btDate, document: document)
        accountController.createAccount(account: account)
    }
    
    func deposit(){
        var numberAccount = 0
        var value = 0.0
        print("Digite o numero da conta que deseja depositar: ")
        if let str = readLine() {
            numberAccount = Int(str) ?? 0
        }
        print("Digite o valor do deposito: ")
        if let str = readLine() {
            value = Double(str) ?? 0.0
        }
        
        accountController.deposit(numberAccount: numberAccount, value: value)
    }
    
    func withDraw(){
        var numberAccount = 0
        var value = 0.0
        print("Digite o numero da conta que deseja sacar: ")
        if let str = readLine() {
            numberAccount = Int(str) ?? 0
        }
        print("Digite o valor do saque: ")
        if let str = readLine() {
            value = Double(str) ?? 0.0
        }
        
        accountController.withDraw(numberAccount: numberAccount, value: value)
    }
    
    func payWithPix(){
        var numberOriginAccount = 0
        var numberDestineAccount = 0
        var value = 0.0
        print("Digite o numero da conta que de origem: ")
        if let str = readLine() {
            numberOriginAccount = Int(str) ?? 0
        }
        print("Digite o numero da conta que de destino: ")
        if let str = readLine() {
            numberDestineAccount = Int(str) ?? 0
        }
        print("Digite o valor do pagamento: ")
        if let str = readLine() {
            value = Double(str) ?? 0.0
        }
        
        accountController.payWithPix(numberOriginAccount: numberOriginAccount, numberDestineAccount: numberDestineAccount, value: value)
    }
    
    func deleteAccount(){
        var numberAccount = 0
        print("Digite o numero da conta que deseja excluir: ")
        if let str = readLine() {
            numberAccount = Int(str) ?? 0
        }
        
        accountController.deleteAccount(numberAccount: numberAccount)
    }
}
