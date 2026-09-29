import SwiftUI

@main struct MyApp: App {
    var body: some Scene {
        WindowGroup {
            ViewController(feedVM: FeedVM(oppRepository: OppRepositoryImpl(oppService: OppService())))
        }
    }
}
