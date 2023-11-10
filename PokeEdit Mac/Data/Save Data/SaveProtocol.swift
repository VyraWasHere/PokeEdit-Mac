protocol SaveProtocol {
    var currentBox: Int { get }
    func getBoxes() -> [BoxData]
}
