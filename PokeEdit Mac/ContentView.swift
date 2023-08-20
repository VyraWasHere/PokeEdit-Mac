import SwiftUI

struct ContentView: View {
    @Binding var save: PokeSav
    @State private var boxData = [PokemonData?](repeating: nil, count: 5 * 6)
    @State private var species: Pokemon = .Aron
    @State private var nickname: String = ""
    @State private var currentBox: Int = 1
    
    var body: some View {
        HStack {
            TabView(selection: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Selection@*/.constant(1)/*@END_MENU_TOKEN@*/) {
                GroupBox(label: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Label@*/Text("")/*@END_MENU_TOKEN@*/) {
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
                }.padding(.horizontal, 5.0)
                .tabItem { Text("Main") }.tag(1)
                 
                Text("Tab Content 2").tabItem { Text("Met") }.tag(2)
            }
            .padding(.top, 2.0)
            
            
            TabView(selection: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Selection@*/.constant(1)/*@END_MENU_TOKEN@*/) {
                GroupBox(label: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Label@*/Text("")/*@END_MENU_TOKEN@*/) {
                    Stepper(value: $currentBox, in: 1...14) {
                        Text("Box \(currentBox)")
                    }.onChange(of: currentBox, perform: save.loadBox)
                    
                    GroupBox(label: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Label@*/Text("")/*@END_MENU_TOKEN@*/) {
                        VStack {
                            ForEach(0..<5, id: \.self) { v in
                                HStack {
                                    ForEach(0..<6, id: \.self) { h in
                                        if boxData[v * h + h] != nil {
                                            Image(decorative: boxData[0]!.sprite, scale: 1.0)
                                        } else {
                                            RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Corner Radius@*/10.0/*@END_MENU_TOKEN@*/)
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                .tabItem { Text("Box") }.tag(1)
                 
                GroupBox(label: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Label@*/Text("")/*@END_MENU_TOKEN@*/) {
                    
                }.tabItem { Text("SAV") }.tag(2)
            }
            .padding(.top, 2.0)
        }
        .padding(.vertical, 1.0)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(save: .constant(PokeSav()))
    }
}
