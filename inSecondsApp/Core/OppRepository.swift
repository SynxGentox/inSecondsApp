//
//  OppRepository.swift
//  inSecondsApp
//
//  Created by Aryan Verma on 27/09/26.
//

import Foundation

protocol OppRepository {
    func fetchOpp() async throws -> [Opportunity]
    
    func fetchSavedIDs() async -> Set<String>
    func saveIDs(id: Set<String>) async
    
    func fetchLikedIDs() async -> Set<String>
    func saveLikedIDs(id: Set<String>) async
}

final class OppRepositoryImpl: OppRepository {
    private let oppService: OppService
    
    init(oppService: OppService) {
        self.oppService = oppService
    }
    
    func fetchOpp() async throws -> [Opportunity] {
        let url: URL? = Bundle.main.url(
            forResource: "opportunities",
            withExtension: "json"
        )
        
        return try await oppService.fetchData(url: url)
    }
    
    func fetchSavedIDs() async -> Set<String> {
        return await oppService.fetchSavedIDs()
    }
    func saveIDs(id: Set<String>) async {
        await oppService.saveIDs(id: id)
    }
    
    func fetchLikedIDs() async -> Set<String> {
        return await oppService.fetchLikedIDs()
    }
    func saveLikedIDs(id: Set<String>) async {
        await oppService.saveLikedIDs(id: id)
    }
}
