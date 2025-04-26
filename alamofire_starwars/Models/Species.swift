//
//  Species.swift
//  alamofire_starwars
//
//  Created by Gizem Duman on 27.04.2025.
//

struct SpeciesDetailResponse: Codable {
    let result: SpeciesResult
}

struct SpeciesResult: Codable {
    let properties: SpeciesProperties
}

struct SpeciesProperties: Codable {
    let name: String
    let classification: String
    let designation: String
    let averageHeight: String
    let averageLifespan: String
    let language: String
    let skinColors: String
    let hairColors: String
    let eyeColors: String
    
    enum CodingKeys: String, CodingKey {
        case name, classification, designation
        case averageHeight = "average_height"
        case averageLifespan = "average_lifespan"
        case language
        case skinColors = "skin_colors"
        case hairColors = "hair_colors"
        case eyeColors = "eye_colors"
    }
}
