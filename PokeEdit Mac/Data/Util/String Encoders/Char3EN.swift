import SwiftUI

class Char3EN {

    // Proprietary character encoding in Gen 3, English version
    static let referenceMatrix: [Character] = [
        " ", "À", "Á", "Â", "Ç", "È", "É", "Ê", "Ë", "Ì", "こ", "Î", "Ï", "Ò", "Ó", "Ô",
        "Œ", "Ù", "Ú", "Û", "Ñ", "ß", "à", "á", "ね", "ç", "è", "é", "ê", "ë", "ì", "ま",
        "î", "ï", "ò", "ó", "ô", "œ", "ù", "ú", "û", "ñ", "º", "ª", "ᵉ", "&", "+", "あ",
        "ぃ", "ぅ", "ぇ", "ぉ", "æ", "=", "ょ", "が", "ぎ", "ぐ", "げ", "ご", "ざ", "じ", "ず", "ぜ",
        "ぞ", "だ", "ぢ", "づ", "で", "ど", "ば", "び", "ぶ", "べ", "ぼ", "ぱ", "ぴ", "ぷ", "ぺ", "ぽ",
        "っ", "¿", "¡", "ø", "å", ">", "*", "¤", "#", "<", "Í", "%", "(", ")", "セ", "ソ",
        "タ", "チ", "ツ", "テ",  "ト", "ナ", "ニ", "ヌ", "â", "ノ", "ハ", "ヒ", "フ", "ヘ", "ホ", "í",
        "ミ", "ム", "メ", "モ", "ヤ", "ユ", "ヨ", "ラ", "リ", "⬆", "⬇", "⬅", "➡", "ヲ", "ン", "ァ",
        "ィ", "ゥ", "ェ", "ォ", "ャ", "ュ", "ョ", "ガ", "ギ", "グ", "ゲ", "ゴ", "ザ", "ジ", "ズ", "ゼ",
        "ゾ", "ダ", "ヂ", "ヅ", "デ", "ド", "バ", "ビ", "ブ", "ベ", "ボ", "パ", "ピ", "プ", "ペ", "ポ",
        "ッ", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "!", "?", ".", "-", "・",
        "_", "“", "”", "‘", "’", "♂", "♀", "$", ",", "×", "/", "A", "B", "C", "D", "E",
        "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U",
        "V", "W", "X", "Y", "Z", "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k",
        "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", "▶",
        ":", "Ä", "Ö", "Ü", "ä", "ö", "ü", "⬆", "⬇", "⬅", "➡", "\u{4}", "\u{3}", "\u{2}", "\u{1}", "\0"
    ]
    
    static func decode(stringData: Data) -> String {
        var stringBuilder = ""
        
        for byte in stringData {
            stringBuilder.append(Char3EN.referenceMatrix[Int(byte)])
        }
        
        return stringBuilder
    }
    
    static func encode(stringValue: String, fixedLength: Int) -> Data {
        var stringBuffer = [UInt8](repeating: 0xFF, count: fixedLength)
        var stringIndex = 0
        
        for char in stringValue {
            let byte = UInt8(Char3EN.referenceMatrix.firstIndex(of: char) ?? 0xFF)
            stringBuffer[stringIndex] = byte
            stringIndex += 1
            
            if stringIndex >= fixedLength {
                break;
            }
        }
        
        return Data(stringBuffer)
    }
}
