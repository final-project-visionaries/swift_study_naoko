//
//  ContentView.swift
//  API_TEST
//
//  Created by user on 2023/12/18.
//

import SwiftUI
import Alamofire
import SwiftyJSON

struct ContentView: View {
    var body: some View {
        VStack {
            Button(action:
                    //                    getRequest
                   temp
            )
            {
                Text("getメソッド")
            }
            
        }
        .padding()
    }
    func getRequest() {
        print("getRequest押されました")
        AF.request("http://localhost:8080", method: .get)
            .response { response in
                do {
                    print("response : \(response)")
                    //                                                    let object = try JSONSerialization.jsonObject(with: response, options: [])  // DataをJsonに変換
                    //                                                    print(object)
                    //                                let articles = try JSONSerialization.jsonObject(with: response.data!, options: []) as? Array<Any>
                    let articles = try JSONSerialization.jsonObject(with: response.data!, options: []) as? Array<Any>
                    print("JSON tryです")
                    var temp = articles
                    print(temp)
                    //                    print(JSON(data: temp[0]))
                } catch {
                    print("catch文です")
                    print(error.localizedDescription)
                }
            }
        //        print("ここは通ってる！！！")
        //            let url = URL(string: "http://localhost:8080")!  //URLを生成
        //            var request = URLRequest(url: url)               //Requestを生成
        //            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in  //非同期で通信を行う
        //                guard let data = data else { return }
        //                do {
        //                    let object = try JSONSerialization.jsonObject(with: data, options: [])  // DataをJsonに変換
        //                    print(object)
        //                } catch let error {
        //                    print(error)
        //                }
        //            }
        //            task.resume()
    }
    struct Article: Codable {
        var image_name: String
        var image_data : String
        init(image_name:String,image_data:String){
            self.image_name = image_name
            self.image_data = image_data
        }
    }
    func temp (){
        AF.request("http://localhost:8080", method: .get)
            .response { response in
                
                let decoder = JSONDecoder()
                do {
                    let articles = try decoder.decode([Article].self, from: response.data!)
                    var array = []
                    var dictionary: [String: String] = [:]
                    for article in articles {
                        dictionary["image_name"] = article.image_name
                        dictionary["image_data"] = article.image_data
                        array.append(dictionary)
                    }
                    print("array : \(array)")
                    print("array[0] : \(array[0])")
                    print("array[1] : \(array[1])")
                    print("array[2] : \(array[2])")
                   
//                    var dictionary: ["image_name":String,"image_data":String] = []
//                    for article in articles{
//                        var eachArticle = Article(image_name: article.image_name, image_data: article.image_data)
//                        dictionary.append(eachArticle)
//                    }
//                    print("dictionary : \(dictionary)")
//                    for elem in dictionary {
//                        print(elem["image_name"])
//                    }
                    // Use the articles here
                } catch {
                    print("Error decoding JSON: (error)")
                }
            }
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
