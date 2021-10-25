//
//  AccountService.swift
//  BankSimulator
//
//  Created by Caico Saler Oliveira Costa on 10/10/21.
//

import Foundation

struct AccountService {
    private var config = Config()
    private var utils = Utils()
    private var api = API()
    private let resource = "/account"
    
    
    func save(account: Account){
        // prepare json data
        let json: [String: Any] = ["userid": account.userId,
                                   "number": account.number,
                                   "securityCod": account.securityCod,
                                   //"keys": account.keys,
                                   "balance": account.getBalance()]

        api.post(json: json, resource: resource)

    }
    
    func loadAccounts(){
        api.get(resource: resource){
            (result, erro)  in
              if(result != nil) {
                let accountDTO = self.utils.parseJsonToAccountDTO(json: result!)
                dtoToAccount(accountDTO: accountDTO)
              } else {
                  print("A requisicao nao funcionou")
              }
        }

    }
    
    func update(account: Account) {
//        var keys: [PixKeyDTO] = []
//        for key in account.keys {
//            let keyDTO = PixKeyDTO(type: key.type, userid: key.userId, key: key.key)
//            keys.append(keyDTO)
//        }
        let json: [String: Any] = ["userid": account.userId,
                                   "number": account.number,
                                   "securityCod": account.securityCod,
                                   //"keys": account.keys,
                                   "balance": account.getBalance()]

        api.put(json: json, resource: resource + "/\(account.id)")
    }
    
    func dtoToAccount(accountDTO: [AccountDTO]){
        var typeKey: typeKeys = .UNKNOWN
        for dto in accountDTO {
            let newAccount = Account(id: Int(dto.id) ?? 0, userId: dto.userid, number: dto.number, securityCod: dto.securityCod)
            newAccount.deposit(value: dto.balance)
            for dtoKey in dto.keys {
                switch dtoKey.typekey {
                    case "EMAIL":
                        typeKey = .EMAIL
                    case "CELPHONE":
                        typeKey = .CELPHONE
                    case "DOCUMENT":
                        typeKey = .DOCUMENT
                    default:
                        typeKey = .UNKNOWN
                }
                let key = PixKeys(type: typeKey, userId: dtoKey.userid, key: dtoKey.key)
                newAccount.keys.append(key)
            }
            AccountDatabase.shared.importAccounts(account: newAccount)
        }
    }
}
