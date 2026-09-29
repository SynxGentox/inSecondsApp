//
//  ViewController.swift
//  inSecondsApp
//
//  Created by Aryan Verma on 29/09/26.
//

import SwiftUI

struct ViewController: View {
    @Bindable var feedVM: FeedVM
    var body: some View {
        NavigationStack {
            Group {
                switch feedVM.appState {
                case .isLoading:
                    ProgressView()          // swap for your skeleton if you want
                case .isEmpty:
                        EmptyStateView(feedVM: feedVM)
                case .isError(let message):
                        ErrorStateView(feedVM: feedVM, msg: message)
                case .isSuccess:
                    FeedView(feedVM: feedVM)
                }
            }
            .navigationDestination(for: Opportunity.self) { opp in
                OppDetailView(
                    feedVM: feedVM,
                    id: opp.id,
                    image: opp.imageURL,
                    companyName: opp.companyName,
                    category: opp.category,
                    status: opp.status,
                    founder: opp.founder,
                    desc: opp.desc
                )
            }
        }
        .task {
            await feedVM.fetchOpportunities()
            await feedVM.loadSavedData()
        }
    }
}

#Preview {
    ViewController(feedVM: FeedVM(oppRepository: OppRepositoryImpl(oppService: OppService())))
}
