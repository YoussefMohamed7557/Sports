//
//  MockLeagueResponce.swift
//  SportsTests
//
//  Created by Youssef on 30/05/2023.
//

import Foundation
@testable import Sports
class MockLeagueResponce {
    static var leagueResponce = """
                    {
                      "success": 1,
                      "result": [
                        {
                          "league_key": 4,
                          "league_name": "UEFA Europa League",
                          "country_key": 1,
                          "country_name": "eurocups",
                          "league_logo": "https://apiv2.allsportsapi.com/logo/logo_leagues/",
                          "country_logo": null
                        },
                        {
                          "league_key": 1,
                          "league_name": "European Championship",
                          "country_key": 1,
                          "country_name": "eurocups",
                          "league_logo": null,
                          "country_logo": null
                        }
                        ]
                       }
"""
}

