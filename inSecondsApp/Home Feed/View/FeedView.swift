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
                ScrollView {
                    LazyVStack {
                        let _ = print("Loading URL:",  feedVM.opportunity.first?.imageURL ?? "some", "→ valid:", URL(string:  feedVM.opportunity.first?.imageURL ?? "invalid") != nil)
                        APIImage(image: feedVM.opportunity.first?.imageURL ?? "bell")
                    }
                    .card(color: .blue, radius: 20)
                    
                }
                .backgroundExtensionEffect(isEnabled: true)
                
                VStack(alignment: .leading, spacing: 0) {
                    HStack {
                        Text(feedVM.opportunity.first?.category ?? "Job")
                            .fontWeight(.light)
                            .fontDesign(.serif)
                            .font(.title2)
                            .padding([.vertical,.trailing])
                            .frame(maxWidth: 200, alignment: .leading)
                        ActionNavigationButton(buttonDisplay: "magnifyingglass", infinite: false, alignLeft: false, id: "search", destination: SearchView())
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                    GetColor.clear
                        .frame(maxWidth: .infinity, alignment: .bottom)
                    
                    
                    HStack {
                        VStack(alignment: .trailing) {
                            ActionButton(buttonDisplay: "heart", infinite: false, alignLeft: false) {
                                
                            }
                            .padding(.vertical, ButtonT.IconPaddingT.small)
                            ActionButton(buttonDisplay: "arrowshape.turn.up.right", infinite: false, alignLeft: false) {
                                
                            }
                        }
                        .padding(.bottom, ButtonT.IconPaddingT.small)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                    
                    Divider()
                    
                    HStack {
                        VStack(alignment: .leading) {
                            Text(feedVM.opportunity.first?.companyName ?? "Company Name")
                            Text(feedVM.opportunity.first?.status ?? "FundingStatus")
                        }
                        .padding(.vertical, 12)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Text(feedVM.opportunity.first?.founder ?? "Founde Name")
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                    .background(.red)
                    HStack(spacing: 0) {
                        Text(feedVM.opportunity.first?.desc ?? "hello there is no description")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.vertical)
                            
                        ActionButton(buttonDisplay: "bookmark", infinite: false, alignLeft: false) {
                            
                        }
                        .padding(12)
                        .frame(alignment: .trailing)
                    }
                }
                .padding(.horizontal, ButtonT.IconPaddingT.small)
                .frame(maxWidth: .infinity, maxHeight: .infinity)            }
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

