//
//  ErrorStateView.swift
//  inSecondsApp
//
//  Created by Aryan Verma on 29/09/26.
//

import SwiftUI

struct ErrorStateView: View {
    let feedVM: FeedVM
    let msg: String
    var body: some View {
        PrimaryButton(buttonDisplay: "arrow.clockwise", infinite: false, alignLeft: false) {
            Task { await feedVM.fetchOpportunities() }
        }
        Text("Retry")
            .padding(.bottom)
        Text(msg)
            .primaryStyle(fontSize: FontT.primary)
    }
}

#Preview {
    ErrorStateView(feedVM: FeedVM(oppRepository: OppRepositoryImpl(oppService: OppService())), msg: "error msg")
}
