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

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
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
        
        let section = resultViewModel.sectionItems[0]
        let rowItem = section.rowItems?[0] as? ResultRow
        
        if rowItem?.artistName == "Some Great Artist" {
            XCTAssertTrue(true, "Row Item Created Successfully")
        } else {
            XCTFail("Row Item Creation Failed")
        }
        
    }

}
