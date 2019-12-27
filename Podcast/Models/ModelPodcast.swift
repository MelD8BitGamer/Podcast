//
//  ModelPodcast.swift
//  Podcast
//
//  Created by Melinda Diaz on 12/17/19.
//  Copyright © 2019 Melinda Diaz. All rights reserved.
//

import Foundation
import UIKit

struct ApplePodcast: Codable {
    let results: [Podcast]
    
}

struct Podcast: Codable {
    let trackId: Int
    let artistName: String
    let collectionName: String
    let trackName: String
    let artworkUrl60: String
    let artworkUrl600: String
    var favoritedBy: String?
}

