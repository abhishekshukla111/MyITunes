//
//  SectionItem.swift
//  MyITune
//
//  Created by Abhishek Shukla on 18/09/20.
//  Copyright © 2020 Abhishek. All rights reserved.
//

import Foundation
protocol SectionItem {
    var sectionTitle: String { get set }
    var rowCount: Int { get set }
    var rowItems: [RowItem]? { get set }
}

extension SectionItem {
    var rowCount: Int {
        return 1
    }
    
    var isCollapsible: Bool {
        if rowCount == 0 {
            return false
        }
        return true
    }
}

class ResultSection: SectionItem {
    var sectionTitle: String
    var rowItems: [RowItem]?
    var rowCount: Int

    init(title: String, rowItems: [RowItem]?) {
        self.sectionTitle = title
        self.rowItems = rowItems
        self.rowCount = rowItems?.count ?? 0
    }
}


protocol RowItem {
}

// MARK: - Header Row
class ResultRow: RowItem {
    var artistName: String?
    var trackName: String?
    var artworkUrl100: String?
    var artworkUrl60: String?
    
    init(artistName: String, trackName: String, artworkUrl100: String, artworkUrl60: String) {
        self.artistName = artistName
        self.trackName = trackName
        self.artworkUrl100 = artworkUrl100
        self.artworkUrl60 = artworkUrl60
    }
}
