//
//  OpportunityModel.swift
//  inSecondsApp
//
//  Created by Aryan Verma on 27/09/26.
//

import Foundation

struct Opportunities: Codable {
    let opp: [Opportunity]
    
    enum CodingKeys: String, CodingKey {
        case opp = "opportunities"
    }
}

struct Opportunity: Codable, Identifiable {
    let id: String
    let companyName: String
    let founder: String
    let desc: String
    let category: String
    let status: String
    let imageURL: String
    
    enum CodingKeys: String, CodingKey {
        case id, category, status, imageURL
        
        case companyName = "startupName"
        case founder = "founderName"
        case desc = "description"
    }
}

