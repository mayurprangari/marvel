//
//  NetworkUtilityTest.swift
//  MarvelTests
//
//  Created by Mayur Rangari on 16/03/22.
//

import Foundation
import XCTest
@testable import Marvel

class NetworkUtilityTest: XCTestCase {
    var listViewModel = ListViewModel()
    var result: [Result]?
    var comicsViewModel = ComicsViewModel()
    var comicsResult  : [Results]?
    var results: Result?

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    // MARK: - Api Call Character List
    func testRetrieveDataFromCharacterListAPI() {
        listViewModel.getDataFromApi(apiUrl: "\(Constants.baseUrl)\(Constants.charactersAPI)?ts=\(Constants.ts)&apikey=\(Constants.apiKey)&hash=\(Constants.hashKey)") { response, status in
            if status {
                self.result = response.data?.results
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    XCTAssertTrue(response.data != nil)
                    XCTAssertTrue((response.data?.results ?? []).count > 0)
                    self.result = response.data?.results ?? []
                }
            }else{
                DispatchQueue.main.async {
                    XCTAssertFalse(self.result!.count > 0)
                }
            }
        }
    }
    
    // MARK: - Api Call Comic List
    func testRetrieveDataFromComicLisAPI() {
        comicsViewModel.getDataFromApi(apiUrl: "\(Constants.baseUrl)\(Constants.charactersAPI)/\(results?.id! ?? 0)/comics?ts=\(Constants.ts)&apikey=\(Constants.apiKey)&hash=\(Constants.hashKey)") { response, status in
            if status{
                self.comicsResult = response.data?.results
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    XCTAssertTrue(response.data != nil)
                    XCTAssertTrue((response.data?.results ?? []).count > 0)
                    self.comicsResult = response.data?.results ?? []
                }
            }else{
                DispatchQueue.main.async {
                    XCTAssertFalse(self.comicsResult!.count > 0)
                }
            }
        }
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
