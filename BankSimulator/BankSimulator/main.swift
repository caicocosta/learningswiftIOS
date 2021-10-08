//
//  main.swift
//  BankSimulator
//
//  Created by Caico Saler Oliveira Costa on 27/09/21.
//

import Foundation

let menu = Menu()
menu.populabanco()
UserDatabase.shared.loadUsers()
menu.firstMenu()
