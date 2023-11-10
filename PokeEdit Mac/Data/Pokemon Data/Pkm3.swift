import SwiftUI

class Pkm3: PokemonDataProtocol {
    var species: Pokemon {
        get {
            switch Int(substructures[.Growth]?.getUInt16(at: 0) ?? 9999) {
            case let n where n <= 251:
                return Pokemon.allCases[n - 1]
            case let n where n >= 277 && n <= 300:
                return Pokemon.allCases[n - 26]
            default:
                return .Abra
                    //return speciesLookup[byIndex]!
            }
        }
    }
    var isEmpty: Bool {
        get {
            return personalityValue == 0 && originalTrainerID == 0
        }
    }
    
    
    static let pokemonDataSize = 80
    static private let decisionMatrix: [[Substructure]] =
    [
        [ .Growth, .Attacks, .EVs, .Misc ], // 0
        [ .Growth, .Attacks, .Misc, .EVs ],
        [ .Growth, .EVs, .Attacks, .Misc ],
        [ .Growth, .EVs, .Misc, .Attacks ],
        [ .Growth, .Misc, .Attacks, .EVs ], // 4
        [ .Growth, .Misc, .EVs, .Attacks ],
        [ .Attacks, .Growth, .EVs, .Misc ],
        [ .Attacks, .Growth, .Misc, .EVs ],
        [ .Attacks, .EVs, .Growth, .Misc ], // 8
        [ .Attacks, .EVs, .Misc, .Growth ],
        [ .Attacks, .Misc, .Growth, .EVs ],
        [ .Attacks, .Misc, .EVs, .Growth ],
        [ .EVs, .Growth, .Attacks, .Misc ], // 12
        [ .EVs, .Growth, .Misc, .Attacks ],
        [ .EVs, .Attacks, .Growth, .Misc ],
        [ .EVs, .Attacks, .Misc, .Growth ],
        [ .EVs, .Misc, .Growth, .Attacks ], // 16
        [ .EVs, .Misc, .Attacks, .Growth ],
        [ .Misc, .Growth, .Attacks, .EVs ],
        [ .Misc, .Growth, .EVs, .Attacks ],
        [ .Misc, .Attacks, .Growth, .EVs ], // 20
        [ .Misc, .Attacks, .EVs, .Growth ],
        [ .Misc, .EVs, .Growth, .Attacks ],
        [ .Misc, .EVs, .Attacks, .Growth ]  // 23
    ]
    
    var personalityValue: UInt32, originalTrainerID: UInt32
    private var substructures: [Substructure: Data] = [:]
    private var substructOrder: Int
    private(set) var speciesLookup: [UInt16: Pokemon] = [:]
    private(set) var isEncrypted = true
    
    init(pokemonData: Data) {
        personalityValue = pokemonData.getUInt32(at: 0)
        originalTrainerID = pokemonData.getUInt32(at: 4)
        substructOrder = Int(personalityValue % 24)
        
        var substructData = pokemonData.subdata(in: 32..<80)
        toggleEncryption(of: &substructData)
        
        var substructIndex = 0; let substructSize = 12
        for substruct in Pkm3.decisionMatrix[substructOrder] {
            let bounds = (substructIndex * substructSize)..<(substructSize * (substructIndex + 1))
            substructures[substruct] = substructData.subdata(in: bounds)
            substructIndex += 1
        }
    }
    
    private func toggleEncryption(of subdata: inout Data) {
        let key = originalTrainerID ^ personalityValue
        isEncrypted = !isEncrypted

        for uint32size in stride(from: 0, to: subdata.count, by: 4) {
            var value = subdata.getUInt32(at: uint32size)
            value ^= key
            subdata.setUInt32(value, at: uint32size)
        }
    }
}

enum Substructure {
    case Growth, Attacks, EVs, Misc
}

extension Pkm3 {
    private func generateLookupTable() {
        speciesLookup[301] = .Nincada
        speciesLookup[302] = .Ninjask
        speciesLookup[303] = .Shedinja
        speciesLookup[304] = .Taillow
        speciesLookup[305] = .Swellow
        speciesLookup[306] = .Ninjask
        speciesLookup[307] = .Breloom
        
        // TODO: Surely there has to be a better way to do this
    }
}
