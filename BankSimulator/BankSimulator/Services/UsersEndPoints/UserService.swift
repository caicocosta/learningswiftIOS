//
//  UserService.swift
//  BankSimulator
//
//  Created by Caico Saler Oliveira Costa on 10/10/21.
//

import Foundation

struct UserService {
    private var config = Config()
    private var utils = Utils()
    private var api = API()
    private let resource = "/users"
    
    func save(user: Users){
        // prepare json data
        let json: [String: AnyHashable] = ["identifier": user.identifier,
                                   "name": user.name,
                                   "lastname": user.lastName,
                                   "btdate": user.btDate,
                                   "document": user.document,
                                   "login": user.login,
                                   "password": user.password]

        api.post(json: json, resource: resource)
    }
    
    func loadUsers(){
        api.get(resource: resource){
            (result, erro)  in
              if(result != nil) {
                let userDTO = self.utils.parseJsonToUserDTO(json: result!)
                for dto in userDTO {
                    let newUser = Users(identifier: dto.identifier, name: dto.name, lastName: dto.lastname, btDate: dto.btdate, document: dto.document, login: dto.login, password: dto.password)
                    UserDatabase.shared.importUsers(user: newUser)
                }
                
              } else {
                  print("A requisicao nao funcionou")
              }
        }
    }
}
