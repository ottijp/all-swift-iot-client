/// デバイス状態
final class DeviceStatus: Decodable, Encodable {
    var id: Int?
    var led: Bool
    init(id: Int? = nil, led: Bool) {
        self.id = id
        self.led = led
    }
}
