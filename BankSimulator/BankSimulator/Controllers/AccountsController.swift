//
//  AccountsController.swift
//  BankSimulator
//
//  Created by Caico Saler Oliveira Costa on 27/09/21.
//

import Foundation

class AccountsController {
    
    func createAccount(account: Account){
        accounts.append(account)
    }
    
    func deposit(numberAccount: Int, value: Double) {            
        if numberAccount != 0 && value >= 0.0 {
            if let index = accounts.firstIndex(where: {$0.number == numberAccount}) {
                print("---REALIZANDO DEPOSITO NA CONTA DE: \(accounts[index].userId)")
                accounts[index].deposit(value: value)
            } else {
                print("Conta nao cadastrada")
            }
        } else {
            print("Deposito cancelado")
        }
        
        readLine()
    }

    func withDraw(userLoggedIn: Int, value: Double){
        if userLoggedIn != 0 && value >= 0.0 {
            if let index = accounts.firstIndex(where: {$0.userId == userLoggedIn}) {
                print("---REALIZANDO SAQUE NA CONTA DE: \(accounts[index].userId)")
                accounts[index].withDraw(value: value)
            } else {
                print("Conta nao cadastrada")
            }
        } else {
            print("Saque cancelado")
        }
        
        readLine()
    }
    
    func transfer(userId: Int, numberDestineAccount: Int, value: Double){
        var userName = ""
        var userNameDestine = ""
        
        if let index = users.firstIndex(where: {$0.identifier == userId}) {
            userName = users[index].name
        }
    
        if userId != 0, numberDestineAccount != 0, value >= 0.0 {
            if let indexOriginAccount = accounts.firstIndex(where: {$0.userId == userId}) {
                if let indexDestineAccount = accounts.firstIndex(where: {$0.number == numberDestineAccount}) {
                    if let index = users.firstIndex(where: {$0.identifier == accounts[indexDestineAccount].userId}) {
                        userNameDestine = users[index].name
                    }
                    print("---TRANSFERINDO SALDO DA CONTA DE: \(userName), PARA A CONTA DE: \(userNameDestine)")
                    accounts[indexOriginAccount].transfer(originAccount: indexOriginAccount, destineAccount: indexDestineAccount, value: value)
                } else {
                    print("Conta de destindo nao cadastrada")
                }
            } else {
                print("Conta de origem nao cadastrada")
            }
        } else {
            print("Saque cancelado")
        }
        
        readLine()
    }
    
    func deleteAccount(numberAccount: Int){
        var op = ""
        if numberAccount != 0 {
            if let index = accounts.firstIndex(where: {$0.number == numberAccount}) {
                print("Tem certeza que deseja excluir a conta de: Nome: \(accounts[index].userId), Numero: \(accounts[index].number)\n [S] || [N]")
                if let answer = readLine() {
                    op = answer.uppercased()
                    if op == "S" {
                        print("Excluindo conta!!")
                        accounts.remove(at: index)
                    } else {
                        print("Exclusao cancelada")
                    }
                }
            } else {
                print("Conta nao cadastrada")
            }
        } else {
            print("Exclusao cancelada")
        }
        
    }
    
    func addPixeKey(userLoggedIn: Int, typeKey: typeKeys, key: String) {
        
        let pixKey = PixKeys(type: typeKey, userId: userLoggedIn, key: key)
        if let index = accounts.firstIndex(where: {$0.userId == userLoggedIn}) {
            accounts[index].keys.append(pixKey)
        }
        
    }
    
    func payWithPix(userLoggedIn: Int, typeKey: typeKeys, key: String, value: Double){
        var userNameDestine = ""
        if key != "" && value > 0 {
            if let indexOrigin = accounts.firstIndex(where: {$0.userId == userLoggedIn}) {
                if let indexDestine = accounts.firstIndex(where: {$0.keys.contains(where: {$0.type == typeKey && $0.key == key})}) {
                    if let index = users.firstIndex(where: {$0.identifier == accounts[indexDestine].userId}) {
                        userNameDestine = users[index].name
                    }
                    print("---REALIZANDO PAGAMENTO PARA A CONTA DE : \(userNameDestine), NO VALOR DE: \(value)")
                    accounts[indexOrigin].payWithPix(indexOrigin: indexOrigin, indexDestine: indexDestine, value: value)
                }
            }
        }
        
    }

}

