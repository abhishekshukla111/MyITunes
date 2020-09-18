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
    var selectedEntities: [MediaType] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func mediaTypeButtionAction(_ sender: Any) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: SelectMediaViewController.identifier) as? SelectMediaViewController {
            vc.delegate = self
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func submitButtonAction(_ sender: Any) {
        if !selectedEntities.isEmpty {
            if let vc = storyboard?.instantiateViewController(withIdentifier: ResultContainerViewController.identifier) as? ResultContainerViewController {
                let term: String = "jackjohnson"
                let viewModel = ResultViewModel(term: term, entities: selectedEntities)
                
                vc.viewModel = viewModel
                navigationController?.pushViewController(vc, animated: true)
            }
        } else {
            showAlert()
        }
    }
    
    private func showAlert() {
        let message = "Please Select a media type and Artist"
        let alertcontroller = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let actionOK = UIAlertAction(title: "OK", style: .default) { (_) in
        
        }
        alertcontroller.addAction(actionOK)
        present(alertcontroller, animated: true, completion: nil)
    }
}

extension ViewController: SelectMediaDelegate {
    func mediaSelectionDidFinish(dataSource: [MediaType]) {
        formateSelectedMedia(selectedMediaTypes: dataSource)
    }
    
    private func formateSelectedMedia(selectedMediaTypes: [MediaType]) {
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
                selectedEntities.append(mediaType)
            }
        }
        
        let finalAttributedString = NSMutableAttributedString()
        
        for selectedEntity in selectedEntities {
            let attributedString = NSAttributedString(string: selectedEntity.displayTitle, attributes: attributes)
            let spaceAttributedSting = NSAttributedString(string: "  ", attributes: blankAttributes)
            finalAttributedString.append(attributedString)
            finalAttributedString.append(spaceAttributedSting)
        }
        
        mediaTypesLabel.attributedText = finalAttributedString
    }
}


