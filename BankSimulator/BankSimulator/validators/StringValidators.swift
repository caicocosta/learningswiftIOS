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

extension String {
    var isCPF: Bool {
            let numbers = self.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
            guard numbers.count == 11 else { return false }

            let set = NSCountedSet(array: Array(numbers))
            guard set.count != 1 else { return false }

            let i1 = numbers.index(numbers.startIndex, offsetBy: 9)
            let i2 = numbers.index(numbers.startIndex, offsetBy: 10)
            let i3 = numbers.index(numbers.startIndex, offsetBy: 11)
            let d1 = Int(numbers[i1..<i2])
            let d2 = Int(numbers[i2..<i3])

            var temp1 = 0, temp2 = 0

            for i in 0...8 {
                let start = numbers.index(numbers.startIndex, offsetBy: i)
                let end = numbers.index(numbers.startIndex, offsetBy: i+1)
                let char = Int(numbers[start..<end])

                temp1 += char! * (10 - i)
                temp2 += char! * (11 - i)
            }

            temp1 %= 11
            temp1 = temp1 < 2 ? 0 : 11-temp1

            temp2 += temp1 * 2
            temp2 %= 11
            temp2 = temp2 < 2 ? 0 : 11-temp2

            return temp1 == d1 && temp2 == d2
        }

    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func isValidPhoneNumber (_ phone: String) -> Bool {
        let phoneRegEx = "^\\d{5}-\\d{4}$"

        let phonePred = NSPredicate(format:"SELF MATCHES %@", phoneRegEx)
        return phonePred.evaluate(with: phone)
    }
}

