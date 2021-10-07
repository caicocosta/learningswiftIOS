//
//  AccountDatabase.swift
//  BankSimulator
//
//  Created by Caico Saler Oliveira Costa on 05/10/21.
//

import Foundation

class AccountDatabase{
    
    private var accounts: [Account] = []
    private var error = ""
    
    static var shared: AccountDatabase = {
        let instance = AccountDatabase()
        return instance
    }()
    
    private init() {}

    
    //Funcoes que simulam buscas no banco de dados.
    func isPresentIndex(userdId: Int) -> Int? {
        guard let index = accounts.firstIndex(where: {$0.userId == userdId}) else {return nil}
        return index
    }
    
    func isPresentNumberAccount(numberAccount: Int) -> Int? {
        guard let index = accounts.firstIndex(where: {$0.number == numberAccount}) else {return nil}
        return index
    }
    
    func isPresentNumberAccountAndUserId(numberAccount: Int, userId: Int) -> Int? {
        guard let index = accounts.firstIndex(where: {$0.number == numberAccount && $0.userId == userId}) else {return nil}
        return index
    }
    
    func isPresentKey(typeKey: typeKeys, key: String) -> Int? {
        guard let index = accounts.firstIndex(where: {$0.keys.contains(where: {$0.type == typeKey && $0.key == key})}) else {return nil}
        return index
    }
    
   
    //Funcoes para realizar alteracoes no banco
    func addAccount(account: Account) {
        accounts.append(account)
    }
    
    func addPixKeys(index: Int, pixKey: PixKeys) -> Response {
        if accounts[index].keys.contains(where: {$0.key == pixKey.key}) || accounts[index].keys.contains(where: {$0.type == pixKey.type}) {
            error = "already registered"
            return Response(status: false, cod: .ALREADY_REGISTERED, message: error)
        }
        accounts[index].keys.append(pixKey)
        return Response(status: true, cod: .NO_ERROR, message: "SUCCESS")
    }
    
    func deposit(numberAccount: Int, value: Double) -> Bool {
        guard let index = isPresentNumberAccount(numberAccount: numberAccount) else {return false}
        accounts[index].deposit(value: value)
        return true
    }
    
    func withDraw(userLoggedIn: Int, value: Double) -> Response {
        guard let index = isPresentIndex(userdId: userLoggedIn) else {
            return Response(status: false, cod: .NOT_FOUND, message: "User not_found")
            
        }
        if accounts[index].withDraw(value: value) {
            return Response(status: true, cod: .NO_ERROR, message: "SUCCESS")
        }
        return Response(status: false, cod: .GENERIC_ERROR, message: "Saldo Insuficiente")
    }
    
    func transfer(userId: Int, numberAccountDestine: Int, value: Double) -> Response {
        guard let indexOriginAccount = isPresentIndex(userdId: userId) else {
            error = "Usuário não possui conta cadastrada"
            return Response(status: false, cod: .NOT_FOUND, message: error)
        }
        
        guard let indexDestineAccount = isPresentNumberAccount(numberAccount: numberAccountDestine) else {
            error = "Conta de destindo nao cadastrada"
            return Response(status: false, cod: .NOT_FOUND, message: error)
        }
     
        if !accounts[indexOriginAccount].withDraw(value: value) {
            return Response(status: false, cod: .GENERIC_ERROR, message: "Saldo Insuficiente")
        }
        accounts[indexDestineAccount].deposit(value: value)
        return Response(status: true, cod: .NO_ERROR, message: "SUCCESS")
    }
    
    func payWithPix(userId: Int, typekey: typeKeys, key: String, value: Double) -> Response {
        guard let indexOriginAccount = isPresentIndex(userdId: userId) else {
            error = "Usuário não possui conta cadastrada"
            return Response(status: false, cod: .NOT_FOUND, message: error)
        }
        
        guard let indexDestineAccount = isPresentKey(typeKey: typekey, key: key) else {
            error = "Conta de destindo nao cadastrada"
            return Response(status: false, cod: .NOT_FOUND, message: error)
        }
        
        if !accounts[indexOriginAccount].withDraw(value: value) {
            return Response(status: false, cod: .GENERIC_ERROR, message: "Saldo Insuficiente")
        }
        accounts[indexDestineAccount].deposit(value: value)
        return Response(status: true, cod: .NO_ERROR, message: "SUCCESS")
    }
    
    func deleteAccount(index: Int){
        guard let userIndex = UserDatabase.shared.IsPresentIdentifierIndex(userId: accounts[index].userId) else {return}
        UserDatabase.shared.deleteUser(index: userIndex)
        accounts.remove(at: index)
    }
   
    //Funcoes de relatórios
    func registeredKeys(userLoggedIn: Int) -> [PixKeys]? {
        
        guard let index = isPresentIndex(userdId: userLoggedIn) else {return nil}
        
        if accounts[index].keys.count > 0 {
            return accounts[index].keys
        }
        return nil
    }
    
    func balanceReport(userLoggedIn: Int) -> (userName: String, account: Int, balance: Double)?{
        guard let index = isPresentIndex(userdId: userLoggedIn) else {return nil}
        guard let user = UserDatabase.shared.IsPresentIdentifier(userId: userLoggedIn) else {return nil}
        let balance = accounts[index].getBalance()
        return (user.name, accounts[index].number, balance)
    }
}
