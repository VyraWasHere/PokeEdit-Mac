import SwiftUI

struct ContentView: View {
    @Binding var save: PokeSav
    
    var body: some View {
        HStack {
            PokemonSelectView()
            BoxMiscView(save: $save)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(save: .constant(PokeSav()))
    }
}
