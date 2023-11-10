class Sav3FRLG: Sav3 {
    override var securityKey: UInt16 {
        get { return saveSections[.TrainerInfo]?.getUInt16(at: 0xAF8) ?? 0 }
    }
}
