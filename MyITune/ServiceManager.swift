//
//  ServiceManager.swift
//  iTunes
//
//  Created by Abhishek Shukla on 17/09/20.
//  Copyright © 2020 Abhishek. All rights reserved.
//

import Foundation
import Alamofire

typealias OnCompletion = (_ results: Results) -> Void

class ServiceManager {
    
    func getMedia(term: String, entity: String, completion: @escaping OnCompletion ) {
        let parameters: [String: String] = [
            "term" : term,
            "entity": entity]

        let request = NetworkRouter.ituneSearch(params: parameters)
        AF.request(request).validate().responseDecodable(of: Results.self) { (response) in
            guard let results = response.value else { return }
            
            completion(results)
        }
    }
}
