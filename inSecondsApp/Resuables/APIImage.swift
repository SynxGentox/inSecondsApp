//
//  APIImage.swift
//  CipherTick app
//
//  Created by Aryan Verma on 22/04/26.
//

import SwiftUI

struct APIImage: View {
    let image: String
    let hRatio: Int
    let wRatio: Int
    
    private enum LoadingState {
        case loading
        case loaded(UIImage)
        case failed
    }
    @State private var state: LoadingState = .loading
    
    var body: some View {
        Group {
            switch state {
                case .loading:
                    ProgressView()
                case .failed:
                    Image(systemName: "exclamationmark.triangle")
                        .foregroundStyle(.red)
                case .loaded(let uiImage):
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFit()
            }
        }
        .task(id: image) { await load() }
    }
    
    private func load() async {
        guard let url = URL(string: image) else {
            state = .failed
            return
        }
        // cachePolicy: .returnCacheDataElseLoad
        let request = URLRequest(url: url, timeoutInterval: 10)
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            if let uiImage = UIImage(data: data) {
                state = .loaded(uiImage)
            } else {
                state = .failed
            }
        }
        catch is CancellationError {
            // User Scrolled. Do nothing, view already disappeared.
        }
        catch let error as URLError where error.code == .cancelled {
            // Cancelled from URL in the form of URLError, do nothing same case as cancellation
        }
        catch {
            // Operation failed, No response as Image OR returned any failing error.
            state = .failed
        }
    }
}
