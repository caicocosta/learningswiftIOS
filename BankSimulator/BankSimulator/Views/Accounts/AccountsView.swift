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
        
        //let account = Account(name: name, btDate: btDate, document: document)
        //accountController.createAccount(account: account)
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
    
    func withDraw(userLoggedIn: Int){
        var value = 0.0
        print("Digite o valor do saque: ")
        if let str = readLine() {
            value = Double(str) ?? 0.0
        }
        accountController.withDraw(userLoggedIn: userLoggedIn, value: value)
    }
    
    func transfer(userLoggedIn: Int){
        var numberDestineAccount = 0
        var value = 0.0
        print("Digite o numero da conta que de destino: ")
        if let str = readLine() {
            numberDestineAccount = Int(str) ?? 0
        }
        print("Digite o valor que deve ser transferido: ")
        if let str = readLine() {
            value = Double(str) ?? 0.0
        }
        
        accountController.transfer(userId: userLoggedIn, numberDestineAccount: numberDestineAccount, value: value)
    }
    
    func deleteAccount(){
        var numberAccount = 0
        print("Confirme o numero da sua conta: ")
        if let str = readLine() {
            numberAccount = Int(str) ?? 0
        }
        
        accountController.deleteAccount(numberAccount: numberAccount)
    }
    
    func addPixKey(userLoggedIn: Int) {
        var op = 0
        var typeKey: typeKeys = .UNKNOWN
        var key = ""
        
        print("Selecione o tipo de chave que deseja adicionar: ")
        print("1: Email: ")
        print("2: Telefone: ")
        print("3: CPF/CNPJ")
        print("0: Cancelar")
        if let str = readLine() {
            op = Int(str) ?? 0
        }
        switch op {
            case 1:
                typeKey = .EMAIL
            case 2:
                typeKey = .CELPHONE
            case 3:
                typeKey = .DOCUMENT
            default:
                menu()
        }
        
        print("Digite a chave que deseja cadastrar")
        if let str = readLine() {
            key = str
        }
        
        accountController.addPixeKey(userLoggedIn: userLoggedIn, typeKey: typeKey, key: key)
    }
    
    func payWithPix(userLoggedIn: Int){
        var op = 0
        var typeKey: typeKeys = .UNKNOWN
        var key = ""
        var value = 0.0
        
        print("###  Selecione o tipo de chave que deseja pagar: ###")
        print("1: Email: ")
        print("2: Telefone: ")
        print("3: CPF/CNPJ")
        print("0: Cancelar")
        if let str = readLine() {
            op = Int(str) ?? 0
        }
        switch op {
            case 1:
                typeKey = .EMAIL
            case 2:
                typeKey = .CELPHONE
            case 3:
                typeKey = .DOCUMENT
            default:
                menu()
        }
        
        print("Digite a chave que deseja cadastrar")
        if let str = readLine() {
            key = str
        }
        
        print("Digite o valor que deseja pagar: ")
        if let str = readLine() {
            value = Double(str) ?? 0.0
        }
        accountController.payWithPix(userLoggedIn: userLoggedIn, typeKey: typeKey, key: key, value: value)
        
    }
    
    func keysRegistered(userLoggedIn: Int) {
        print("### Chaves Cadastradas ###")
        accountController.keysRegistered(userLoggedIn: userLoggedIn)
    }
}
