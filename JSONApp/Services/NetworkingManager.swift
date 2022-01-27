//
//  NetworkingManager.swift
//  JSONApp
//
//  Created by Дарья Носова on 16.01.2022.
//

import Foundation
import Alamofire

class NetworkingManager {
  static var shared = NetworkingManager()
  private init(){}
  
//  func fetchPhoto(photosUrl: String, numberOfPhotos: Int, complition: @escaping(_ photo: Photo) -> Void) {
//    guard let url = URL(string: photosUrl) else { return }
//
//    for _ in 0..<numberOfPhotos {
//      URLSession.shared.dataTask(with: url) { data, response, error in
//        guard let data = data else {
//          print(error?.localizedDescription ?? "No error description")
//          return
//        }
//        
//        do {
//          let image = try JSONDecoder().decode(Photo.self, from: data)
//          DispatchQueue.main.async {
//            complition(image)
//          }
//        } catch {
//          print(error.localizedDescription)
//        }
//      }.resume()
//    }
//  }
  func fetchPhotos(_ url: String, numberOfPhotos: Int, completion: @escaping(Result<Photo, Error>) -> Void) {
  for _ in 0..<numberOfPhotos {
    AF.request(url)
      .validate()
      .responseJSON { dataResponse in
        switch dataResponse.result {
        case .success(let value):
          guard let photo = Photo.getPhoto(from: value) else {
            break
          }
          completion(.success(photo))
        case .failure(let error):
          completion(.failure(error))
        }
      }
    }
  }
  func fetchImage(from url: URL, completion: @escaping(Result<Data, Error>) -> Void) {
    URLSession.shared.dataTask(with: url) { data, _, error in
      
      guard let data = data else {
        print(error?.localizedDescription ?? "No error description")
        return
      }
      DispatchQueue.main.async {
        completion(.success(data))
      }
    }.resume()
  }
}
