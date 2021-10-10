//
//  main.swift
//  BankSimulator
//
//  Created by Caico Saler Oliveira Costa on 27/09/21.
//

import Foundation

let menu = Menu()
UserDatabase.shared.loadUsers()
AccountDatabase.shared.loadAccounts()
menu.firstMenu()

