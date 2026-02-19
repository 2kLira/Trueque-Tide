import SwiftUI

struct ContentView: View {
    
    @StateObject var store = TruequeStore()
    
    @State private var showStory = true
    
    var body: some View {
        
        NavigationStack {
            
            if showStory {
                
                EconomicSimulationView {
                    withAnimation {
                        showStory = false
                    }
                }
                
            } else if store.selectedCommunity == nil ||
                        store.selectedUser == nil {
                
                SelectionView(store: store)
                
            } else {
                
                DashboardView(
                    store: store,
                    community: store.selectedCommunity!,
                    user: store.selectedUser!,
                    reset: {
                        store.selectedCommunity = nil
                        store.selectedUser = nil
                    }
                )
            }
        }
        .animation(.easeInOut(duration: 0.5), value: showStory)
        .animation(.easeInOut(duration: 0.5), value: store.selectedUser != nil)
    }
}
