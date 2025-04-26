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
        case starships, vehicles, planets, characters, species
        
        var title: String {
            switch self {
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
        case .starships:
            cell.textLabel?.text = film.starships[indexPath.row].name
        case .vehicles:
            cell.textLabel?.text = film.vehicles[indexPath.row].name
        case .planets:
            cell.textLabel?.text = film.planets[indexPath.row].name
        case .characters:
            cell.textLabel?.text = film.characters[indexPath.row].name
        case .species:
            cell.textLabel?.text = film.species[indexPath.row].name
        }

        return cell
    }
}
