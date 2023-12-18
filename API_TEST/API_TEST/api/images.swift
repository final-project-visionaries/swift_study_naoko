//
//  images.swift
//  API_TEST
//
//  Created by user on 2023/12/18.
//
import SwiftUI
import Alamofire

struct Image: Codable {
    var id:Int
    var image_name: String
    var image_data : String
    var updated_at : String
}

func getRequest(completion: @escaping ([[String: Any]]) -> Void) {
//    AF.request("http://localhost:4242/api/v1/images", method: .get)
    AF.request("https://drawingtraveler-server.onrender.com/api/v1/images", method: .get)
        .response { response in
            let decoder = JSONDecoder()
            do {
                let images = try decoder.decode([Image].self, from: response.data!)
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
