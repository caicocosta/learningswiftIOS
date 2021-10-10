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
    
    func save(account: Account){
        // prepare json data
        let json: [String: Any] = ["userid": account.userId,
                                   "number": account.number,
                                   "securityCod": account.securityCod,
                                   "keys": account.keys]

        // create post request
        let url = URL(string: config.baseURL + "/account")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        // insert json data to the request
        request.httpBody = try? JSONSerialization.data(withJSONObject: json, options: .fragmentsAllowed)

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            do {
                let responseJSON = try? JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                #if DEBUG
                if let responseJSON = responseJSON as? [String: Any] {
                    print(responseJSON)
                }
                #endif
            } catch {
                print(error)
            }
            
        }

        task.resume()
    }
    
    func loadAccounts(){
        let url = URL(string: config.baseURL + "/account")!
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error == nil {
                guard let jsonAccount = data else {return}
                let accountDTO = self.utils.parseJsonToAccountDTO(json: jsonAccount)
                dtoToAccount(accountDTO: accountDTO)
            } else {
                print("---- ERRO -----")
                print(error ?? "")
            }
        }
        
        task.resume()
                
//        userProvider.request(.readUser) { result in
//            switch result {
//            case let .success(moyaResponse):
//                let json = try! JSONSerialization.jsonObject(with: moyaResponse.data, options: [])
//                print("IMPRIMININDO DADOS")
//                print(json)
//            case let .failure(errorAPI):
//                print("----IMPRIMINDO ERROR")
//                print(errorAPI)
//            }
//        }
    }
    
    func dtoToAccount(accountDTO: [AccountDTO]){
        var typeKey: typeKeys = .UNKNOWN
        for dto in accountDTO {
            let newAccount = Account(userId: dto.userid)
            for dtoKey in dto.keys {
                switch dtoKey.type {
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
