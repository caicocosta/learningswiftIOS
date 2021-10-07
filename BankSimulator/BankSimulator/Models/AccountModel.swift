//
//  Conta.swift
//  BankSimulator
//
//  Created by Caico Saler Oliveira Costa on 27/09/21.
//

import Foundation

class Account{
    var userId: Int
    var number: Int
    var securityCod: Int
    var keys: [PixKeys] = []
    private var balance = 1000.0
    
    init(userId: Int) {
        self.userId = userId
        self.number = Int(arc4random_uniform(UInt32(1000)))
        self.securityCod = Int(arc4random_uniform(UInt32(100)))
    }
    
    func deposit(value: Double){
        balance += value
    }
    
    func withDraw(value: Double) -> Bool {
        if checkBalance(value: value) {
            balance -= value
            return true
        } else {
            return false
        }
    }
    
    func financialReport(){
        print("Conta: \(number), Saldo: \(balance)")
    }
    
    func registeredKeys(){
        if keys.count > 0 {
            print("###  CHAVES CADASTRADAS  ### \n")
            for keys in keys {
                print("Tipo: \(keys.type.rawValue)    Chave: \(keys.key)")
            }
        } else {
            print("Voce ainda nao possui chaves cadastradas!! ")
        }
        readLine()
    }
    
    func checkBalance(value: Double) -> Bool{
        if balance >= value {
            return true
        } else {
            return false
        }
    }
    
    
    func getBalance() -> Double {
        return balance
    }
}
