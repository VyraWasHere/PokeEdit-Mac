import SwiftUI

struct BoxMiscView: View {
    
    var body: some View {
        TabView(selection: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Selection@*/.constant(1)/*@END_MENU_TOKEN@*/) {
            GroupBox(label: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Label@*/Text("")/*@END_MENU_TOKEN@*/) {
                BoxDataView()
            }
            .tabItem { Text("Box") }.tag(1)
             
            GroupBox(label: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Label@*/Text("")/*@END_MENU_TOKEN@*/) {
                
            }.tabItem { Text("SAV") }.tag(2)
        }
        .padding(.bottom, 2.0)
    }
}

struct BoxMiscView_Previews: PreviewProvider {
    static var previews: some View {
        BoxMiscView()
    }
}

struct BoxDataView : View {
    @Environment(\.saveFile) private var save
    
    static private let verticalSize = 5, horizontalSize = 6
    @State var currentBox = 1
    
    var body: some View {
        
        HStack {
            Picker("", selection: $currentBox) {
                ForEach(save.boxModel.boxes, id: \.index) { box in
                    Text(box.name).tag(box.index + 1)
                }
            }
            Stepper(value: $currentBox, in: 1...(save.boxModel.boxes.count)) {
            }.onAppear() {
                currentBox = save.boxModel.currentBox + 1
            }
        }
        
        
        GroupBox(label: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Label@*/Text("")/*@END_MENU_TOKEN@*/) {
            VStack {
                ForEach(0..<BoxDataView.verticalSize, id: \.self) { v in
                    HStack {
                        ForEach(0..<BoxDataView.horizontalSize, id: \.self) { h in
                            let currentPokemon = save.boxModel.boxes[currentBox - 1].boxPokemon[v][h]
                            if currentPokemon != nil {
                                let spriteCode = Pokemon.allCases.firstIndex(of: currentPokemon!.species)! + 1
                                Image("b_\(spriteCode)")
                                    .aspectRatio(CGSize(width: 1.5, height: 1.5), contentMode: .fill)
                                .contextMenu {
                                    Button("View") {
                                        print("box", currentBox, "vert", v, "hori", h, save.boxModel.boxes[currentBox - 1].boxPokemon[v][h]!.species.rawValue)
                                    }
                                }
                            } else {
                                Image("b_unknown")
                                .aspectRatio(CGSize(width: 1.5, height: 1.5), contentMode: .fill)
                                .contextMenu {
                                    Button("Set") {
                                        print(save.saveData ?? "")
                                    }
                                }
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
        BoxDataView()
    }
}
