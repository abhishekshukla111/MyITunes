//
//  SelectMediaViewController.swift
//  MyITune
//
//  Created by Abhishek Shukla on 18/09/20.
//  Copyright © 2020 Abhishek. All rights reserved.
//

import UIKit

struct MediaType {
    let displayTitle: String
    var isSelected: Bool
    let entity: String
}

protocol SelectMediaDelegate: class {
    func mediaSelectionDidFinish(dataSource: [MediaType])
}

class SelectMediaViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    weak var delegate: SelectMediaDelegate?
   
    private var dataSource = [MediaType(displayTitle: "Album",  isSelected: false, entity: "album"),
                              MediaType(displayTitle: "Artist", isSelected: false, entity: "artist"),
                              MediaType(displayTitle: "Book",   isSelected: false, entity: "book"),
                              MediaType(displayTitle: "Movie",  isSelected: false, entity: "movie"),
                              MediaType(displayTitle: "Music Video", isSelected: false, entity: "musicVideo"),
                              MediaType(displayTitle: "Podcast", isSelected: false, entity: "podcast"),
                              MediaType(displayTitle: "Song",    isSelected: false, entity: "song")]
 
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        delegate?.mediaSelectionDidFinish(dataSource: dataSource)
    }
}

extension SelectMediaViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: SelectMediaTableViewCell.identifier) as? SelectMediaTableViewCell {
            let mediaType = dataSource[indexPath.row]
            cell.mediaTitle.text = mediaType.displayTitle
            cell.checkImageView.isHidden = !mediaType.isSelected
            return cell
        }
        return UITableViewCell()
    }
}

extension SelectMediaViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var mediaType = dataSource[indexPath.row]
        mediaType.isSelected = !mediaType.isSelected
        dataSource[indexPath.row] = mediaType
        
        tableView.reloadData()
    }
}
