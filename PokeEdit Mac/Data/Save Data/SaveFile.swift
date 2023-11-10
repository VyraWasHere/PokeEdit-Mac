import SwiftUI
import UniformTypeIdentifiers

struct SaveFile: FileDocument {
    
    static var readableContentTypes = [UTType.data]
    @ObservedObject var boxModel = BoxDataModel()
    
    private(set) var saveData: Data?
    private(set) var sav: SaveProtocol?
    
    init() {
        saveData = nil
    }
    
    init(configuration: ReadConfiguration) throws {
        saveData = configuration.file.regularFileContents
        
        if saveData == nil {
            print("Failed to load save")
            throw SaveError.isNotLoaded
        }
        
        // TODO: Determine which save format to use, for now use Sav3 as default
        sav = Sav3(with: self)
        
        loadBoxes()
    }
    
    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        if saveData != nil {
            return FileWrapper(regularFileWithContents: saveData!)
        } else { throw SaveError.isNotLoaded }
    }

    private func loadBoxes() {
        boxModel.currentBox = sav!.currentBox
        boxModel.boxes = sav!.getBoxes()
    }
}

enum SaveError: Error {
    case isNotLoaded
}

extension EnvironmentValues {
    var saveFile: SaveFile {
        get { self[SaveFileKey.self] }
        set { self[SaveFileKey.self] = newValue }
    }
}


private struct SaveFileKey: EnvironmentKey {
    static var defaultValue: SaveFile = SaveFile()
}
