//
//  UIImage Extension.swift
//  Podcast
//
//  Created by Melinda Diaz on 12/27/19.
//  Copyright © 2019 Melinda Diaz. All rights reserved.
//

import Foundation
import UIKit


extension UIImageView {
    
static func getImagesFromAPI(for imageURL: String, completion: @escaping (Result<UIImage,AppError>) ->()) {
       NetworkHelper.shared.performDataTask(with: imageURL) { (result) in
           switch result {
           case .failure(let appError):
               completion(.failure(.networkClientError(appError)))
           case .success(let data)://if you option click the data below you will get a initializer to data
               if let myImage = UIImage(data: data) {
                   completion(.success(myImage))
               }
           }
       }
   }
}
