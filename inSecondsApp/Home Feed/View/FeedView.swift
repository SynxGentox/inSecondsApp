//
//  FeedView.swift
//  inSecondsApp
//
//  Created by Aryan Verma on 28/09/26.
//

import SwiftUI

struct FeedView: View {
    @Bindable var feedVM: FeedVM
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                HStack {
                    Text("hello")
                        .padding(20)
                    Spacer()
                }
                
                .background(.red)
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .task {
            await feedVM.loadSavedData()
        }
    }
}

#Preview {
    FeedView(feedVM: FeedVM(oppRepository: OppRepositoryImpl(oppService: OppService())))
}
