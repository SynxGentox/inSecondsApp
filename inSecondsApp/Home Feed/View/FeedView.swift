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
            ZStack {
                ScrollView(showsIndicators: false) {
                    LazyVStack(spacing: 0) {
                        ForEach (feedVM.opportunity) { opp in
                            ZStack {
                                
                                APIImage(image: opp.imageURL)
                                VStack(alignment: .leading, spacing: 0) {
                                    FeedTopDesc(feedVM: feedVM, category: opp.category)

                                    GetColor.clear
                                        .frame(alignment: .center)
                                        .allowsHitTesting(false)

                                    FeedControls(feedVM: feedVM, id: opp.id)
                                    Divider()
                                    FeedDesc(
                                        feedVM: feedVM,
                                        id: opp.id,
                                        companyName: opp.companyName,
                                        status: opp.status,
                                        founder: opp.founder,
                                        desc: opp.desc
                                    )
                                }
                            }
                            .containerRelativeFrame(.vertical)
                        }
                    }
                    .scrollTargetLayout()
                }
                .scrollTargetBehavior(.paging)
                .backgroundExtensionEffect(isEnabled: true)
                .overlay {
                    ActionNavigationButton(buttonDisplay: "magnifyingglass", infinite: false, alignLeft: false, id: "search", destination: SearchView())
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                        .padding(.horizontal, ButtonT.IconPaddingT.medium)
                }
                
            }
        }
        .task {
            await feedVM.fetchOpportunities();
            await feedVM.loadSavedData()
        }
    }
}

#Preview {
    FeedView(feedVM: FeedVM(oppRepository: OppRepositoryImpl(oppService: OppService())))
}

