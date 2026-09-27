import SwiftUI

@main struct MyApp: App {
    var body: some Scene {
        WindowGroup {
            FeedView(feedVM: FeedVM(oppRepository: OppRepositoryImpl(oppService: OppService())))
        }
    }
}
