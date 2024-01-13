//
//  MainView.swift
//  HammerMenuTest
//
//  Created by Tim Akhmetov on 12.01.2024.
//

import Foundation

struct PizzaModel: Codable {
   
    let imageURL: String
    let title: String
    let description: String
    let price: Int

    enum CodingKeys: String, CodingKey {
        case imageURL = "imageUrl"
        case description = "description"
        case title, price
    }
}

typealias PizzaArray = [PizzaModel]
