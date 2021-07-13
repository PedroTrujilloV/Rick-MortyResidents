//
//  Rick_MortyResidentsTests.swift
//  Rick&MortyResidentsTests
//
//  Created by Pedro Enrique Trujillo Vargas on 7/12/21.
//

import XCTest
@testable import Rick_MortyResidents

class Rick_MortyResidentsTests: XCTestCase, DataSourceDelegate {
    
    
    var givenDataSource: DataSource?
    var dataSourceValue: Array<LocationViewModel>?
    var asyncExpectationTest1: XCTestExpectation?
    var asyncExpectationTest2: XCTestExpectation?

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
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
    
    //Conforming Datasource delegate
    func dataSourceDidLoad(dataSource: Array<LocationViewModel>) {
        print("\n\n > Rick&MortyResidentsTests dataSourceDidLoad count: \(dataSource.count)\n\n")
        
        if let expectation = asyncExpectationTest1 {
              //XCTFail("delegate was not setup correctly. Missing XCTExpectation reference")
            expectation.fulfill()
            asyncExpectationTest1 = nil
        } else { print("asyncExpectationTest1 Delegate was not setup correctly, or is not being tested. Missing XCTExpectation reference\n")}
        
        if let expectation = asyncExpectationTest2 {
            expectation.fulfill()
            asyncExpectationTest2 = nil
        } else { print("asyncExpectationTest2 Delegate was not setup correctly, or is not being tested. Missing XCTExpectation reference\n")}
    
        self.dataSourceValue = dataSource
    }
    
    
    func test1DataSourceInitialization() {
        test1DataSourceInitialization(completion: nil)
    }
    
    func test1DataSourceInitialization(completion: (() -> Void )? )  {
        let givenNext = "https://rickandmortyapi.com/api/location?page=2"
        let givenExpectation1 = expectation(description: " test2DataSourceNext expectation1")
        
        //when
        self.asyncExpectationTest1 = givenExpectation1
        self.givenDataSource = DataSource(delegate: self)

        self.waitForExpectations(timeout: 10) { error in
            if let error = error {
              XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
            guard let next = self.givenDataSource?.currentResult?.info.next else {print("\ntest1DataSourceInitialization: No next url in result\n"); return}

            //then
            XCTAssertTrue(next == givenNext)
            
            guard let completion = completion else {return}
            completion()
        }
    }
    
    
    func test2DataSourceNext()  {
        //given
        let givenNext = "https://rickandmortyapi.com/api/location?page=3"
        
        //when
        test1DataSourceInitialization {
            let givenExpectation2 = self.expectation(description: " test2DataSourceNext expectation2")
            self.asyncExpectationTest2 = givenExpectation2
            self.givenDataSource?.loadNext()
            self.waitForExpectations(timeout: 10) { error in
              if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
              }
                guard let next = self.givenDataSource?.currentResult?.info.next else {print("\ntest2DataSourceNext: No next url in result\n"); return}
                
                //then
                XCTAssertTrue(next == givenNext)
            }
        }
    }
    
    
    func test3DataSourceRetrieveResident(){
        let givenImageStringURL = "https://rickandmortyapi.com/api/character/avatar/38.jpeg"
        let giveResidentURL = "https://rickandmortyapi.com/api/character/38"
        let givenExpectation = expectation(description: "test3DataSourceRetrieveImageModel expectation")
        //when
        DataSource.retrieveResident(with: giveResidentURL) { resident  in
            let image = resident?.image
            //then
            XCTAssertTrue(givenImageStringURL == image)
            givenExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 5) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
        }
    }

}