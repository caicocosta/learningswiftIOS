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
    
    func save(user: Users){
        // prepare json data
        let json: [String: AnyHashable] = ["identifier": user.identifier,
                                   "name": user.name,
                                   "lastname": user.lastName,
                                   "btdate": user.btDate,
                                   "document": user.document,
                                   "login": user.login,
                                   "password": user.password]

        // create post request
        let url = URL(string: config.baseURL + "/users")!
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
    
    func loadUsers(){
        let url = URL(string: config.baseURL + "/users")!
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error == nil {
                guard let jsonUser = data else {return}
                let userDTO = self.utils.parseJsonToUserDTO(json: jsonUser)
                for dto in userDTO {
                    let newUser = Users(identifier: dto.identifier, name: dto.name, lastName: dto.lastname, btDate: dto.btdate, document: dto.document, login: dto.login, password: dto.password)
                    UserDatabase.shared.importUsers(user: newUser)
                }
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
}
