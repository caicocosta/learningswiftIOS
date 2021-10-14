//
//  AccountsController.swift
//  BankSimulator
//
//  Created by Caico Saler Oliveira Costa on 27/09/21.
//

import Foundation

class AccountsController {

    func deposit(numberAccount: Int, value: Double) {
        if numberAccount != 0 && value >= 0.0 {
            if AccountDatabase.shared.deposit(numberAccount: numberAccount, value: value) {
                print("**** REALIZANDO DEPOSITO EM CONTA ****")
            } else {
                print("----- CONTA NÃO ENCONTRADA -----")
            }
        } else {
            print("Deposito cancelado")
        }
        readLine()
    }

    func withDraw(userLoggedIn: Int, value: Double){
        if userLoggedIn != 0 && value >= 0.0 {
            let result = AccountDatabase.shared.withDraw(userLoggedIn: userLoggedIn, value: value)
            if result.status {
                print("**** REALIZANDO SAQUE EM CONTA ****")
            } else {
                print("----- \(result.message.uppercased()) -----")
            }
        } else {
            print("Saque cancelado")
        }
        readLine()
    }
    
    func transfer(userId: Int, numberDestineAccount: Int, value: Double){
        if userId != 0 || numberDestineAccount != 0, value >= 0.0 {
            print("\n\n **** TRANSFERINDO SALDO PARA CONTA: \(numberDestineAccount) **** \n\n")
            let result = AccountDatabase.shared.transfer(userId: userId, numberAccountDestine: numberDestineAccount, value: value)
            if !result.status {
                print("----- \(result.message.uppercased()) -----")
            }
        } else {
            print("Saque cancelado")
        }
        readLine()
    }
    
    func deleteAccount(login: String, userLoggedIn: Int, numberAccount: Int){
        var op = ""
        if numberAccount != 0 {
            guard let index = AccountDatabase.shared.isPresentNumberAccountAndUserId(numberAccount: numberAccount, userId: userLoggedIn) else {
                print("Conta não cadastrada")
                readLine()
                return
            }
            print("\nTem certeza que deseja excluir a conta do CPF: \(login), Numero: \(numberAccount)\n [S] || [N]")
            if let answer = readLine() {
               op = answer.uppercased()
               if op == "S" {
                  print("\n\n**** Excluindo conta!!\n\n")
                  AccountDatabase.shared.deleteAccount(index: index)
                  menu.firstMenu()
               } else {
                   print("Exclusao cancelada")
               }
            }
        } else {
            print("Exclusao cancelada")
        }
        readLine()
    }
    
    func addPixeKey(userLoggedIn: Int, typeKey: typeKeys, key: String) {
        
        let pixKey = PixKeys(type: typeKey, userId: userLoggedIn, key: key)
        guard let index = AccountDatabase.shared.isPresentIndex(userdId: userLoggedIn) else {return}
        let result = AccountDatabase.shared.addPixKeys(index: index, pixKey: pixKey)
        if !result.status {
            print("Houve um erro ao cadastrar a chave: \(result.message)")
        } else {
            print("Chave cadastrada com sucesso")
        }
        readLine()
    }
    
    func payWithPix(userLoggedIn: Int, typeKey: typeKeys, key: String, value: Double){
        if key != "" && value > 0 {
            print("\n\n**** REALIZANDO PAGAMENTO PARA A CONTA, NO VALOR DE: \(value) ****\n\n")
            let result = AccountDatabase.shared.payWithPix(userId: userLoggedIn, typekey: typeKey, key: key, value: value)
            if !result.status {
                print("----- \(result.message.uppercased()) -----")
            }
        } else {
            print("Pagamento cancelado")
        }
        readLine()
    }
    
    func keysRegistered(userLoggedIn: Int) {
        guard let keys = AccountDatabase.shared.registeredKeys(userLoggedIn: userLoggedIn) else {
            print("---- Nenhuma chave cadastrada ----\n\n")
            readLine()
            return
        }
        for key in keys {
            print("Tipo: \(key.type),   Chave: \(key.key)")
        }
        readLine()
    }
    
    func balance(userLoggedIn: Int) -> (userName: String, id: Int, account: Int, balance: Double)? {
        guard let result = AccountDatabase.shared.balanceReport(userLoggedIn: userLoggedIn) else {return nil}
        return (result.userName, result.id ,result.account, result.balance)
    }

}

