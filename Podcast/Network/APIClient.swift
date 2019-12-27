//
//  APIClient.swift
//  Podcast
//
//  Created by Melinda Diaz on 12/19/19.
//  Copyright © 2019 Melinda Diaz. All rights reserved.
//

import Foundation

struct APIClient: Codable {
    
    //@escaping waits patiently for the API data, because it's a network call (Asynchronous: Not done right away) we don't know when we are going to get our data.
    static func getPodcasts(for searchQuery: String,
                            completion: @escaping (Result<[Podcast], AppError>) -> ()) {
        
        // using string interpolation to build endpoint url
        let podcastEndpointURL = "https://itunes.apple.com/search?media=podcast&limit=200&term=\(searchQuery)"
        
        NetworkHelper.shared.performDataTask(with: podcastEndpointURL) { (result) in
            switch result {
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
            case .success(let data):
                do {//any function that uses an error you must try
                    let searchResults = try JSONDecoder().decode(ApplePodcast.self, from: data)
                    
                    // 2. capture the array of results in the completion handler
                    completion(.success(searchResults.results))
                    
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
    }
    
    static func postFavorite(postPod: Podcast, completion: @escaping (Result<Bool,AppError>) -> ()) {
        let postEndpointUrl = "https://5c2e2a592fffe80014bd6904.mockapi.io/api/v1/favorites"
        guard let url = URL(string: postEndpointUrl) else {
            completion(.failure(.badURL(postEndpointUrl)))
            return
        }
        do {
            let data = try JSONEncoder().encode(postPod)
            var request = URLRequest(url: url)
            request.httpMethod = "POST"//must be capitalized or it wont work
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = data
            NetworkHelper.shared.postDataTask(request: request) { (result) in
                switch result {
                case .failure(let appError):
                    completion(.failure(.networkClientError(appError)))
                case .success:
                    completion(.success(true))
                }
            }
        } catch {
            completion(.failure(.encodingError(error)))
        }
        
    }
    
}




