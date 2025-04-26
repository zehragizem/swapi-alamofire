//
//  Film.swift
//  alamofire_starwars
//
//  Created by Gizem Duman on 27.04.2025.
//

struct FilmListResponse: Codable {
    let message: String
    let result: [FilmDetailResult]
}


struct FilmDetailResult: Codable {
    let properties: FilmProperties
}

struct FilmProperties: Codable {
    let title: String?
    let episodeId: Int?
    let director: String?
    let producer: String?
    let releaseDate: String?
    let openingCrawl: String?
    let starships: [String]?
    let vehicles: [String]?
    let planets: [String]?
    let characters: [String]?
    let species: [String]?

    enum CodingKeys: String, CodingKey {
        case title
        case episodeId = "episode_id"
        case director
        case producer
        case releaseDate = "release_date"
        case openingCrawl = "opening_crawl"
        case starships, vehicles, planets, characters, species
    }
}

class FilmData {
    var properties: FilmProperties
    var characters: [CharacterProperties] = []
    var vehicles: [VehicleProperties] = []
    var starships: [StarshipProperties] = []
    var planets: [PlanetProperties] = []
    var species: [SpeciesProperties] = []

    init(properties: FilmProperties) {
        self.properties = properties
    }
}
