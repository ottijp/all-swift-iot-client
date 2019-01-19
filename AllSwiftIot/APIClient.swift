import Foundation
import Alamofire

// このURLはデプロイ先のものに変えてください
fileprivate let API_URL = "https://hoge.herokuapp.com/deviceStatus/1"

class APIClient {

    /// APIから現在のデバイス状態を取得する
    static func loadDeviceStatus(completion: @escaping (Result<DeviceStatus, APIError>) -> Void) {
        Alamofire.request(API_URL).response { response in
            guard response.error == nil else {
                print("http request error", response.error!.localizedDescription)
                completion(.failure(.network))
                return
            }
            
            guard let data = response.data else {
                print("no data found in response")
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let deviceData = try? JSONDecoder().decode(DeviceStatus.self, from: data) else {
                print("invalid response", data)
                completion(.failure(.invalidResponse))
                return
            }
            
            completion(.success(deviceData))
        }
    }

    /// APIかへデバイス状態の更新をリクエストする
    /// ref) https://stackoverflow.com/questions/47685241/using-alamofire-and-codable-for-put-request
    static func changedeviceStatus(to deviceStatus: DeviceStatus, completion: @escaping (Result<DeviceStatus, APIError>) -> Void) {
        let jsonData = try! JSONEncoder().encode(deviceStatus)
        var request = URLRequest(url: URL(string: API_URL)!)
        request.httpMethod = HTTPMethod.put.rawValue
        request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        Alamofire.request(request).response { response in
            guard response.error == nil else {
                print("http request error", response.error!.localizedDescription)
                completion(.failure(.network))
                return
            }
            
            guard let data = response.data else {
                print("no data found in response")
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let deviceData = try? JSONDecoder().decode(DeviceStatus.self, from: data) else {
                print("invalid response", data)
                completion(.failure(.invalidResponse))
                return
            }

            completion(.success(deviceData))
        }
    }
}
