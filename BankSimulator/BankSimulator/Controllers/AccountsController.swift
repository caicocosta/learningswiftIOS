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
                print("---REALIZANDO DEPOSITO NA CONTA DE: \(accounts[index].name)")
                accounts[index].deposit(value: value)
            } else {
                print("Conta nao cadastrada")
            }
        } else {
            print("Deposito cancelado")
        }
        
        readLine()
    }

    func withDraw(numberAccount: Int, value: Double){
        if numberAccount != 0 && value >= 0.0 {
            if let index = accounts.firstIndex(where: {$0.number == numberAccount}) {
                print("---REALIZANDO SAQUE NA CONTA DE: \(accounts[index].name)")
                accounts[index].withDraw(value: value)
            } else {
                print("Conta nao cadastrada")
            }
        } else {
            print("Saque cancelado")
        }
        
        readLine()
    }
    
    func payWithPix(numberOriginAccount: Int, numberDestineAccount: Int, value: Double){
        if numberOriginAccount != 0, numberDestineAccount != 0, value >= 0.0 {
            if let indexOriginAccount = accounts.firstIndex(where: {$0.number == numberOriginAccount}) {
                if let indexDestineAccount = accounts.firstIndex(where: {$0.number == numberDestineAccount}) {
                    print("---TRANSFERINDO SALDO DA CONTA DE: \(accounts[indexOriginAccount].name), PARA A CONTA DE: \(accounts[indexDestineAccount].name)")
                    accounts[indexOriginAccount].payWithPix(originAccount: indexOriginAccount, destineAccount: indexDestineAccount, value: value)
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
                print("Tem certeza que deseja excluir a conta de: Nome: \(accounts[index].name), Numero: \(accounts[index].number)\n [S] || [N]")
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

}

