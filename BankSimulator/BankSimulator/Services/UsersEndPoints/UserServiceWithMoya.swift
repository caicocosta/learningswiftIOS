//
//  UserService.swift
//  BankSimulator
//
//  Created by Caico Saler Oliveira Costa on 08/10/21.
//

import Foundation
import Moya

enum UserServices {
    case createUser (identifier: Int, name: String, lastName: String, btDate: String, document: String, login: String, password: String)
    case readUser
    case updateUser (identifier: Int, name: String, lastName: String, btDate: String, document: String, login: String, password: String)
    case deleteUser (identifier: Int)
}

extension UserServices: TargetType {
    var baseURL: URL {
        return URL(string: "https://6160395dfaa03600179fb95d.mockapi.io")!
    }
    
    var path: String {
        switch self {
            case .readUser, .createUser(_):
                return "/api/users/users"
                
            case .deleteUser(let identifier), .updateUser(let identifier, _, _, _, _, _, _):
                return "/api/users/users/\(identifier)"
                
        }
    }
    
    var method: Moya.Method {
        switch self {
            case .createUser(_):
                return .post
            case .readUser:
                return .get
            case .updateUser(_):
                return .put
            case .deleteUser(_):
                return .delete
        }
    }
    
    var task: Task {
        switch self {
        case .readUser, .deleteUser(_):
            return .requestPlain
        case .createUser(let identifier,
                         let name,
                         let lastName,
                         let btDate,
                         let document,
                         let login,
                         let password),
             .updateUser(let identifier,
                         let name,
                         let lastName,
                         let btDate,
                         let document,
                         let login,
                         let password):
            
            return .requestParameters(parameters: ["name": name,
                                                   "lastname": lastName,
                                                   "btDate": btDate,
                                                   "document": document,
                                                   "login": login,
                                                   "password": password],
                                      encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Typer": "application/json"]
    }
}
