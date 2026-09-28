//
//  FeedDesc.swift
//  inSecondsApp
//
//  Created by Aryan Verma on 28/09/26.
//

import SwiftUI

struct FeedDesc: View {
    @Bindable var feedVM: FeedVM
    let id: String
    let companyName: String?
    let status: String?
    let founder: String?
    let desc: String?
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text(companyName ?? "Co-name...")
                    Text(status ?? "Status...")
                }
                .padding(.vertical, 12)
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Text(founder ?? "Founde name...")
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
            HStack(spacing: 0) {
                Text(desc ?? "hello there is no description")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.vertical)
                
                ActionButton(buttonDisplay: feedVM.saveIDs.contains(id) ? "bookmark.fill" : "bookmark", infinite: false, alignLeft: false) {
                    Task { await feedVM.save(id: id)}
                }
                .padding([.vertical, .leading], 12)
                .frame(alignment: .trailing)
            }
        }
        .padding(.horizontal, ButtonT.IconPaddingT.medium)
        .padding(.bottom, ButtonT.IconPaddingT.medium)
        .background {
            Rectangle()
                .fill(.ultraThinMaterial)
                .overlay(Color.black.opacity(0.35))
                .mask(
                    LinearGradient(
                        colors: [.black, .black.opacity(0)],
                        startPoint: .bottom,
                        endPoint: .top
                    )
                )
                .ignoresSafeArea(edges: .bottom)
        }
    }
}

#Preview {
    FeedDesc(
        feedVM: FeedVM(oppRepository: OppRepositoryImpl(oppService: OppService())),
        id: "",
        companyName: "",
        status: "",
        founder: "",
        desc: ""
    )
}
