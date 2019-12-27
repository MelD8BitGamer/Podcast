//
//  AppError.swift
//  Podcast
//
//  Created by Melinda Diaz on 12/17/19.
//  Copyright © 2019 Melinda Diaz. All rights reserved.
//

import Foundation

//error handling against Network requests if you do this it wont crash and will show the error, some errors could be a network error
enum AppError: Error {
    case badURL(String) //this is an associated value it captures a value along side the case. to store any relevant data
    case noResponse
    case networkClientError(Error)
    case noData
    case decodingError(Error)
    case badStatusCode(Int) //bad status codes 484, 500 etc
    case badMimeType(String)// Mime is multimedia type video, image/jpeg etc
    case encodingError(Error)
}
