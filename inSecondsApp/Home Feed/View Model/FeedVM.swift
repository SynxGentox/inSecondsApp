//
//  HomeVM.swift
//  inSecondsApp
//
//  Created by Aryan Verma on 27/09/26.
//

import Foundation
import Observation

@Observable
@MainActor
final class FeedVM {
    var opportunity: [Opportunity] = []
    var appState: DataState = DataState.isLoading
    var searchText: String = ""
    var saveIDs: Set<String> = []
    var saveLikes: Set<String> = []
    private let oppRepository: OppRepository
    
    init(oppRepository: OppRepository) {
        self.oppRepository = oppRepository
    }
    
// MARK: - Core Data
    func fetchOpportunities() async {
        if opportunity.isEmpty {
            appState = DataState.isLoading
        }
        do {
            let result = try await oppRepository.fetchOpp()
            if result.isEmpty {
                appState = .isEmpty
            }
            else {
                opportunity = result
                appState = .isSuccess
            }
        }
        catch {
            appState = .isError(error.localizedDescription)
        }
    }
    
// MARK: - Searching
    func searchFeat(searchText: String) -> [Opportunity] {
        guard !searchText.isEmpty else {
            return opportunity
        }
        return opportunity.filter {
            $0.companyName.localizedCaseInsensitiveContains(searchText) ||
            $0.founder.localizedCaseInsensitiveContains(searchText) ||
            $0.category.localizedCaseInsensitiveContains(searchText)
        }
    }
    
// MARK: - Like and Save
// Initial VM property update
    func loadSavedData() async {
        await displaySaves()
        await displayLikes()
    }
    
    private func displaySaves() async {
        self.saveIDs = await oppRepository.fetchSavedIDs()
    }
    
    private func displayLikes() async {
        self.saveLikes = await oppRepository.fetchLikedIDs()
    }
    
    
// Saving and Updating VM Data
    // Save Feature
    func save(id: String) async {
        if saveIDs.contains(id) {
            saveIDs.remove(id)
        }
        else {
            saveIDs.insert(id)
        }
        await oppRepository.saveIDs(id: saveIDs)
    }
    
    // Like Feature
    func like(id: String) async {
        if saveLikes.contains(id) {
            saveLikes.remove(id)
        }
        else {
            saveLikes.insert(id)
        }
        await oppRepository.saveLikedIDs(id: saveLikes)
    }
}

