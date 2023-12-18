//
//  ContentView.swift
//  API_TEST
//
//  Created by user on 2023/12/18.
//

import SwiftUI
import Alamofire


struct ContentView: View {
    @State private var imagesData: [[String: Any]] = [] // 結果を格納するための変数を作成します。
    
    var body: some View {
        VStack {
            Button(action:{
                print("ボタン押しました")
                //getRequestが非同期処理だから、その処理が終わった後に実行するコールバック{}.thenのイメージ
                getRequest { decodedImages in
                    self.imagesData = decodedImages
                    print(self.imagesData[0])
                    print(self.imagesData[1])
                    print(self.imagesData[2])
                }
            }
            )
            {
                Text("getメソッド")
            }
            Button(action: postReqest){
                Text("postメソッド")
            }
        }
        .padding()
    }
    
    func postReqest(){
        let parameters: [String: [String]] = [
            "foo": ["bar"],
            "baz": ["a", "b"],
            "qux": ["x", "y", "z"]
        ]

        // All three of these calls are equivalent
        AF.request("http://localhost:4242/api/v1/images", method: .post, parameters: parameters)
    }

}
//let parameters: [String: [String]] = [
//    "foo": ["bar"],
//    "baz": ["a", "b"],
//    "qux": ["x", "y", "z"]
//]
//
//// All three of these calls are equivalent
//AF.request("https://httpbin.org/post", method: .post, parameters: parameters)
//AF.request("https://httpbin.org/post", method: .post, parameters: parameters, encoder: URLEncodedFormParameterEncoder.default)
//AF.request("https://httpbin.org/post", method: .post, parameters: parameters, encoder: URLEncodedFormParameterEncoder(destination: .httpBody))
//
//// HTTP body: "qux[]=x&qux[]=y&qux[]=z&baz[]=a&baz[]=b&foo[]=bar"

#Preview {
    ContentView()
}
