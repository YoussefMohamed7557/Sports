//
//  NetworkServiceTest.swift
//  SportsTests
//
//  Created by Youssef on 30/05/2023.
//

import XCTest
@testable import Sports
final class NetworkServiceTest: XCTestCase {

    override func setUpWithError() throws {
      
    }

    override func tearDownWithError() throws {
        
    }

    func testGetLeguesForSpecificSportBySportName(){
        let expection = expectation(description: "wait for api")
        NetworkService.getLeague(sportName: "football", completionHandler: { leagues in
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
        NetworkService.getUpComingEvents(sportName: "football", leagueId: 4, completionHandler: { upComming in
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
        NetworkService.getUpComingEvents(sportName: "football", leagueId: 4, completionHandler: { latestEvent in
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
        NetworkService.getTeams(sportName: "football", leagueId: 1, completionHandler: { teams in
            guard let teamsList = teams?.result else{
                XCTFail("fail to catch data")
                expection.fulfill()
                return
            }
            XCTAssertNotEqual(teamsList.count, 0)
            expection.fulfill()
        })
        waitForExpectations(timeout: 10)
    }
    
    func testGetTeamDetailsForSpecificTeamByTeamID(){
        let expection = expectation(description: "wait for api")
        NetworkService.getTeamDetails(teamId: 93, completionHandler:  { teams in
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
