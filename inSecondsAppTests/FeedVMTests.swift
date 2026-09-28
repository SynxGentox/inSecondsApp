//
//  FeedVMTests.swift
//  inSecondsAppTests
//
//  Created by Aryan Verma on 28/09/26.
//

import Testing
import Foundation
@testable import inSecondsApp

// In-memory stand-in for the repository, so tests never touch UserDefaults or the bundle.
final class MockOppRepository: OppRepository, @unchecked Sendable {
    var opps: [Opportunity]
    var savedIDs: Set<String> = []
    var likedIDs: Set<String> = []
    var error: Error?

    init(opps: [Opportunity] = []) { self.opps = opps }

    func fetchOpp() async throws -> [Opportunity] {
        if let error { throw error }
        return opps
    }
    func fetchSavedIDs() async -> Set<String> { savedIDs }
    func saveIDs(id: Set<String>) async { savedIDs = id }
    func fetchLikedIDs() async -> Set<String> { likedIDs }
    func saveLikedIDs(id: Set<String>) async { likedIDs = id }
}

@MainActor
struct FeedVMTests {
    static let sample: [Opportunity] = [
        Opportunity(id: "1", companyName: "Finora", founder: "Riya Sharma", desc: "Finance app",
                    category: "Fintech", status: "Active", imageURL: ""),
        Opportunity(id: "2", companyName: "NovaGrid", founder: "Aarav Mehta", desc: "Automation",
                    category: "Software", status: "Hiring", imageURL: ""),
        Opportunity(id: "3", companyName: "CloudNest", founder: "Aditya Nair", desc: "Infra",
                    category: "Developer Tools", status: "Seed", imageURL: "")
    ]

    private func makeVM(_ repo: MockOppRepository = MockOppRepository(opps: FeedVMTests.sample)) -> FeedVM {
        FeedVM(oppRepository: repo)
    }

    // MARK: - Decoding / data layer

    @Test func decodingMapsRenamedJSONKeys() throws {
        let json = """
        {"opportunities":[{"id":"opp_001","startupName":"inSeconds","founderName":"Mr. Pratham",
        "description":"Desc","category":"Software","status":"Active","imageURL":"https://example.com/a.png"}]}
        """
        let decoded = try JSONDecoder().decode(Opportunities.self, from: Data(json.utf8))
        #expect(decoded.opp.count == 1)
        #expect(decoded.opp[0].companyName == "inSeconds")
        #expect(decoded.opp[0].founder == "Mr. Pratham")
        #expect(decoded.opp[0].desc == "Desc")
    }

    @Test func serviceMapsBadInputToTypedErrors() async throws {
        await #expect(throws: DataError.fileNotFound) {
            try await OppService().fetchData(url: nil)
        }
        let url = FileManager.default.temporaryDirectory.appendingPathComponent("bad.json")
        try Data(#"{"wrong":1}"#.utf8).write(to: url)
        await #expect(throws: DataError.decodingError) {
            try await OppService().fetchData(url: url)
        }
    }

    // MARK: - Search

    @Test func searchMatchesNameFounderCategoryCaseInsensitively() {
        let vm = makeVM()
        vm.opportunity = Self.sample
        #expect(vm.searchFeat(searchText: "FINORA").map(\.id) == ["1"])   // name
        #expect(vm.searchFeat(searchText: "mehta").map(\.id) == ["2"])    // founder
        #expect(vm.searchFeat(searchText: "tools").map(\.id) == ["3"])    // category
        #expect(vm.searchFeat(searchText: "").count == 3)                 // empty query = all
        #expect(vm.searchFeat(searchText: "zzz").isEmpty)                 // no match
    }

    // MARK: - Save / like

    @Test func saveTogglesAndPersistsToRepository() async {
        let repo = MockOppRepository()
        let vm = makeVM(repo)
        await vm.save(id: "1")
        #expect(vm.saveIDs == ["1"])
        #expect(repo.savedIDs == ["1"])
        await vm.save(id: "1")
        #expect(vm.saveIDs.isEmpty)
        #expect(repo.savedIDs.isEmpty)
    }

    @Test func savedAndLikedStateReloadsFromRepository() async {
        let repo = MockOppRepository()
        repo.savedIDs = ["2"]
        repo.likedIDs = ["3"]
        let vm = makeVM(repo)          // a fresh VM stands in for an app relaunch
        await vm.loadSavedData()
        #expect(vm.saveIDs == ["2"])
        #expect(vm.saveLikes == ["3"])
    }

    // MARK: - Loading / empty / error states

    @Test func fetchMovesFromLoadingToSuccess() async {
        let vm = makeVM()
        #expect(vm.appState == .isLoading)
        await vm.fetchOpportunities()
        #expect(vm.appState == .isSuccess)
        #expect(vm.opportunity.count == 3)
    }

    @Test func emptyResultSetsEmptyState() async {
        let vm = makeVM(MockOppRepository(opps: []))
        await vm.fetchOpportunities()
        #expect(vm.appState == .isEmpty)
    }

    @Test func failureSetsErrorStateWithTypedMessage() async {
        let repo = MockOppRepository()
        repo.error = DataError.fileNotFound
        let vm = makeVM(repo)
        await vm.fetchOpportunities()
        #expect(vm.appState == .isError(DataError.fileNotFound.rawValue))
    }
}
