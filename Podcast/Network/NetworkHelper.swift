//
//  NetworkHelper.swift
//  Podcast
//
//  Created by Melinda Diaz on 12/17/19.
//  Copyright © 2019 Melinda Diaz. All rights reserved.
//

import Foundation

// we need to make our NetworkHelper a singleton, this means there will only be one instance of this class throughout the application, at no point will someone be able to create a new instance eg. NetworkHelper()

class NetworkHelper {
    
    // we will create a shared instance of the NetworkHelper this is the one and only place for the instance
    static let shared = NetworkHelper()
    
    //no one outside has this access to session
    private var session: URLSession
    
    //we will make the default initializer private it is required in order to be considered a singleton. it also forbids anyone from creating an instance of NetworkHelper()
    private init() { //always know that session is asychronis??
        session = URLSession(configuration: .default)
    }
    //a escaping doesnt complete until the result of the closures come bsck from the network(complete)
    func performDataTask(with urlString: String, completion: @escaping (Result<Data, AppError>) -> ()) { //you cant return ->DATA cause it will always be 0 you will never get data unless you get rid of @escaping
        
        //creating a URL from the given String
        guard let url = URL(string: urlString) else {
            //handle bad url error case
            completion(.failure(.badURL(urlString)))
            return
        }
        //two states on dataTask, we have resume() and suspended by default. Suspended simply wont perform network request this ultimately leads to debugging errors and time lost if you don't explicitly resume() request
        //step 1 deal with error if any
        //this queries the API
        let dataTask = session.dataTask(with: url) { (data, response, error) in
            //if let error is an optional so we check for client error
            if let error = error {
                completion(.failure(.networkClientError(error)))
            }
            //  this is an optional and we have a parent class of URLResponse we downcasting to the class that has the status code in it
            //step 2 downcast URLResponse (response) to HTTPURLResponse
            guard let urlResponse = response as? HTTPURLResponse else {
                completion(.failure(.noResponse))
                return
            }
            // step 3 unwrap data object
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            //step 4 validate that the status code is in the 200 range otherwise its a bad status codee
            switch urlResponse.statusCode {
            case 200...299: break // everything 2went well
            default:
                completion(.failure(.badStatusCode(urlResponse.statusCode)))
                return
            }
            completion(.success(data))
        }
        dataTask.resume()//data task are on standby by default
    }
    
    func postDataTask(request:URLRequest, completion: @escaping (Result<Data,AppError>) ->()) {
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(.networkClientError(error)))
            }
            guard let response = response as? HTTPURLResponse else {
                completion(.failure(.noResponse))
                return
            }
            switch response.statusCode {
            case 200...299: break
            default:
                completion(.failure(.badStatusCode(response.statusCode)))
                
            }
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            completion(.success(data))
        }
        dataTask.resume()
    }
}
