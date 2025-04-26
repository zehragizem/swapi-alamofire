//
//  Character.swift
//  alamofire_starwars
//
//  Created by Gizem Duman on 27.04.2025.
//

struct CharacterDetailResponse: Codable {
    let message: String
    let result: CharacterDetailResult
}

struct CharacterDetailResult: Codable {
    let properties: CharacterProperties
}

struct CharacterProperties: Codable {
    let name: String
    let gender: String
    let skinColor: String
    let hairColor: String
    let height: String
    let eyeColor: String
    let mass: String
    let homeworld: String
    let birthYear: String
    let url: String

    enum CodingKeys: String, CodingKey {
        case name, gender
        case skinColor = "skin_color"
        case hairColor = "hair_color"
        case height
        case eyeColor = "eye_color"
        case mass
        case homeworld, birthYear = "birth_year", url
    }
}
