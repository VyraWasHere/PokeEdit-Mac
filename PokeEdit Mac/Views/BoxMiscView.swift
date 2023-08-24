import SwiftUI

struct BoxMiscView: View {
    @Binding var save: PokeSav
    
    var body: some View {
        TabView(selection: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Selection@*/.constant(1)/*@END_MENU_TOKEN@*/) {
            GroupBox(label: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Label@*/Text("")/*@END_MENU_TOKEN@*/) {
                BoxDataView(save: $save)
            }
            .tabItem { Text("Box") }.tag(1)
             
            GroupBox(label: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Label@*/Text("")/*@END_MENU_TOKEN@*/) {
                
            }.tabItem { Text("SAV") }.tag(2)
        }
        .padding(.top, 2.0)
    }
}

struct BoxMiscView_Previews: PreviewProvider {
    static var previews: some View {
        BoxMiscView(save: .constant(PokeSav()))
    }
}

struct BoxDataView : View {
    @Binding var save: PokeSav
    
    static private let verticalSize = 5, horizontalSize = 6
    @State private var boxData = [[PokemonData?]](repeating:
        [PokemonData?](repeating: nil, count: horizontalSize),
    count: verticalSize)
    @State private var currentBox: Int = 1
    
    var body: some View {
        Stepper(value: $currentBox, in: 1...14) {
            Text("Box \(currentBox)")
        }.onChange(of: currentBox, perform: save.loadBox)
        
        
        GroupBox(label: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Label@*/Text("")/*@END_MENU_TOKEN@*/) {
            VStack {
                ForEach(0..<BoxDataView.verticalSize, id: \.self) { v in
                    HStack {
                        ForEach(0..<BoxDataView.horizontalSize, id: \.self) { h in
                            if boxData[v][h] != nil {
                                Image(decorative: boxData[v][h]!.sprite, scale: 1.0)
                            } else {
                                RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Corner Radius@*/10.0/*@END_MENU_TOKEN@*/)
                            }
                        }
                    }
                }
            }
        }
    }
}

struct BoxDataView_Previews: PreviewProvider {
    static var previews: some View {
        BoxDataView(save: .constant(PokeSav()))
    }
}
