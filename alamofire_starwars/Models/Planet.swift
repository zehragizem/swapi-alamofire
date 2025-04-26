//
//  Planet.swift
//  alamofire_starwars
//
//  Created by Gizem Duman on 27.04.2025.
//

struct PlanetDetailResponse: Codable {
    let message: String
    let result: PlanetDetailResult
}

struct PlanetDetailResult: Codable {
    let properties: PlanetProperties
}

struct PlanetProperties: Codable {
    let name: String
    let climate: String
    let surfaceWater: String
    let diameter: String
    let rotationPeriod: String
    let terrain: String
    let gravity: String
    let orbitalPeriod: String
    let population: String
    
    enum CodingKeys: String, CodingKey {
        case name, climate
        case surfaceWater = "surface_water"
        case diameter
        case rotationPeriod = "rotation_period"
        case terrain, gravity
        case orbitalPeriod = "orbital_period"
        case population
    }
}
