import SwiftUI

class Sav3: SaveProtocol {
    static private let gameSlotSize = 0xE000;
    static private let sections = 14, sectionSize = 4096;
    static private let maxBoxes = 14
    
    private(set) var gameSlots: [SlotTag: (data: Data, saveIndex: UInt16)] = [:]
    private(set) var mostRecentSaveSlot: SlotTag = .SlotB
    private(set) var saveSections: [SectionName: Data] = [:]
    
    var securityKey: UInt16 { get { return 0 } }
    var currentBox: Int {
        get {
            Int(saveSections[.PC]?.getUInt32(at: 0) ?? 0)
        }
    }
    
    
    init(with file: SaveFile) {
        var bounds = 0..<Sav3.gameSlotSize
        var slotData = file.saveData!.subdata(in: bounds)
        gameSlots[.SlotA] = (data: slotData, saveIndex: slotData.getUInt16(at: 0x0FFC))
        
        bounds = Sav3.gameSlotSize..<(Sav3.gameSlotSize * 2)
        slotData = file.saveData!.subdata(in: bounds)
        gameSlots[.SlotB] = (data: slotData, saveIndex: slotData.getUInt16(at: 0x0FFC))
        
        mostRecentSaveSlot = gameSlots[.SlotA]!.saveIndex > gameSlots[.SlotB]!.saveIndex ? .SlotA : .SlotB
        
        // PC Buffer uses 9 sections (5...13) as one
        var pcBuffer = [Data](repeating: Data(), count: 9)
        
        for sectionIndex in 0..<Sav3.sections {
            let bounds = (Sav3.sectionSize * sectionIndex)..<(Sav3.sectionSize * (sectionIndex + 1))
            let sectionData = gameSlots[mostRecentSaveSlot]!.data.subdata(in: bounds)
            let sectionID = sectionData.getUInt16(at: 0xFF4)
            
            if sectionID >= 5 {
                pcBuffer[Int(sectionID) - 5] = sectionData.subdata(in: 0..<3968) // Trim off section metadata
            } else {
                saveSections[SectionName(rawValue: sectionID) ?? .Error] = sectionData
            }
        }
        
        saveSections[.PC] = Data(pcBuffer.joined())
        
        if saveSections[.Error] != nil {
            print("An error occurred in getting the correct Section IDs")
        }
    }
    
    func getBoxes() -> [BoxData] {
        var boxes: [BoxData] = []
        let boxData = saveSections[.PC]!.subdata(in: 0x4..<0x8344)
        let boxNameData = saveSections[.PC]!.subdata(in: 0x8344..<0x83C2)
        
        for boxNumber in 0..<Sav3.maxBoxes {
            var boxPokemon: [[Pkm3?]] = [[Pkm3?]](repeating: [Pkm3?](), count: BoxData.boxVsize)
            var verticalIndex = -1
            
            for pokemonNumber in 0..<BoxData.boxSize {
                let lowerBound = (boxNumber * Pkm3.pokemonDataSize * BoxData.boxSize) +
                                (pokemonNumber * Pkm3.pokemonDataSize)
                let upperBound = lowerBound + Pkm3.pokemonDataSize
                let pokemonData = boxData.subdata(in: lowerBound..<upperBound)
                let pokemon = Pkm3(pokemonData: pokemonData)
                
                if pokemonNumber % BoxData.boxHsize == 0 {
                    verticalIndex += 1
                }
                
                if pokemon.isEmpty {
                    boxPokemon[verticalIndex].append(nil)
                } else {
                    boxPokemon[verticalIndex].append(pokemon)
                }
            }
            
            let boxName = boxNameData.getString(at: 9 * boxNumber, length: 8, with: Char3EN.decode)
            boxes.append(BoxData(name: boxName, index: boxNumber, boxPokemon: boxPokemon))
        }
        
        return boxes
    }
}

enum SlotTag {
    case SlotA, SlotB
}

enum SectionName: UInt16 {
    case TrainerInfo = 0, TeamItems, GameState, MiscData, RivalInfo, PC, Error
}
