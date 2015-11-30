//
//  Trips.swift
//  Tripme
//
//  Created by Carlos Amadheus Souza Araujo on 03/11/15.
//  Copyright © 2015 Rodrigo DAngelo Silva Machado. All rights reserved.
//

import UIKit

class Trips
{
    // MARK: - Public API
    var title = ""
    var featuredImage: UIImage!
    var local = ""
    var dinheiroAtual = ""
    var dinheiroTotal = ""
    var Nome = ""
    var UserImg : UIImage!
    var Favorite : Bool!
    
    init(title: String, featuredImage: UIImage!, local: String, dinheiroAtual: String, dinheiroTotal: String, Nome: String, UserImg: UIImage! ,Favorite: Bool)
    {
        self.title = title
        self.featuredImage = featuredImage
        self.local = local
        self.dinheiroAtual = dinheiroAtual
        self.dinheiroTotal = dinheiroTotal
        self.Nome = Nome
        self.UserImg = UserImg
        self.Favorite = Favorite
    }
    
    // MARK: - Private
    // dummy data
    static func createInterests() -> [Trips]
    {
        return [
            Trips(title: "Titulo 1", featuredImage: UIImage(named: "r1"), local: "Local 1", dinheiroAtual: "1000", dinheiroTotal: "3200", Nome: "Nome 1", UserImg: UIImage(named: "User1"), Favorite: true),
            
            Trips(title: "Titulo 2", featuredImage: UIImage(named: "r2"), local: "Local 2", dinheiroAtual: "3121", dinheiroTotal: "5000", Nome: "Nome 2", UserImg: UIImage(named: "r3"), Favorite: false)
        ]
    }
}
