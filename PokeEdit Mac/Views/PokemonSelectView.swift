import SwiftUI

struct PokemonSelectView : View {
    
    var body: some View {
        TabView(selection: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Selection@*/.constant(1)/*@END_MENU_TOKEN@*/) {
            GroupBox(label: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Label@*/Text("")/*@END_MENU_TOKEN@*/) {
                PokemonSelectMainView()
            }.padding(.horizontal, 5.0)
            .tabItem { Text("Main") }.tag(1)
             
            GroupBox() {
                PokemonSelectMetView()
            }.tabItem { Text("Met") }.tag(2)
        }
    }
}

struct PokemonSelectView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonSelectView()
    }
}

struct PokemonSelectMainView : View {
    @State private var nickname: String = ""
    @State private var species: Pokemon = .Aron
    
    var body: some View {
        HStack {
            Text("Nickname:")
            TextField(
                "",
                text: $nickname
            )
            .disableAutocorrection(true)
            .border(.secondary)
        }
        
        Picker(selection: $species, label: Text("Species:")) {
            ForEach(Pokemon.allCases) { pkm in
                Text(pkm.rawValue).tag(pkm)
            }
        }
    }
}

struct PokemonSelectMainView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonSelectMainView()
    }
}

struct PokemonSelectMetView : View {
    @State var metAtLv: Int = 0

    var body: some View {
        HStack {
            Text("Met Lv.")
            TextField("", value: $metAtLv, format: .number)
        }
    }
}

struct PokemonSelectMetView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonSelectMetView()
    }
}
