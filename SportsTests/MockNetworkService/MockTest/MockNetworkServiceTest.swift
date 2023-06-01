//
//  MockNetworkServiceTest.swift
//  SportsTests
//
//  Created by Youssef on 30/05/2023.
//

import XCTest
@testable import Sports
final class MockNetworkServiceTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGetLeguesForSpecificSportBySportName(){
        let expection = expectation(description: "wait for api")
        MockNetworkService.getLeague(sportName: "football", completionHandler: { leagues in
            guard let leagueList = leagues?.result else{
                XCTFail("fail to catch data")
                expection.fulfill()
                return
            }
            XCTAssertNotEqual(leagueList.count, 0)
            expection.fulfill()
        })
        waitForExpectations(timeout: 5)
    }
    
    func testGetUpComingEventsForSpecificLeaguetBySportNameandLeagueID(){
        let expection = expectation(description: "wait for api")
        MockNetworkService.getUpComingEvents(sportName: "football", leagueId: 4, completionHandler: { upComming in
            guard let upcommingList = upComming?.result else{
                XCTFail("fail to catch data")
                expection.fulfill()
                return
            }
            XCTAssertNotEqual(upcommingList.count, 0)
            expection.fulfill()
        })
        waitForExpectations(timeout: 5)
    }
    
    func testGetLatestEventsForSpecificLeaguetBySportNameandLeagueID(){
        let expection = expectation(description: "wait for api")
        MockNetworkService.getUpComingEvents(sportName: "football", leagueId: 4, completionHandler: { latestEvent in
            guard let latestEventsList = latestEvent?.result else{
                XCTFail("fail to catch data")
                expection.fulfill()
                return
            }
            XCTAssertNotNil(latestEventsList)
            expection.fulfill()
        })
        waitForExpectations(timeout: 5)
    }
    
    func testGetTeamsForSpecificLeaguetBySportNameandLeagueID(){
        let expection = expectation(description: "wait for api")
        MockNetworkService.getTeams(sportName: "football", leagueId: 4, completionHandler: { teams in
            guard let teamsList = teams?.result else{
                XCTFail("fail to catch data")
                expection.fulfill()
                return
            }
            XCTAssertNotEqual(teamsList.count, 0)
            expection.fulfill()
        })
        waitForExpectations(timeout: 5)
    }
    
    func testGetTeamDetailsForSpecificTeamByTeamID(){
        let expection = expectation(description: "wait for api")
        MockNetworkService.getTeamDetails(teamId: 93, completionHandler:  { teams in
            guard let teamsList = teams?.result else{
                XCTFail("fail to catch data")
                expection.fulfill()
                return
            }
            // only one team return with details
            XCTAssertEqual(teamsList.count, 1)
            expection.fulfill()
        })
        waitForExpectations(timeout: 5)
    }


}
