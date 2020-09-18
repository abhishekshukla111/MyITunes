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
    var sessionItems: [String] = []
    
    init(term: String, entities: [String]) {
        self.term = term
        self.entities = entities
    }
}
