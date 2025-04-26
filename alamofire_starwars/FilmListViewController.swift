import UIKit
import Alamofire


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
