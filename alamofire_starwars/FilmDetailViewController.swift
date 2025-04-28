//
//  FilmDetailViewController.swift
//  alamofire_starwars
//
//  Created by Gizem Duman on 25.04.2025.
//


import UIKit

class FilmDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var filmData: FilmData?
    
    @IBOutlet weak var tableView: UITableView!


    enum SectionType: Int, CaseIterable {
        case title, episode, director, producer, releaseDate
        case starships, vehicles, planets, characters, species
        
        var title: String {
            switch self {
            case .title: return "Film Name"
            case .episode: return "Episode"
            case .director: return "Director"
            case .producer: return "Producer"
            case .releaseDate: return "Release Date"
            case .starships: return "Starships"
            case .vehicles: return "Vehicles"
            case .planets: return "Planets"
            case .characters: return "Characters"
            case .species: return "Species"
            }
        }
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "DetailCell")
        
        title = filmData?.properties.title ?? "Film Detail"

    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return SectionType.allCases.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let film = filmData else { return 0 }
        switch SectionType(rawValue: section)! {
        case .title, .episode, .director, .producer, .releaseDate:
            return 1
        case .starships: return film.starships.count
        case .vehicles: return film.vehicles.count
        case .planets: return film.planets.count
        case .characters: return film.characters.count
        case .species: return film.species.count
        }
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return SectionType(rawValue: section)?.title
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCell", for: indexPath)
        guard let film = filmData else { return cell }
        
        let section = SectionType(rawValue: indexPath.section)!
        
        switch section {
        case .title:
            cell.textLabel?.text = film.properties.title ?? "N/A"
            
        case .episode:
            cell.textLabel?.text = "Episode \(film.properties.episodeId ?? 0)"
            
        case .director:
            cell.textLabel?.text = film.properties.director ?? "N/A"
            
        case .producer:
            cell.textLabel?.text = film.properties.producer ?? "N/A"
            
        case .releaseDate:
            cell.textLabel?.text = film.properties.releaseDate ?? "N/A"
            
        case .starships:
            let starship = film.starships[indexPath.row]
            cell.textLabel?.numberOfLines = 0
            cell.textLabel?.text = """
            Name: \(starship.name)
            Model: \(starship.model)
            Starship Class: \(starship.starshipClass)
            Manufacturer: \(starship.manufacturer)
            Cost in Credits: \(starship.costInCredits)
            Length: \(starship.length)
            Crew: \(starship.crew)
            Passengers: \(starship.passengers)
            Max Speed: \(starship.maxAtmospheringSpeed)
            Cargo Capacity: \(starship.cargoCapacity)
            Consumables: \(starship.consumables)
            Hyperdrive Rating: \(starship.hyperdriveRating)
            MGLT: \(starship.MGLT)
            """
            
        case .vehicles:
            let vehicle = film.vehicles[indexPath.row]
            cell.textLabel?.numberOfLines = 0
            cell.textLabel?.text = """
            Name: \(vehicle.name)
            Model: \(vehicle.model)
            Manufacturer: \(vehicle.manufacturer)
            Vehicle Class: \(vehicle.vehicleClass)
            Cost in Credits: \(vehicle.costInCredits)
            Length: \(vehicle.length)
            Crew: \(vehicle.crew)
            Passengers: \(vehicle.passengers)
            Max Speed: \(vehicle.maxAtmospheringSpeed)
            Cargo Capacity: \(vehicle.cargoCapacity)
            Consumables: \(vehicle.consumables)
            """
            
        case .planets:
            let planet = film.planets[indexPath.row]
            cell.textLabel?.numberOfLines = 0
            cell.textLabel?.text = """
            Name: \(planet.name)
            Climate: \(planet.climate)
            Surface Water: \(planet.surfaceWater)
            Diameter: \(planet.diameter)
            Rotation Period: \(planet.rotationPeriod)
            Terrain: \(planet.terrain)
            Gravity: \(planet.gravity)
            Orbital Period: \(planet.orbitalPeriod)
            Population: \(planet.population)
            """
            
        case .characters:
            let character = film.characters[indexPath.row]
            cell.textLabel?.numberOfLines = 0
            cell.textLabel?.text = """
            Name: \(character.name)
            Gender: \(character.gender)
            Skin Color: \(character.skinColor)
            Hair Color: \(character.hairColor)
            Height: \(character.height)
            Eye Color: \(character.eyeColor)
            Mass: \(character.mass)
            Birth Year: \(character.birthYear)
            """
            
        case .species:
            let species = film.species[indexPath.row]
            cell.textLabel?.numberOfLines = 0
            cell.textLabel?.text = """
            Name: \(species.name)
            Classification: \(species.classification)
            Designation: \(species.designation)
            Average Height: \(species.averageHeight)
            Average Lifespan: \(species.averageLifespan)
            Language: \(species.language)
            Skin Colors: \(species.skinColors)
            Hair Colors: \(species.hairColors)
            Eye Colors: \(species.eyeColors)
            """
        }
        
        return cell
    }

}
