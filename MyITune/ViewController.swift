//
//  ViewController.swift
//  MyITune
//
//  Created by Abhishek Shukla on 17/09/20.
//  Copyright © 2020 Abhishek. All rights reserved.
//

import Foundation
import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var mediaTypesLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ServiceManager().fetchFilms()
    }
    
    @IBAction func mediaTypeButtionAction(_ sender: Any) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: SelectMediaViewController.identifier) as? SelectMediaViewController {
            vc.delegate = self
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func submitButtonAction(_ sender: Any) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: ResultContainerViewController.identifier) as? ResultContainerViewController {
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension ViewController: SelectMediaDelegate {
    func mediaSelectionDidFinish(dataSource: [MediaTypesDataSource]) {
        formateSelectedMedia(selectedMediaTypes: dataSource)
    }
    
    private func formateSelectedMedia(selectedMediaTypes: [MediaTypesDataSource]) {
        var selectedMedia: [String] = []
        let space = "  "
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white,
            .backgroundColor: UIColor.blue,
            .font: UIFont.boldSystemFont(ofSize: 20)]

        let blankAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white,
            .backgroundColor: UIColor.clear,
            .font: UIFont.boldSystemFont(ofSize: 20)]
        
        for mediaType in selectedMediaTypes {
            if mediaType.isSelected {
                selectedMedia.append(mediaType.title)
            }
        }
        
        let finalAttributedString = NSMutableAttributedString()
        
        for mediaType in selectedMedia {
            let attributedString = NSAttributedString(string: mediaType, attributes: attributes)
            let spaceAttributedSting = NSAttributedString(string: space, attributes: blankAttributes)
            finalAttributedString.append(attributedString)
            finalAttributedString.append(spaceAttributedSting)
        }
        
        mediaTypesLabel.attributedText = finalAttributedString
    }
}


