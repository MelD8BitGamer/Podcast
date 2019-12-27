//
//  DetailViewController.swift
//  Podcast
//
//  Created by Melinda Diaz on 12/17/19.
//  Copyright © 2019 Melinda Diaz. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var podcastName: UILabel!
    @IBOutlet weak var episodeLabel: UILabel!
    @IBOutlet weak var trackIDLabel: UILabel!
    @IBOutlet weak var podcastImage: UIImageView!
    @IBOutlet weak var favoriteOutlet: UIButton!
    
    var modelReference: Podcast?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
    }
    
    func setup() {
        if let collectionName = modelReference?.collectionName {
            podcastName.text = collectionName
        } else {
            podcastName.isHidden = true
        }
        if let trackName = modelReference?.trackName {
            episodeLabel.text = trackName
        } else {
            episodeLabel.isHidden = true
        }
        if let trackID = modelReference?.trackId {
            trackIDLabel.text = String(trackID)
        } else {
            trackIDLabel.isHidden = true
        }
        guard let podcastArtwork = modelReference?.artworkUrl60  else {
            podcastImage.image = UIImage(systemName: "questionmark.diamond.fill")
            return
        }
        UIImageView.getImagesFromAPI(for: podcastArtwork) { [weak self] (result) in
            switch result {
            case .failure:
                DispatchQueue.main.async {
                    self?.showAlert(title: "No Image", message: "Image not found")
                }
            case .success(let podcastArtwork):
                DispatchQueue.main.async {
                    self?.podcastImage.image = podcastArtwork
                }
            }
        }
    }
    
    
    //you want your action on the bottom
    @IBAction func favoriteStar(_ sender: UIButton) {
        guard var favoritePod = modelReference else { fatalError("Bomb")
        }
        favoritePod.favoritedBy = "MelD8BitGamer"
        APIClient.postFavorite(postPod: favoritePod) { [weak self] (result) in
            switch result {
            case .failure(let appError):
                DispatchQueue.main.async {
                    self?.showAlert(title: "Post Denied", message: "\(appError)")
                }
            case .success:
                break
            }
        }
    }
    
    
    
    
}
