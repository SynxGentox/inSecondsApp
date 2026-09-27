//
//  APIImage.swift
//  CipherTick app
//
//  Created by Aryan Verma on 22/04/26.
//

import SwiftUI

struct APIImage: View {
    let image: String

    var body: some View {
        AsyncImage(url: URL(string: image)) { phase in
            if let image = phase.image {
                image
                // TODO: make it reusable and generic by removing the style
                    .resizable()
                    .scaledToFit()
                    .fontWeight(.regular)
                    .padding(ButtonT.IconPaddingT.small)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                
            } else if phase.error != nil {
                VStack {
                    Image(systemName: "exclamationmark.triangle")
                        .foregroundStyle(GetColor.imperialRed)
                }
            }
            else {
                ProgressView()
            }
        }
    }
}
