//
//  EmptyStateView.swift
//  inSecondsApp
//
//  Created by Aryan Verma on 29/09/26.
//

import SwiftUI

struct EmptyStateView: View {
    let feedVM: FeedVM
    
    var body: some View {
        PrimaryButton(buttonDisplay: "arrow.clockwise", infinite: false, alignLeft: false) {
            Task { await feedVM.fetchOpportunities() }
        }
        Text("Retry")
            .padding(.bottom)
        Text("No data :(")
            .primaryStyle(fontSize: FontT.primary)
    }
}

#Preview {
    EmptyStateView(feedVM: FeedVM(oppRepository: OppRepositoryImpl(oppService: OppService())))
}
