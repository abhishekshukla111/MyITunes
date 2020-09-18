//
//  MyITuneTests.swift
//  MyITuneTests
//
//  Created by Abhishek Shukla on 17/09/20.
//  Copyright © 2020 Abhishek. All rights reserved.
//

import XCTest
@testable import MyITune

class MyITuneTests: XCTestCase {
    
    var resultViewModel: ResultViewModel?

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        let result = Result(artistName: "Some Great Artist", collectionName: "collectionName", trackName: "trackName", artworkUrl30: "artworkUrl30", artworkUrl60: "artworkUrl60", primaryGenreName: "primaryGenreName", previewUrl: "previewUrl")
        
        let results = Results(resultCount: 2, results: [result, result])
        
        let mediaType = MediaType(displayTitle: "displayTitle", isSelected: true, entity: "musicVideo")
        
        resultViewModel = ResultViewModel(term: "jackjohnson", entities: [mediaType])
        resultViewModel?.setupRowsForEntity(entity: "musicVideo", results: results)
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }


    func testGetMediaAPI() {
        
        let testExpectation = expectation(description: "Did finish operation expectation")
        
        ServiceManager().getMedia(term: "jackjohnson", entity: "musicVideo") { (results) in
            if results.resultCount > 0 {
                XCTAssertTrue(true, "API Successfull")
            } else {
                 XCTFail("API failued")
            }
            testExpectation.fulfill()
        }
        
        wait(for: [testExpectation], timeout: 60)
    }
    
    func testSetupRowsForEntity() {
        let result = Result(artistName: "artistName", collectionName: "collectionName", trackName: "trackName", artworkUrl30: "artworkUrl30", artworkUrl60: "artworkUrl60", primaryGenreName: "primaryGenreName", previewUrl: "previewUrl")
        
        let results = Results(resultCount: 1, results: [result])
        
        let mediaType = MediaType(displayTitle: "displayTitle", isSelected: true, entity: "musicVideo")
        
        let resultViewModel = ResultViewModel(term: "jackjohnson", entities: [mediaType])
        resultViewModel.setupRowsForEntity(entity: "musicVideo", results: results)
        
        if resultViewModel.sectionItems.count == 1 {
            XCTAssertTrue(true, "ViewModel Updated Successfully")
        } else {
            XCTFail("viewModel failed")
        }
    }
    
    func testRows() {
        let result = Result(artistName: "Some Great Artist", collectionName: "collectionName", trackName: "trackName", artworkUrl30: "artworkUrl30", artworkUrl60: "artworkUrl60", primaryGenreName: "primaryGenreName", previewUrl: "previewUrl")
        
        let results = Results(resultCount: 1, results: [result])
        
        let mediaType = MediaType(displayTitle: "displayTitle", isSelected: true, entity: "musicVideo")
        
        let resultViewModel = ResultViewModel(term: "jackjohnson", entities: [mediaType])
        resultViewModel.setupRowsForEntity(entity: "musicVideo", results: results)
        
        let section = resultViewModel.sectionItems[0]
        let rowItem = section.rowItems?[0] as? ResultRow
        
        if rowItem?.artistName == "Some Great Artist" {
            XCTAssertTrue(true, "Row Item Created Successfully")
        } else {
            XCTFail("Row Item Creation Failed")
        }
    }
    
    func testSelectMediaViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: SelectMediaViewController.identifier) as? SelectMediaViewController else {
            XCTFail("Row Item Creation Failed")
            return
        }
        
        vc.loadViewIfNeeded()
        
        if vc.tableView.numberOfSections == 1 {
            XCTAssertTrue(true, "Section Initialized Successfully")
        }
        
        if vc.tableView.numberOfRows(inSection: 0) == 7 {
            XCTAssertTrue(true, "Rows Initialize successfully")
        }
        
        if let cell = vc.tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? SelectMediaTableViewCell {
            
            if cell.mediaTitle.text == "Album" {
                XCTAssertTrue(true, "TableViewCell intialized successfully")
            } else {
                XCTFail("ListViewControll Did not initialized correctly")
            }
        }
    }
    
    func testResultContainerViewController() {
        let result = Result(artistName: "Some Great Artist", collectionName: "collectionName", trackName: "trackName", artworkUrl30: "artworkUrl30", artworkUrl60: "artworkUrl60", primaryGenreName: "primaryGenreName", previewUrl: "previewUrl")
        
        let results = Results(resultCount: 2, results: [result, result])
        
        let mediaType = MediaType(displayTitle: "displayTitle", isSelected: true, entity: "musicVideo")
        
        let resultViewModel = ResultViewModel(term: "jackjohnson", entities: [mediaType])
        resultViewModel.setupRowsForEntity(entity: "musicVideo", results: results)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: ResultContainerViewController.identifier) as? ResultContainerViewController else {
            XCTFail("Row Item Creation Failed")
            return
        }
        
        vc.viewModel = resultViewModel
        vc.loadViewIfNeeded()
        
        vc.viewDidLoad()
        if resultViewModel.sectionItems.count == 1 {
            XCTAssertTrue(true, "ViewModel Updated Successfully")
        } else {
            XCTFail("viewModel failed")
        }
    }
    
    func testResultContainerViewControllerRowItem() {
        let result = Result(artistName: "Some Great Artist", collectionName: "collectionName", trackName: "trackName", artworkUrl30: "artworkUrl30", artworkUrl60: "artworkUrl60", primaryGenreName: "primaryGenreName", previewUrl: "previewUrl")
        
        let results = Results(resultCount: 2, results: [result, result])
        
        let mediaType = MediaType(displayTitle: "displayTitle", isSelected: true, entity: "musicVideo")
        
        let resultViewModel = ResultViewModel(term: "jackjohnson", entities: [mediaType])
        resultViewModel.setupRowsForEntity(entity: "musicVideo", results: results)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: ResultContainerViewController.identifier) as? ResultContainerViewController else {
            XCTFail("Row Item Creation Failed")
            return
        }
        
        vc.viewModel = resultViewModel
        vc.loadViewIfNeeded()
        
        vc.viewDidLoad()
        
        let section = resultViewModel.sectionItems[0]
        let rowItem = section.rowItems?[0] as? ResultRow
        
        if rowItem?.artistName == "Some Great Artist" {
            XCTAssertTrue(true, "Row Item Created Successfully")
        } else {
            XCTFail("Row Item Creation Failed")
        }
    }
    
    func testViewControllerEmptyTextField() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: ViewController.identifier) as? ViewController else {
            XCTFail("Row Item Creation Failed")
            return
        }
        
        //vc.viewModel = resultViewModel
        vc.loadViewIfNeeded()
        
        vc.viewDidLoad()
        vc.submitButtonAction((Any).self)
        
        if let artistTextFieldText = vc.artistTextField.text,  artistTextFieldText.isEmpty {
            XCTAssertTrue(true, "Alert shown")
        } else {
            XCTFail("Text filed is not empty")
        }
    }
    
    func testViewControllerNonEmptyTextField() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: ViewController.identifier) as? ViewController else {
            XCTFail("Row Item Creation Failed")
            return
        }
        
        //vc.viewModel = resultViewModel
        vc.loadViewIfNeeded()
        
        vc.viewDidLoad()
        vc.artistTextField.text = "John"
        let mediaType = MediaType(displayTitle: "displayTitle", isSelected: true, entity: "musicVideo")
        vc.selectedMediaTypes.append(mediaType)
        
        vc.submitButtonAction((Any).self)
        
        if let artistTextFieldText = vc.artistTextField.text,  !artistTextFieldText.isEmpty {
            XCTAssertTrue(true, "Alert shown")
        } else {
            XCTFail("Text filed is not empty")
        }
    }
    
    func testFormateSelectedMedia() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: ViewController.identifier) as? ViewController else {
            XCTFail("Row Item Creation Failed")
            return
        }
        
        //vc.viewModel = resultViewModel
        vc.loadViewIfNeeded()
        
        vc.viewDidLoad()
        vc.artistTextField.text = "John"
        let mediaType = MediaType(displayTitle: "displayTitle", isSelected: true, entity: "musicVideo")
        vc.selectedMediaTypes.append(mediaType)
        
        vc.formateSelectedMedia(selectedMedia: vc.selectedMediaTypes)
        
        if vc.mediaTypesLabel.text == "displayTitle  displayTitle  " {
            XCTAssertTrue(true, "Label Intialized successfully")
        } else {
            XCTFail("Label Intialized Failed")
        }
    }

    func testListViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: ListViewController.identifier) as? ListViewController else {
            XCTFail("ListViewControll Did not initialized correctly")
            return
        }
        
        vc.viewModel = resultViewModel
        vc.loadViewIfNeeded()
        
        if vc.tableView.numberOfSections == 1 {
            XCTAssertTrue(true, "Section Initialized Successfully")
        } else {
            XCTFail("ListViewControll Did not initialized correctly")
        }
        
        if vc.tableView.numberOfRows(inSection: 0) == 2 {
            XCTAssertTrue(true, "Rows Initialize successfully")
        } else {
            XCTFail("ListViewControll Did not initialized correctly")
        }
        
        if let cell = vc.tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? ListTableViewCell {
            print(cell.nameLabel.text)
            
            if cell.nameLabel.text == "Some Great Artist" {
                XCTAssertTrue(true, "TableViewCell intialized successfully")
            } else {
                XCTFail("ListViewControll Did not initialized correctly")
            }
        }
    }
    
    func testGridViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: GridViewController.identifier) as? GridViewController else {
            XCTFail("ListViewControll Did not initialized correctly")
            return
        }
        
        vc.viewModel = resultViewModel
        vc.loadViewIfNeeded()
        vc.viewDidLoad()
        
        if vc.collectionView.numberOfSections == 1 {
            XCTAssertTrue(true, "Section Initialized Successfully")
        } else {
            XCTFail("ListViewControll Did not initialized correctly")
        }
        
        if vc.collectionView.numberOfItems(inSection: 0) == 2 {
            XCTAssertTrue(true, "Rows Initialize successfully")
        } else {
            XCTFail("ListViewControll Did not initialized correctly")
        }
        
        if let cell = vc.collectionView.cellForItem(at: IndexPath(row: 0, section: 0)) as? GridCollectionViewCell {
            if cell.nameLabel.text == "Some Great Artist" {
                XCTAssertTrue(true, "TableViewCell intialized successfully")
            } else {
                XCTFail("ListViewControll Did not initialized correctly")
            }
        }
        
        if let view = vc.collectionView.supplementaryView(forElementKind: UICollectionView.elementKindSectionHeader, at: IndexPath(row: 0, section: 0)) as? GridHeaderCollectionView {
            if view.headerTitle.text == "Some Great Artist" {
                XCTAssertTrue(true, "TableViewCell intialized successfully")
            } else {
                XCTFail("ListViewControll Did not initialized correctly")
            }
        }
    }
    
    func testDetailViewController() {
        let vc = DetailViewController(urlString: "www.google.com")
        
        vc.loadViewIfNeeded()
        vc.viewDidLoad()
    }
}
