import SwiftUI

struct ContentView: View {
    @Environment(\.saveFile) private var save
    
    var body: some View {
        HStack {
            PokemonSelectView()
            BoxMiscView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
