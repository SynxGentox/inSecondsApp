//
//  OppDetailView.swift
//  inSecondsApp
//
//  Created by Aryan Verma on 28/09/26.
//

import SwiftUI

struct OppDetailView: View {
    let feedVM: FeedVM
    let id: String
    let image: String
    let companyName: String?
    let category: String?
    let status: String?
    let founder: String?
    let desc: String?
    
    var body: some View {
        ZStack(alignment: .top) {
            VStack {
                APIImage(image: image, hRatio: 16, wRatio: 9)
                    .scaledToFill()
                
                    .frame(maxWidth: .infinity, maxHeight: 200)
                    .clipped()
                    .backgroundExtensionEffect()
                
                VStack {
                    HStack(alignment: .top) {
                        VStack(alignment: .listRowSeparatorLeading) {
                            Text(companyName ?? "Company name")
                                .primaryStyle(fontSize: FontT.title)
                            Text(category ?? "Category")
                                .secondaryStyle(fontSize: FontT.primary)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        VStack {
                            Text("Founder:")
                                .secondaryStyle(fontSize: FontT.primary)
                            Text(founder ?? "MyName")
                                .primaryStyle(fontSize: FontT.primary)
                        }
                    }
                    
                    Text(status ?? "Statue")
                        .padding(.vertical, 4)
                        .frame(maxWidth: .infinity)
                        .background(Color.blue.opacity(0.5))
                        .padding(.vertical, 12)
                        
                    
                    VStack(alignment: .listRowSeparatorLeading) {
                        Text("Description:")
                            .padding(.vertical, 6)
                        Text(desc ?? "No Desc")
                            .primaryStyle(fontSize: FontT.primary)
                    }
                    
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    PrimaryButton(buttonDisplay: feedVM.saveIDs.contains(id) ? "bookmark.fill" : "bookmark", infinite: false, alignLeft: false) {
                        Task { await feedVM.save(id: id)}
                    }
                    .padding([.vertical, .leading], 12)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                }
                .padding(.horizontal, ButtonT.IconPaddingT.medium)
                .padding(.bottom, ButtonT.IconPaddingT.medium)
                .padding(.bottom, ButtonT.IconPaddingT.large)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        }
        
    }
}

#Preview {
    OppDetailView(feedVM: FeedVM(oppRepository: OppRepositoryImpl(oppService: OppService())),id: "",
                  image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRoRN6QSiYXqIUGvrkUU_U_QAPWB0fFiX39YTEI1LrzMRCfA7LZrfAH-UcJ&s=10", companyName: "hello",category: "Engneering", status: "Active", founder: "Someone", desc: "This description makes no sense")
}
