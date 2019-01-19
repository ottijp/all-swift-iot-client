# all-swift-iotのクライアントモジュール

[all-swift-iot-server](https://github.com/ottijp/all-swift-iot-server)からデバイス状態を取得したり更新したりするアプリです．

## 環境

* Xcode 10.1
* Swift 4.2
* Cocoapods 1.5.3

## 準備

* 依存ライブラリのインストール

```
$ pod install
```

* Xcodeで`AllSwiftIot.xcworkspace`を開く
* `APIClient.swift`を開き，`API_URL`を[all-swift-iot-server](https://github.com/ottijp/all-swift-iot-server)をデプロイしたURLに変更する

## 実行方法

* ビルドして実行
