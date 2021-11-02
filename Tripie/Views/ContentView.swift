import SwiftUI


struct ContentView: View {
    @State private var selected = false

    var body: some View {
        ZStack {
            NavigationBar()
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
