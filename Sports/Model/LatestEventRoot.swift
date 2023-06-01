//
//  LatestEventRoot.swift
//  Sports
//
//  Created by Youssef on 29/05/2023.
//

import Foundation
class LatestEventRoot : Decodable {
    var success : Int?
    var result : [LatestEvents]
}
