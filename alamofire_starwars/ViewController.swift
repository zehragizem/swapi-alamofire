import UIKit
import Alamofire
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

// MARK: - Model
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

struct FilmListResponse: Codable {
    let message: String
    let result: [FilmDetailResult]
}


struct FilmDetailResult: Codable {
    let properties: FilmProperties
}

struct FilmProperties: Codable {
    let title: String
    let episodeId: Int
    let director: String
    let producer: String
    let releaseDate: String
    let openingCrawl: String
    let starships: [String]
    let vehicles: [String]
    let planets: [String]
    let characters: [String]
    let species: [String]
    
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


// MARK: - ViewController

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchAllFilms()
    }

    func fetchAllFilms() {
        let url = "https://www.swapi.tech/api/films"

        AF.request(url).responseDecodable(of: FilmListResponse.self) { response in
            switch response.result {
            case .success(let filmListResponse):
                let films = filmListResponse.result.map { $0.properties }

                for film in films {
                    print("🎬 Title: \(film.title)")
                    print("🎞 Episode: \(film.episodeId)")
                    print("🎬 Director: \(film.director)")
                    print("🎬 Producer: \(film.producer)")
                    print("📆 Release Date: \(film.releaseDate)")
                    print("📜 Opening Crawl:\n\(film.openingCrawl)\n")

                    self.fetchCharacterDetails(from: film.characters)
                    self.fetchVehicleDetails(from: film.vehicles)
                    self.fetchStarshipDetails(from: film.starships)
                    self.fetchPlanetDetails(from: film.planets)
                    self.fetchSpeciesDetails(from: film.species)
                }

            case .failure(let error):
                print("❌ Error: \(error.localizedDescription)")
            }
        }
    }


    

    func fetchSpeciesDetails(from urls: [String]) {
        let group = DispatchGroup()

        for url in urls {
            group.enter()
            
            AF.request(url).responseDecodable(of: SpeciesDetailResponse.self) { response in
                switch response.result {
                case .success(let detail):
                    let species = detail.result.properties
                    print("👽 Species Name: \(species.name)")
                    print("• Classification: \(species.classification)")
                    print("• Designation: \(species.designation)")
                    print("• Average Height: \(species.averageHeight)")
                    print("• Lifespan: \(species.averageLifespan)")
                    print("• Language: \(species.language)")
                    print("• Skin Colors: \(species.skinColors)")
                    print("• Hair Colors: \(species.hairColors)")
                    print("• Eye Colors: \(species.eyeColors)")
                    print("───────────────")
                case .failure(let error):
                    print("⚠️ Failed to fetch species: \(error.localizedDescription)")
                }
                group.leave()
            }
        }

        group.notify(queue: .main) {
            print("✅ Tüm species verileri getirildi.")
        }
    }
    func fetchStarshipDetails(from urls: [String]) {
        let group = DispatchGroup()

        for url in urls {
            group.enter()
            
            AF.request(url).responseDecodable(of: StarshipDetailResponse.self) { response in
                switch response.result {
                case .success(let detail):
                    let starship = detail.result.properties
                    print("🚀 Starship Name: \(starship.name)")
                    print("• Model: \(starship.model)")
                    print("• Starship Class: \(starship.starshipClass)")
                    print("• Manufacturer: \(starship.manufacturer)")
                    print("• Cost in Credits: \(starship.costInCredits)")
                    print("• Length: \(starship.length)")
                    print("• Crew: \(starship.crew)")
                    print("• Passengers: \(starship.passengers)")
                    print("• Max Atmosphering Speed: \(starship.maxAtmospheringSpeed)")
                    print("• Cargo Capacity: \(starship.cargoCapacity)")
                    print("• Consumables: \(starship.consumables)")
                    print("• Hyperdrive Rating: \(starship.hyperdriveRating)")
                    print("• MGLT: \(starship.MGLT)")
                    print("• Films: \(starship.films.joined(separator: ", "))")
                    print("───────────────")
                case .failure(let error):
                    print("⚠️ Failed to fetch starship: \(error.localizedDescription)")
                }
                group.leave()
            }
        }

        group.notify(queue: .main) {
            print("✅ Tüm starship verileri getirildi.")
        }
    }
    func fetchPlanetDetails(from urls: [String]) {
        let group = DispatchGroup()

        for url in urls {
            group.enter()
            
            AF.request(url).responseDecodable(of: PlanetDetailResponse.self) { response in
                switch response.result {
                case .success(let detail):
                    let planet = detail.result.properties
                    print("🌍 Planet Name: \(planet.name)")
                    print("• Climate: \(planet.climate)")
                    print("• Surface Water: \(planet.surfaceWater)")
                    print("• Diameter: \(planet.diameter)")
                    print("• Rotation Period: \(planet.rotationPeriod)")
                    print("• Terrain: \(planet.terrain)")
                    print("• Gravity: \(planet.gravity)")
                    print("• Orbital Period: \(planet.orbitalPeriod)")
                    print("• Population: \(planet.population)")
                    print("───────────────")
                case .failure(let error):
                    print("⚠️ Failed to fetch planet: \(error.localizedDescription)")
                }
                group.leave()
            }
        }

        group.notify(queue: .main) {
            print("✅ Tüm planet verileri getirildi.")
        }
    }
    func fetchVehicleDetails(from urls: [String]) {
        let group = DispatchGroup()

        for url in urls {
            group.enter()
            
            AF.request(url).responseDecodable(of: VehicleDetailResponse.self) { response in
                switch response.result {
                case .success(let detail):
                    let vehicle = detail.result.properties
                    print("🚗 Vehicle Name: \(vehicle.name)")
                    print("• Model: \(vehicle.model)")
                    print("• Manufacturer: \(vehicle.manufacturer)")
                    print("• Vehicle Class: \(vehicle.vehicleClass)")
                    print("• Cost in Credits: \(vehicle.costInCredits)")
                    print("• Length: \(vehicle.length)")
                    print("• Crew: \(vehicle.crew)")
                    print("• Passengers: \(vehicle.passengers)")
                    print("• Max Atmosphering Speed: \(vehicle.maxAtmospheringSpeed)")
                    print("• Cargo Capacity: \(vehicle.cargoCapacity)")
                    print("• Consumables: \(vehicle.consumables)")
                    print("• Films: \(vehicle.films.joined(separator: ", "))")
                    print("• Pilots: \(vehicle.pilots.isEmpty ? "None" : vehicle.pilots.joined(separator: ", "))")
                    print("───────────────")
                case .failure(let error):
                    print("⚠️ Failed to fetch vehicle: \(error.localizedDescription)")
                }
                group.leave()
            }
        }

        group.notify(queue: .main) {
            print("✅ Tüm vehicle verileri getirildi.")
        }
    }
    func fetchCharacterDetails(from urls: [String]) {
        let group = DispatchGroup()

        for url in urls {
            group.enter()
            
            AF.request(url).responseDecodable(of: CharacterDetailResponse.self) { response in
                switch response.result {
                case .success(let detail):
                    let character = detail.result.properties
                    print("👤 Character Name: \(character.name)")
                    print("• Gender: \(character.gender)")
                    print("• Skin Color: \(character.skinColor)")
                    print("• Hair Color: \(character.hairColor)")
                    print("• Height: \(character.height) cm")
                    print("• Eye Color: \(character.eyeColor)")
                    print("• Mass: \(character.mass) kg")
                    print("• Homeworld: \(character.homeworld)")
                    print("• Birth Year: \(character.birthYear)")
                    print("• URL: \(character.url)")
                    print("───────────────")
                case .failure(let error):
                    print("⚠️ Failed to fetch character: \(error.localizedDescription)")
                }
                group.leave()
            }
        }

        group.notify(queue: .main) {
            print("✅ Tüm karakter verileri getirildi.")
        }
    }


}
