//
//  Vehicle.swift
//  alamofire_starwars
//
//  Created by Gizem Duman on 27.04.2025.
//

struct VehicleDetailResponse: Codable {
    let message: String
    let result: VehicleDetailResult
}

struct VehicleDetailResult: Codable {
    let properties: VehicleProperties
}

struct VehicleProperties: Codable {
    let name: String
    let model: String
    let manufacturer: String
    let vehicleClass: String
    let costInCredits: String
    let length: String
    let crew: String
    let passengers: String
    let maxAtmospheringSpeed: String
    let cargoCapacity: String
    let consumables: String
    let films: [String]
    let pilots: [String]

    enum CodingKeys: String, CodingKey {
        case name, model, manufacturer
        case vehicleClass = "vehicle_class"
        case costInCredits = "cost_in_credits"
        case length, crew, passengers
        case maxAtmospheringSpeed = "max_atmosphering_speed"
        case cargoCapacity = "cargo_capacity"
        case consumables, films, pilots
    }
}
