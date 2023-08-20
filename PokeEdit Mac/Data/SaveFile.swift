import SwiftUI
import UniformTypeIdentifiers

struct PokeSav: FileDocument {
    var saveData: Data?
    
    static var readableContentTypes = [UTType.data]
    
    
    init() {
        saveData = nil;
    }
    
    init(configuration: ReadConfiguration) throws {
        saveData = configuration.file.regularFileContents
        print(saveData ?? "Failed to load save")
        
        if saveData != nil {
            initSave()
        } else {
            throw saveError.isNotLoaded
        }
    }
    
    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        if saveData != nil {
            return FileWrapper(regularFileWithContents: saveData!)
        } else { throw saveError.isNotLoaded }
    }
    
    private func initSave() {
        
    }
    
    
    func loadBox(slot: Int) {
        print("loaded box", slot)
    }

}

enum saveError: Error {
    case isNotLoaded
}
