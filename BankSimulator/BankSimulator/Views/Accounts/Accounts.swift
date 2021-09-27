//
//  Accounts.swift
//  BankSimulator
//
//  Created by Caico Saler Oliveira Costa on 27/09/21.
//

import Foundation

func createAccount() -> Account {

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
    return account
}
