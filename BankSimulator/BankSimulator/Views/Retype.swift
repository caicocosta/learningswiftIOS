//
//  Retype.swift
//  BankSimulator
//
//  Created by Caico Saler Oliveira Costa on 06/10/21.
//

import Foundation

struct Retype {
    func retyping(str: String, validator: (String) -> () ) -> String? {
        print(str)
        guard let text = readLine() else {return nil}
        return text
    }
}
