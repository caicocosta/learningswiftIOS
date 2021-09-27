//
//  Conta.swift
//  BankSimulator
//
//  Created by Caico Saler Oliveira Costa on 27/09/21.
//

import Foundation

class Account{
    var name: String
    var btDate: String
    var document: String
    var number: Int
    var securityCod: Int
    private var balance = 0.0
    
    init(name: String, btDate: String, document: String) {
        self.name = name
        self.btDate = btDate
        self.document = document
        self.number = Int(arc4random_uniform(UInt32(1000)))
        self.securityCod = Int(arc4random_uniform(UInt32(100)))
    }
    
    func deposit(value: Double){
        balance += value
    }
    
    func withDraw(value: Double){
        if balance >= value {
            balance -= value
        } else {
            print("Saldo insuficiente")
        }
    }
    
    func financialReport(){
        print("Conta: \(number), Nome: \(name), DtNasc: \(btDate), Saldo: \(balance)")
    }
    
    func payWithPix(originAccount: Int, destineAccount: Int, value: Double) {
        if accounts[originAccount].balance >= value {
            accounts[originAccount].balance -= value
            accounts[destineAccount].balance += value
        } else {
            print("Saldo insuficiente")
        }
    }
}
