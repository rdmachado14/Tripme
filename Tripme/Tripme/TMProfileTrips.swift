//
//  TMProfileTrips.swift
//  Tripme
//
//  Created by Rodrigo Machado on 11/6/15.
//  Copyright © 2015 Rodrigo DAngelo Silva Machado. All rights reserved.
//

import UIKit

class TMProfileTrips
{
    var tripName: String! // nome da viagem
    var user: String! // nome do usuário
    var moneyRaised: Double! // dinheiro arrecadado
    var moneyTotal: Double! // total para ser arrecadado
    var imageUser: UIImage! // imagem do usuário
    
    // método construtor
    init(tripName: String, user: String, moneyRaised: Double, moneyTotal: Double, imageUser: UIImage)
    {
        self.tripName = tripName
        self.user = user
        self.moneyRaised = moneyRaised
        self.moneyTotal = moneyTotal
        self.imageUser = imageUser
    }
    
    // função para manipular a collection
    static func createdTrips() -> [TMProfileTrips]
    {
        return
        [
            TMProfileTrips(tripName: "Mochilão na Améica do Sul", user: "Michel Paz", moneyRaised: 10000, moneyTotal: 20000, imageUser: UIImage(named: "p2")!),
            TMProfileTrips(tripName: "Passeio na Estrela da Morte", user: "Michel Paz", moneyRaised: 1, moneyTotal: 2, imageUser: UIImage(named: "p3")!)
            
        ]
    }
    
    
}
