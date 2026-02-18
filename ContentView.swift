import SwiftUI

struct ContentView: View {
    
    @StateObject var store = TruequeStore()
    
    var body: some View {
        EconomicSimulationView()
    }

}
