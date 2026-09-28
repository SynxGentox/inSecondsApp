//
//  FeedTopDesc.swift
//  inSecondsApp
//
//  Created by Aryan Verma on 28/09/26.
//

import SwiftUI

struct FeedTopDesc: View {
    @Bindable var feedVM: FeedVM
    let category: String?
    
    var body: some View {
        HStack {
            Text(category ?? "Job")
                .fontWeight(.light)
                .fontDesign(.serif)
                .font(.title2)
                .shadow(color: .black.opacity(0.5), radius: 5, x: 0, y: 0)
                .padding([.vertical,.trailing])
                .frame(maxWidth: 200, alignment: .leading)
        }
        .padding(.horizontal, ButtonT.IconPaddingT.medium)
        .padding(.top, 60)
    }
}

#Preview {
    FeedTopDesc(feedVM: FeedVM(oppRepository: OppRepositoryImpl(oppService: OppService())), category: "")
}
