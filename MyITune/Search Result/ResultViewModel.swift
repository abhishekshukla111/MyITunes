//
//  ResultViewModel.swift
//  MyITune
//
//  Created by Abhishek Shukla on 18/09/20.
//  Copyright © 2020 Abhishek. All rights reserved.
//

import Foundation

class ResultViewModel {
    var term: String = "jackjohnson"
    var entities: [String] = ["musicVideo"]
    var sectionItems: [ResultSection] = []
    
    init(term: String, entities: [String]) {
        self.term = term
        self.entities = entities
    }
    
    func setupRowsForEntity(entity: String, results: Results) {
        var resultRows: [ResultRow] = []
        for result in results.results {
            let resultRow = ResultRow(artistName: result.artistName ?? "Unknown", trackName: result.trackName ?? "Unknown", artworkUrl100: result.artworkUrl100 ?? "", artworkUrl60: result.artworkUrl60 ?? "")
            resultRows.append(resultRow)
        }
        let section = ResultSection(title: entity, rowItems: resultRows)
        sectionItems.append(section)
    }
}
