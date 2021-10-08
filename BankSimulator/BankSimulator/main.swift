//
//  main.swift
//  BankSimulator
//
//  Created by Caico Saler Oliveira Costa on 27/09/21.
//

import Foundation

let menu = Menu()
UserDatabase.shared.loadUsers()
UserDatabase.shared.save()
menu.firstMenu()

/*UserDatabase.shared.getRequest(url: url){
    (resultado, erro)  in
      if(resultado != nil) {
          //O resultado aqui vem como Opcional
          print("Sua requisicao foi realizada com sucesso: \n \(resultado)")
      } else {
          print("A requisicao nao funcionou")
      }
      
}*/
