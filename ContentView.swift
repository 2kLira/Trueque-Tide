import SwiftUI

struct ContentView: View {
    
    @StateObject var store = TruequeStore()
    
    var body: some View {
        
        if store.selectedCommunity == nil || store.selectedUser == nil {
            
            SelectionView(store: store)
            
        } else {
            
            DashboardView(store: store)
        }
    }
}
