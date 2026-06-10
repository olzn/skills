import SwiftUI
import Intents
struct ContentView: View {
    var body: some View {
        VStack {
            Text("Hi").font(.system(size: 14)).foregroundColor(.gray)
            Button("Go") {}.glassEffect()
            Button("Stop") {}.glassEffect()
        }
        .frame(minWidth: 20, minHeight: 20)
        .background(Color.white)
    }
}
// SKStoreReviewController.requestReview()
