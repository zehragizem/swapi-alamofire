//
//  FilmDetailViewController.swift
//  alamofire_starwars
//
//  Created by Gizem Duman on 25.04.2025.
//


import UIKit

class FilmDetailViewController: UIViewController {
    var filmData: FilmData?
    

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var directorLabel: UILabel!
    @IBOutlet weak var producerLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!

    @IBOutlet weak var starshipsTextView: UITextView!
    @IBOutlet weak var vehiclesTextView: UITextView!
    @IBOutlet weak var planetsTextView: UITextView!
    @IBOutlet weak var charactersTextView: UITextView!
    @IBOutlet weak var speciesTextView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let film = filmData?.properties else { return }

        titleLabel.text = film.title
        directorLabel.text = film.director
        producerLabel.text = film.producer
        releaseDateLabel.text = film.releaseDate

        // Örnek: starship isimlerini göster
        starshipsTextView.text = filmData?.starships.map { $0.name }.joined(separator: "\n")
        charactersTextView.text = filmData?.characters.map { $0.name }.joined(separator: "\n")
        vehiclesTextView.text = filmData?.vehicles.map { $0.name }.joined(separator: "\n")
        planetsTextView.text = filmData?.planets.map { $0.name }.joined(separator: "\n")
        speciesTextView.text = filmData?.species.map { $0.name }.joined(separator: "\n")
    }


}


