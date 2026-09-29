//
//  FeedView.swift
//  inSecondsApp
//
//  Created by Aryan Verma on 28/09/26.
//

import SwiftUI

struct FeedView: View {
    let feedVM: FeedVM

    var body: some View {
        ZStack {
            ScrollView(showsIndicators: false) {
                LazyVStack(spacing: 0) {
                    ForEach(feedVM.opportunity) { opp in
                        ZStack {
                            NavigationLink(value: opp) {
                                APIImage(image: opp.imageURL, hRatio: 16, wRatio: 9)
                            }
                            .buttonStyle(.plain)

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
            .refreshable {
                try? await Task.sleep(for: .milliseconds(500))
                await feedVM.fetchOpportunities()
            }
            .overlay {
                ActionNavigationButton(buttonDisplay: "magnifyingglass", infinite: false,
                                       alignLeft: false, id: "search",
                                       destination: SearchView(feedVM: feedVM))
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                    .padding(.horizontal, ButtonT.IconPaddingT.medium)
                    .padding(.top, 60)
            }
            .ignoresSafeArea()
        }
    }
}
#Preview {
    FeedView(feedVM: FeedVM(oppRepository: OppRepositoryImpl(oppService: OppService())))
}

