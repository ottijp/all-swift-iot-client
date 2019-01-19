import UIKit
import Alamofire

class ViewController: UIViewController {

    @IBOutlet weak var ledSwitch: UISwitch!
    @IBOutlet weak var ledIndicator: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()

        loadLedState()
    }
    
    @IBAction func changeLedStatus(_ sender: Any) {
        changeLedStatus()
    }
    
    @IBAction func refreshStatus(_ sender: Any) {
        loadLedState()
    }

    /// 現在のLED状態を取得する
    func loadLedState() {
        self.ledIndicator.startAnimating()
        ledSwitch.isEnabled = false
        APIClient.loadDeviceStatus { result in
            defer {
                self.ledIndicator.stopAnimating()
                self.ledSwitch.isEnabled = true
            }
            
            switch result {
            case let .success(deviceStatus):
                self.ledSwitch.isOn = deviceStatus.led
            case let .failure(error):
                self.showAPIError(error)
            }
        }
    }
    
    /// LED状態を更新する
    func changeLedStatus() {
        self.ledIndicator.startAnimating()
        ledSwitch.isEnabled = false
        let deviceStatus = DeviceStatus(led: self.ledSwitch.isOn)
        APIClient.changedeviceStatus(to: deviceStatus) { result in
            defer {
                self.ledIndicator.stopAnimating()
                self.ledSwitch.isEnabled = true
            }
            
            switch result {
            case let .success(deviceStatus):
                self.ledSwitch.isOn = deviceStatus.led
            case let .failure(error):
                self.showAPIError(error)
            }
        }
    }
    
    /// APIエラーをダイアログ表示する
    func showAPIError(_ error: APIError) {
        let message: String
        switch error {
        case .network:
            message = "Network Error"
        case .invalidResponse:
            message = "Invalid Response"
        case .other:
            message = "Unknown Error"
        }

        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            alert.dismiss(animated: true)
        }
        alert.addAction(okAction)
        show(alert, sender: nil)
    }

}

