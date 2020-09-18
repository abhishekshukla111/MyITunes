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
    
//    func getSearchResults(searchTerm: String, completion: @escaping OnCompletion) {
//         // 1
//         dataTask?.cancel()
//
//         // 2
//         if var urlComponents = URLComponents(string: "https://itunes.apple.com/search") {
//           urlComponents.query = "entity=musicVideo&term=\(searchTerm)"
//
//           // 3
//           guard let url = urlComponents.url else {
//             return
//           }
//
//           // 4
//           dataTask = defaultSession.dataTask(with: url) { [weak self] data, response, error in
//             defer {
//               self?.dataTask = nil
//             }
//
//             // 5
//             if let error = error {
//               self?.errorMessage += "DataTask error: " + error.localizedDescription + "\n"
//             } else if
//               let data = data,
//               let response = response as? HTTPURLResponse,
//               response.statusCode == 200 {
//
//               //self?.updateSearchResults(data)
//
//               // 6
//               DispatchQueue.main.async {
//                 //completion(self?.tracks, self?.errorMessage ?? "")
//               }
//             }
//           }
//
//           // 7
//           dataTask?.resume()
//         }
//       }
}
