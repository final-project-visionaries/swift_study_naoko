//
//  images.swift
//  API_TEST
//
//  Created by user on 2023/12/18.
//
import SwiftUI
import Alamofire

struct ApiImage: Codable {
    var id:Int
    var image_name: String
    var image_data : String
    var updated_at : String
}
var apiEndPoint = "http://localhost:4242/api/v1/images"
//var apiEndPoint = "https://drawingtraveler-server.onrender.com/api/v1/images"

func apiImageGetRequest(completion: @escaping ([[String: Any]]) -> Void) {
    AF.request(apiEndPoint, method: .get)
        .response { response in
            let decoder = JSONDecoder()
            do {
                let images = try decoder.decode([ApiImage].self, from: response.data!)
                var decodedImages : [[String: Any]] = []

                for image in images {
                    var dictionary: [String: Any] = [:]
                    dictionary["id"] = image.id
                    dictionary["image_name"] = image.image_name
                    dictionary["image_data"] = image.image_data
                    dictionary["updated_at"] = image.updated_at
                    decodedImages.append(dictionary)
                }
                completion(decodedImages)
            } catch {
                print("Error decoding JSON: (error)")
            }
        }
}

//postリクエストの返り値の型定義
struct ResponseMessage: Codable {
    var message:String
}
//postメソッド
func apiImagePostRequest(reqBody : [String: String]){
    // All three of these calls are equivalent
    AF.request(apiEndPoint, method: .post, parameters: reqBody)
        .response{ response in
            let decoder = JSONDecoder()
            do {
                //responseをJSON形式にデコード(返り値がmessage:"新規登録完了")
                let message = try decoder.decode(ResponseMessage.self, from: response.data!)
                var decodedMessage : [String: Any] = [:]
                decodedMessage["message"] = message.message
                print("message : \(decodedMessage["message"]!)")
            } catch {
                print("Error decoding JSON: (error)")
            }
        }
}
//deleteメソッド
func apiImageDeleteRequest(imageID : Int){
    AF.request("\(apiEndPoint)/\(imageID)", method: .delete)
        .response{ response in
            let decoder = JSONDecoder()
            do {
                //responseをJSON形式にデコード(返り値がmessage:"削除完了")
                let message = try decoder.decode(ResponseMessage.self, from: response.data!)
                var decodedMessage : [String: Any] = [:]
                decodedMessage["message"] = message.message
                print("message : \(decodedMessage["message"]!)")
            } catch {
                print("Error decoding JSON: (error)")
            }
        }
}
//updateメソッド
func apiImageUpdateReqest(reqBody : [String : String],imageID : Int){
    AF.request("\(apiEndPoint)/\(imageID)", method: .patch, parameters: reqBody)
        .response{ response in
            let decoder = JSONDecoder()
            do {
                //responseをJSON形式にデコード(返り値がmessage:"修正完了")
                let message = try decoder.decode(ResponseMessage.self, from: response.data!)
                var decodedMessage : [String: Any] = [:]
                decodedMessage["message"] = message.message
                print("message : \(decodedMessage["message"]!)")
            } catch {
                print("Error decoding JSON: (error)")
            }
        }
}
