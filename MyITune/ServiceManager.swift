//
//  ServiceManager.swift
//  iTunes
//
//  Created by Abhishek Shukla on 17/09/20.
//  Copyright © 2020 Abhishek. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

typealias OnCompletion = (_ results: Results) -> Void
//https://itunes.apple.com/search?term=jackjohnson&amp;entity=musicVideo


class ServiceManager {
    let defaultSession = URLSession(configuration: .default)
    var dataTask: URLSessionDataTask?
    var errorMessage = ""
    
    func getMedia(term: String, entity: String, completion: @escaping OnCompletion ) {
        let parameters: [String: String] = [
            "term" : term,
            "entity": entity]

        let request = NetworkRouter.ituneSearch(params: parameters)
        AF.request(request).validate().responseDecodable(of: Results.self) { (response) in
            guard let results = response.value else { return }
            
            completion(results)
            print("results: \(results)")
        }
    }
}
