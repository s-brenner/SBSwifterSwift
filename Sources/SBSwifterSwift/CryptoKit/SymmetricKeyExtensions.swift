import struct CryptoKit.SymmetricKey

public extension SymmetricKey {
    
    var data: Data { withUnsafeBytes { Data(Array($0)) } }
}
