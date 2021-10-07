//
//  Accounts.swift
//  BankSimulator
//
//  Created by Caico Saler Oliveira Costa on 27/09/21.
//

import Foundation

class AccountView {
    
    private var accountController = AccountsController()
    
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
    
    func deleteAccount(login: String, userLoggedIn: Int){
        var numberAccount = 0
        print("Confirme o numero da sua conta: ")
        if let str = readLine() {
            numberAccount = Int(str) ?? 0
        }
        
        accountController.deleteAccount(login: login, userLoggedIn: userLoggedIn, numberAccount: numberAccount)
    }
    
    func addPixKey(userLoggedIn: Int) {
        var op = 0
        var typeKey: typeKeys = .UNKNOWN
        var key = ""
        var repeate = true
        
        while repeate {
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
                    repeate = false
                case 2:
                    typeKey = .CELPHONE
                    repeate = false
                case 3:
                    typeKey = .DOCUMENT
                    repeate = false
                default:
                    print("Selecione uma das opcoes informadas")
            }
        }

        repeate = true
        while repeate {
            print("Digite um \(typeKey.rawValue) que deseja cadastrar")
            if let str = readLine() {
                key = str
            }
            
            switch typeKey {
                case .EMAIL:
                    if !key.isValidEmail(key){
                        print("----- Por favor informe um e-mail válido. -----\n")
                    } else {
                        repeate = false
                    }
                case .CELPHONE:
                    if !key.isValidPhoneNumber(key){
                        print("----- Por favor informe um telefone válido. Ex. 00000-0000-----")
                    } else {
                        repeate = false
                    }
                default:
                    repeate = false
            }
            
        }
        
        accountController.addPixeKey(userLoggedIn: userLoggedIn, typeKey: typeKey, key: key)
    }
    
    func payWithPix(userLoggedIn: Int){
        var op = 0
        var typeKey: typeKeys = .UNKNOWN
        var key = ""
        var value = 0.0
        var repeate = true
        
        while repeate {
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
                    repeate = false
                case 2:
                    typeKey = .CELPHONE
                    repeate = false
                case 3:
                    typeKey = .DOCUMENT
                    repeate = false
                default:
                    print("Selecione uma das opcoes informadas")
            }
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
        print("\n\n### Chaves Cadastradas ###\n\n")
        accountController.keysRegistered(userLoggedIn: userLoggedIn)
    }
    
    func balance(userLoggedIn: Int){
        guard let balance = accountController.balance(userLoggedIn: userLoggedIn) else {return}
        print("\n\n**** Saldo da conta \(balance.userName) ****\n\n")
        print("Conta: \(balance.account),   Saldo: \(balance.balance)\n\n")
        readLine()
    }
}
