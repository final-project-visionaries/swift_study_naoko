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
                apiImageGetRequest { decodedImages in
                    self.imagesData = decodedImages
                    print(self.imagesData[0]["image_data"]!)
                    print(self.imagesData[1])
                    print(self.imagesData[2])
                    
                }
            }
            )
            {
                Text("getメソッド")
            }
            //actionのvalueは関数でなければならない
            //引数を渡したい場合は、{}で括って、クロージャーの中で呼び出す
            Button(action: { () -> () in
                //postで渡す辞書型のデータを作る仮の関数（本番はフロントで作成）
                let tempData = getTempData()
                //postリクエストを引数を渡して実行
                apiImagePostRequest(reqBody: tempData)
            })
            {
                Text("postメソッド")
            }
            Button(action: { () -> () in
                apiImageDeleteRequest(imageID: 36)
            })
            {
                Text("deleteメソッド")
            }
            Button(action: { () -> () in
                let tempData = getTempData2()
                apiImageUpdateReqest(reqBody: tempData, imageID: 29)
            })
            {
                Text("updateメソッド")
            }
        }
        .padding()
    }
    
    //postで渡す辞書型のデータを作る仮の関数
    func getTempData() -> [String: String]{
        let parameters: [String: String] = [
            "image_name": "sad2",
            "image_data": "data:image/png;base64,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",
        ]
        return parameters
    }
    
    func getTempData2 () -> [String : String]{
        let temp = [
            "image_name" : "sadsadsadsad",
            "image_data" : "4QLbHMNtEa2+44YYbbrjhhhtuuOFZ8P/knqV3FzgJqgAAAABJRU5ErkJggg"
        ]
        return temp
    }
}

#Preview {
    ContentView()
}
