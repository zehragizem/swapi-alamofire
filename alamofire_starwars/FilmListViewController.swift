import UIKit
import Alamofire
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



// MARK: - ViewController

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var films: [FilmData] = []

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self

        fetchAllFilms()
    }

    func fetchAllFilms() {
        let url = "https://www.swapi.tech/api/films"

        AF.request(url).responseDecodable(of: FilmListResponse.self) { response in
            switch response.result {
            case .success(let filmListResponse):
                self.films = filmListResponse.result.map { FilmData(properties: $0.properties) }

                for film in self.films {
                    self.fetchCharacterDetails(from: film.properties.characters ?? [], for: film)
                    self.fetchVehicleDetails(from: film.properties.vehicles ?? [], for: film)
                    self.fetchStarshipDetails(from: film.properties.starships ?? [], for: film)
                    self.fetchPlanetDetails(from: film.properties.planets ?? [], for: film)
                    self.fetchSpeciesDetails(from: film.properties.species ?? [], for: film)
                }

                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }

            case .failure(let error):
                print("❌ Error: \(error.localizedDescription)")
            }
        }
    }



    

    func fetchSpeciesDetails(from urls: [String], for film: FilmData) {
        let group = DispatchGroup()

        for url in urls {
            group.enter()
            
            AF.request(url).responseDecodable(of: SpeciesDetailResponse.self) { response in
                switch response.result {
                case .success(let detail):
                    film.species.append(detail.result.properties)

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
    func fetchStarshipDetails(from urls: [String], for film: FilmData) {
        let group = DispatchGroup()

        for url in urls {
            group.enter()
            
            AF.request(url).responseDecodable(of: StarshipDetailResponse.self) { response in
                switch response.result {
                case .success(let detail):
                    film.starships.append(detail.result.properties)

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
    func fetchPlanetDetails(from urls: [String], for film: FilmData) {
        let group = DispatchGroup()

        for url in urls {
            group.enter()
            
            AF.request(url).responseDecodable(of: PlanetDetailResponse.self) { response in
                switch response.result {
                case .success(let detail):
                    film.planets.append(detail.result.properties)

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
    func fetchVehicleDetails(from urls: [String], for film: FilmData) {
        let group = DispatchGroup()

        for url in urls {
            group.enter()
            
            AF.request(url).responseDecodable(of: VehicleDetailResponse.self) { response in
                switch response.result {
                case .success(let detail):
                    film.vehicles.append(detail.result.properties)

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
    func fetchCharacterDetails(from urls: [String], for film: FilmData) {
        let group = DispatchGroup()

        for url in urls {
            group.enter()
            
            AF.request(url).responseDecodable(of: CharacterDetailResponse.self) { response in
                switch response.result {
                case .success(let detail):
                    film.characters.append(detail.result.properties)
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

    // MARK: - TableView DataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return films.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FilmCell", for: indexPath)
        let film = films[indexPath.row].properties
        let episode = film.episodeId ?? 0
        let title = film.title ?? "No Title"
        cell.textLabel?.text = "Episode \(episode): \(title)"
        
        return cell
    }


    // MARK: - Navigation

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let film = films[indexPath.row]
        performSegue(withIdentifier: "ShowFilmDetail", sender: film)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowFilmDetail" {
            guard let destination = segue.destination as? FilmDetailViewController,
                  let film = sender as? FilmData else {
                print("❌ Segue hatası: veri aktarılamadı")
                return
            }
            destination.filmData = film
        }
    }



}
