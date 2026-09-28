//
//  FeedControls.swift
//  inSecondsApp
//
//  Created by Aryan Verma on 28/09/26.
//

import SwiftUI

struct FeedControls: View {
    @Bindable var feedVM: FeedVM
    let id: String
    
    var body: some View {
        HStack {
            VStack(alignment: .trailing, spacing: 12) {
                ActionButton(buttonDisplay: feedVM.saveLikes.contains(id) ? "heart.fill" : "heart", infinite: false, alignLeft: false) {
                    Task { await feedVM.like(id: id)}
                }
                ActionButton(buttonDisplay: "arrowshape.turn.up.right", infinite: false, alignLeft: false) {
                    
                }
            }
            .padding(.vertical, ButtonT.IconPaddingT.small)
            .frame(maxWidth: .infinity, alignment: .trailing)
        }
        .padding(.horizontal, ButtonT.IconPaddingT.small)
    }
}

#Preview {
    FeedControls(feedVM: FeedVM(oppRepository: OppRepositoryImpl(oppService: OppService())), id: "id_001")
}
