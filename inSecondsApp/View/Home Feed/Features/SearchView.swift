//
//  SearchView.swift
//  inSecondsApp
//
//  Created by Aryan Verma on 28/09/26.
//

import SwiftUI

struct SearchView: View {
    @Bindable var feedVM: FeedVM

    private var results: [Opportunity] {
        feedVM.searchFeat(searchText: feedVM.searchText)
    }

    var body: some View {
        List(results) { opp in
            NavigationLink(value: opp) {
                VStack(alignment: .leading, spacing: 2) {
                    Text(opp.companyName).font(.headline)
                    Text("\(opp.founder) • \(opp.category)")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
            }
        }
        .navigationTitle("Search")
        .searchable(text: $feedVM.searchText, prompt: "Name, founder or category")
        .overlay {
            if results.isEmpty {
                ContentUnavailableView.search(text: feedVM.searchText)
            }
        }
    }
}

#Preview {
    NavigationStack {
        SearchView(feedVM: FeedVM(oppRepository: OppRepositoryImpl(oppService: OppService())))
    }
}
