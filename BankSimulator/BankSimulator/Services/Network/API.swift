//
//  API.swift
//  BankSimulator
//
//  Created by Caico Saler Oliveira Costa on 14/10/21.
//

import Foundation

class API {
    private var config = Config()
    private var dataResponse: Data?
    
    func post(json: [String: Any], resource: String){
        
        // create post request
        let url = URL(string: config.baseURL + resource)!
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
    
    func get(resource: String, completion: @escaping (Data?, Error?) -> Void) {
        let url = URL(string: config.baseURL + resource)!
        //Cria a representacão da requisição
        
        let request = NSMutableURLRequest(url: url)

    
         //Atribui à requisiçāo o método GET
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
                (data, response, error) in
                do {
                    
                    if let data = data {
                        //A resposta chegou
                        let _ = try JSONSerialization.jsonObject(with: data, options: [])
                        completion(data as Data, nil)
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
    
    func put(json: [String: Any], resource: String){
        
        // create post request
        let url = URL(string: config.baseURL + resource)!
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
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
}
