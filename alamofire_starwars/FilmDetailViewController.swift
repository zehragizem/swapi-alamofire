//
//  FilmDetailViewController.swift
//  alamofire_starwars
//
//  Created by Gizem Duman on 25.04.2025.
//


import UIKit

class FilmDetailViewController: UIViewController {
    var film: FilmProperties?  // ← bu önemli!

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var directorLabel: UILabel!
    @IBOutlet weak var producerLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        if let film = film {
            titleLabel.text = film.title
            directorLabel.text = film.director
            producerLabel.text = film.producer
            releaseDateLabel.text = film.releaseDate
        }
    }
}


