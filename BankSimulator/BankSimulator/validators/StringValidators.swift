//
//  StringValidators.swift
//  BankSimulator
//
//  Created by Caico Saler Oliveira Costa on 06/10/21.
//

import Foundation

struct StringValidators {
    
    func minCharacter(text: [String], minCh: Int) -> (status: Bool, text: String) {
        for str in text {
            if str.count < minCh {
                return (false, str)
            }
        }
        return (true, "")
    }
}
