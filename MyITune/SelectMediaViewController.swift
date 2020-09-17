//
//  SelectMediaViewController.swift
//  MyITune
//
//  Created by Abhishek Shukla on 18/09/20.
//  Copyright © 2020 Abhishek. All rights reserved.
//

import UIKit

struct MediaTypesDataSource {
    let title: String
    var isSelected: Bool
}

protocol SelectMediaDelegate: class {
    func mediaSelectionDidFinish(dataSource: [MediaTypesDataSource])
}

class SelectMediaViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    weak var delegate: SelectMediaDelegate?
   
    private var dataSource = [MediaTypesDataSource(title: "Album", isSelected: false),
                      MediaTypesDataSource(title: "Artist", isSelected: false),
                      MediaTypesDataSource(title: "Book", isSelected: false),
                      MediaTypesDataSource(title: "Movie", isSelected: false),
                      MediaTypesDataSource(title: "Music Video", isSelected: false),
                      MediaTypesDataSource(title: "Podcast", isSelected: false),
                      MediaTypesDataSource(title: "Song", isSelected: false)]
 
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
            cell.mediaTitle.text = mediaType.title
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
