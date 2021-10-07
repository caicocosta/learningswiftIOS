//
//  UserDatabase.swift
//  BankSimulator
//
//  Created by Caico Saler Oliveira Costa on 05/10/21.
//

import Foundation

class UserDatabase {
    
    private var users: [Users] = []
    private var error = ""
    
    static var shared: UserDatabase = {
        let instance = UserDatabase()
        return instance
    }()
    
    private init() {}
    
    //Funcoes que simulam uma busca no banco
    func lastIdentifier() -> Int {
        return users.count
    }
    
    func IsPresent(login: String) -> Users? {
        guard let index = users.firstIndex(where: {$0.document == login}) else {return nil}
        return users[index]
    }
    
    func IsPresentIdentifier(userId: Int) -> Users? {
        guard let index = users.firstIndex(where: {$0.identifier == userId}) else {return nil}
        return users[index]
    }
    
    func IsPresentIdentifierIndex(userId: Int) -> Int? {
        guard let index = users.firstIndex(where: {$0.identifier == userId}) else {return nil}
        return index
    }
    
    
    //Funcoes para realizar alteracao no banco
    func addUser(user: Users) -> Response {
        //Aqui estou criando as validacoes simulando o funcionamento de um banco, nao permitindo chaves primarias duplicadas, e nem permitindo nulo.
        
        if users.contains(where: {$0.document == user.document}) {
            error = "already registered"
            return Response(status: false, cod: .ALREADY_REGISTERED, message: error)
        } else if user.name.isEmpty || user.lastName.isEmpty || user.password.isEmpty {
            error = "unfilled fields"
            return Response(status: false, cod: .UNFILLED_FIELDS, message: error)
        }
        users.append(user)
        return Response(status: true, cod: .NO_ERROR, message: "SUCCESS")
    }
    
    func deleteUser(index: Int) {
        users.remove(at: index)
    }
    
}
