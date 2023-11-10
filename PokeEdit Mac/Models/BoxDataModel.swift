import SwiftUI

class BoxDataModel: ObservableObject {
    @Published var currentBox = 0
    var boxes = [BoxData](repeating: BoxData(), count: 2)
    
}
