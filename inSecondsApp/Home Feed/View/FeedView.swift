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
                Image(systemName: "app.background.dotted")
                    .resizable()
                    .scaledToFit()
                
                VStack(alignment: .leading) {
                    HStack {
                        Text(feedVM.opportunity.first?.category ?? "Job")
                            .fontWeight(.light)
                            .fontDesign(.serif)
                            .font(.title2)
                            .padding([.vertical,.trailing])
                            .frame(maxWidth: 200, alignment: .leading)
                        Spacer()
                        ActionNavigationButton(buttonDisplay: "magnifyingglass", infinite: false, alignLeft: false, id: "search", destination: SearchView())
                    }
                    Spacer()
                    HStack {
                        Spacer()
                        VStack(alignment: .trailing) {
                            ActionButton(buttonDisplay: "heart", infinite: false, alignLeft: false) {
                                
                            }
                            ActionButton(buttonDisplay: "arrowshape.turn.up.right", infinite: false, alignLeft: false) {
                                
                            }
                        }
                    }
                    
                    Divider()
                    HStack {
                        VStack(alignment: .leading) {
                            Text(feedVM.opportunity.first?.companyName ?? "Company Name")
                            Text(feedVM.opportunity.first?.status ?? "FundingStatus")
                        }
                        Spacer()
                        Text(feedVM.opportunity.first?.founder ?? "Founde Name")
                    }
                    
                    HStack {
                        Text(feedVM.opportunity.first?.desc ?? "hello there is no description")
                        Spacer()
                        ActionButton(buttonDisplay: "bookmark", infinite: false, alignLeft: false) {
                            
                        }
                    }
                }
                .padding(.horizontal)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                Spacer()
            }
        }
        .task {
            await feedVM.loadSavedData()
        }
    }
}

#Preview {
    FeedView(feedVM: FeedVM(oppRepository: OppRepositoryImpl(oppService: OppService())))
}

