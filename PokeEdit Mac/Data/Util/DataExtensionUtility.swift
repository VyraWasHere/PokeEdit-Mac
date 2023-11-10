import SwiftUI

extension Data {
    func getUInt32(at offset: Int, isLittleEndian: Bool = true) -> UInt32 {
        if (offset > self.count - 4) {
            print("UInt32 Index out of range, Size:", self.count, "- Offset:", offset)
            return 0
        }
        
        let uint32 = self.withUnsafeBytes({ $0.load(fromByteOffset: offset, as: UInt32.self) })
        return isLittleEndian ? uint32.littleEndian : uint32.bigEndian
    }
    
    func getUInt16(at offset: Int, isLittleEndian: Bool = true) -> UInt16 {
        if (offset > self.count - 2) {
            print("UInt16 Index out of range, Size:", self.count, "- Offset:", offset)
            return 0
        }
        
        let uint16 = self.withUnsafeBytes({ $0.load(fromByteOffset: offset, as: UInt16.self) })
        return isLittleEndian ? uint16.littleEndian : uint16.bigEndian
    }
    
    func getByte(at offset: Int) -> UInt8 {
        if (offset > self.count - 1) {
            print("Byte Index out of range, Size:", self.count, "- Offset:", offset)
            return 0
        }
        
        return self.withUnsafeBytes({ $0.load(fromByteOffset: offset, as: UInt8.self) })
    }
    
    func getString(at offset: Int, length: Int, with decoder: (Data) -> String) -> String {
        if (offset > self.count - length) {
            print("String Index out of range, Size:", self.count, "- Offset + Length:", offset + length)
            return "ErrorString"
        }
        
        let stringData = self.subdata(in: offset..<(offset + length))
        return decoder(stringData)
    }
    
    mutating func setUInt32(_ value: UInt32, at offset: Int, isLittleEndian: Bool = true) {
        if (offset > self.count - 4) {
            print("UInt32 Index out of range, Size:", self.count, "- Offset:", offset)
            return
        }
        
        let valueEndian = isLittleEndian ? value.littleEndian : value.bigEndian
        self.withUnsafeMutableBytes({ $0.storeBytes(of: valueEndian, toByteOffset: offset, as: UInt32.self) })
    }
    
    mutating func setUInt16(_ value: UInt16, at offset: Int, isLittleEndian: Bool = true) {
        if (offset > self.count - 2) {
            print("UInt16 Index out of range, Size:", self.count, "- Offset:", offset)
            return
        }
        
        let valueEndian = isLittleEndian ? value.littleEndian : value.bigEndian
        self.withUnsafeMutableBytes({ $0.storeBytes(of: valueEndian, toByteOffset: offset, as: UInt16.self) })
    }
    
    mutating func setByte(_ value: UInt8, at offset: Int) {
        if (offset > self.count - 1) {
            print("Byte Index out of range, Size:", self.count, "- Offset:", offset)
            return
        }
        
        self.withUnsafeMutableBytes({ $0.storeBytes(of: value, toByteOffset: offset, as: UInt8.self) })
    }
    
    mutating func setString(_ value: String, at offset: Int, length: Int, with encoder: (String, Int) -> Data) {
        if (offset > self.count - length) {
            print("String Index out of range, Size:", self.count, "- Offset + Length:", offset + length)
            return
        }
        
        let stringData = encoder(value, length)
        self.replaceSubrange(offset..<(offset + length), with: stringData)
    }
}


