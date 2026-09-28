//
//  OppService.swift
//  inSecondsApp
//
//  Created by Aryan Verma on 27/09/26.
//

import Foundation

protocol OppServiceProtocol {
    func fetchData(url: URL?) async throws -> [Opportunity]
    func fetchSavedIDs() async -> Set<String>
    func saveIDs(id: Set<String>) async
    func fetchLikedIDs() async -> Set<String>
    func saveLikedIDs(id: Set<String>) async
}

struct OppService: OppServiceProtocol {
    // MARK: - Core Data Management
    func fetchData(url: URL?) async throws -> [Opportunity] {
        guard let url = url else {
            throw DataError.fileNotFound
        }
        do {
            let data = try Data(contentsOf: url)
            
            let decoder = JSONDecoder()
            
            let response = try decoder.decode(Opportunities.self, from: data)
            return response.opp
        }
        catch _ as DecodingError {
            throw DataError.decodingError
        }
        catch {
            throw DataError.noData
        }
    }
    
    
    // MARK: - Features Data Management
    // VM will make changed and saves to savedIDs array and send request to this func to fetch
    func fetchSavedIDs() async -> Set<String> {
        let rawData = UserDefaults.standard.stringArray(forKey: "savedIDs") ?? []
        return Set(rawData)
    }
    
    func saveIDs(id: Set<String>) async {
        UserDefaults.standard.set(Array(id), forKey: "savedIDs")
    }
    
    
    // VM will make changed and saves to savedLikes array and send request to this func to fetch
    func fetchLikedIDs() async -> Set<String> {
        
        let rawData = Set(UserDefaults.standard.stringArray(forKey: "savedLikes") ?? [])
        return Set(rawData)
    }
    func saveLikedIDs(id: Set<String>) async {
        UserDefaults.standard.set(Array(id), forKey: "savedLikes")
    }
}
