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
    
    func withDraw(value: Double){
        if checkBalance(value: value) {
            balance -= value
        } else {
            print("Saldo insuficiente")
        }
    }
    
    func financialReport(){
        print("Conta: \(number), Saldo: \(balance)")
    }
    
    func transfer(originAccount: Int, destineAccount: Int, value: Double) {
        if accounts[originAccount].balance >= value {
            accounts[originAccount].balance -= value
            accounts[destineAccount].balance += value
        } else {
            print("Saldo insuficiente")
        }
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
    
    func payWithPix(indexOrigin: Int, indexDestine: Int, value: Double) {
        if accounts[indexOrigin].balance >= value {
            accounts[indexOrigin].balance -= value
            accounts[indexDestine].balance += value
        } else {
            print("Saldo insuficiente")
        }
        readLine()
    }
}
