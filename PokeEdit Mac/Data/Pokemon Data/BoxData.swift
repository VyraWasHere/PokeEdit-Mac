struct BoxData {
    static var boxSize: Int {
        get { return boxVsize * boxHsize }
    }
    
    static let boxVsize = 5, boxHsize = 6
    
    var name: String, index: Int
    var boxPokemon: [[PokemonDataProtocol?]]
    
    init(name: String, index: Int, boxPokemon: [[PokemonDataProtocol?]]) {
        self.name = name
        self.index = index
        self.boxPokemon = boxPokemon
    }
    
    init() {
        name = "Unnamed Box"
        index = 0
        boxPokemon = [[PokemonDataProtocol?]](repeating:
                    [PokemonDataProtocol?](repeating: nil, count: BoxData.boxHsize),
                                              count: BoxData.boxVsize)
    }
}
