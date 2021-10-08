//
//  UserDatabase.swift
//  BankSimulator
//
//  Created by Caico Saler Oliveira Costa on 05/10/21.
//

import Foundation
import Moya

class UserDatabase {
    
    private var users: [Users] = []
    private var error = ""
    private let userProvider = MoyaProvider<UserServices>()
    private var utils = Utils()
    private var config = Config()
    
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
    
    func getRequest(url: String,
                     completion: @escaping ([Any]?, Error?) -> Void){
        //URL válida
        guard let URL = URL(string: url) else {
            completion(nil, nil)
            return
        }
      
      
        //Cria a representacão da requisição
        let request = NSMutableURLRequest(url: URL)

        
        //Atribui à requisiçāo o método GET
        request.httpMethod = "GET"
        
      
        //Cria a tarefa de requisição
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            (data, response, error) in
            do {
                
                if let data = data {
                    //A resposta chegou
                    let response = try JSONSerialization.jsonObject(with: data, options: [])
                    completion(response as? [Any], nil)
                }
                else {
                    //Não houve resposta
                    completion(nil, nil)
                }
            } catch let error as NSError {
                // Houve um erro na comunicao com o servidor
                completion(nil, error)
            }
        }
        
        
        //Aciona a tarefa
        task.resume()
        
    }
    
    //Funcoes para realizar alteracao no banco
    
    func save(){
        // prepare json data
        let usuario = Users(identifier: 20, name: "TESTE", lastName: "NOVO TESTE", btDate: "123", document: "12345", login: "12345", password: "123")
        let json: [String: Any] = ["identifier": usuario.identifier,
                                   "name": usuario.name,
                                   "lastname": usuario.lastName,
                                   "btdate": usuario.btDate,
                                   "document": usuario.document,
                                   "login": usuario.login,
                                   "password": usuario.password]

        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        
        //create the session object
        let session = URLSession.shared

        // create post request
        let url = URL(string: config.baseURL + "/users")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        do {
                request.httpBody = try JSONSerialization.data(withJSONObject: jsonData, options: .prettyPrinted) // pass dictionary to data object and set it as request body
            } catch let error {
                print(error.localizedDescription)
                //completion(nil, error)
            }

            //HTTP Headers
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")

            //create dataTask using the session object to send data to the server
            let task = session.dataTask(with: request, completionHandler: { data, response, error in

                guard error == nil else {
                    //completion(nil, error)
                    return
                }

                guard let data = data else {
                    //completion(nil, NSError(domain: "dataNilError", code: -100001, userInfo: nil))
                    return
                }

                do {
                    //create json object from data
                    guard let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] else {
                       // completion(nil, NSError(domain: "invalidJSONTypeError", code: -100009, userInfo: nil))
                        return
                    }
                    print(json)
                    //completion(json, nil)
                } catch let error {
                    print(error.localizedDescription)
                    //completion(nil, error)
                }
            })


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
                self.users.append(newUser)
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
