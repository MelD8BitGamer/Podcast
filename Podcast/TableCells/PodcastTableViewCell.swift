//
//  PodcastTableViewCell.swift
//  Podcast
//
//  Created by Melinda Diaz on 12/17/19.
//  Copyright © 2019 Melinda Diaz. All rights reserved.
//

import UIKit

class PodcastTableViewCell: UITableViewCell {
    
    @IBOutlet weak var podcastImage: UIImageView!
    @IBOutlet weak var podcastLabel: UILabel!
    @IBOutlet weak var podcastNameLabel: UILabel!
    
    
//    func getImagesFromAPI(for: podcastRef[indexPath.row].artworkUrl60) { [weak self] (result) in
//            switch result {
//            case .failure(let appError):
//                DispatchQueue.main.async {
//                    self?.showAlert(title: "Image Error" , message: "Image Not Found \(appError)")
//                }
//            case .success(let image):
//                DispatchQueue.main.async {
//                    cell.podcastImage.image = image
//                }
//            }
//        }
//        return cell
//    }
}

