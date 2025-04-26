//
//  Starship.swift
//  alamofire_starwars
//
//  Created by Gizem Duman on 27.04.2025.
//

struct StarshipDetailResponse: Codable {
    let message: String
    let result: StarshipDetailResult
}

struct StarshipDetailResult: Codable {
    let properties: StarshipProperties
}

struct StarshipProperties: Codable {
    let name: String
    let model: String
    let starshipClass: String
    let manufacturer: String
    let costInCredits: String
    let length: String
    let crew: String
    let passengers: String
    let maxAtmospheringSpeed: String
    let cargoCapacity: String
    let consumables: String
    let hyperdriveRating: String
    let MGLT: String
    let films: [String]
    
    enum CodingKeys: String, CodingKey {
        case name, model
        case starshipClass = "starship_class"
        case manufacturer
        case costInCredits = "cost_in_credits"
        case length, crew, passengers
        case maxAtmospheringSpeed = "max_atmosphering_speed"
        case cargoCapacity = "cargo_capacity"
        case consumables, hyperdriveRating = "hyperdrive_rating", MGLT, films
    }
}
