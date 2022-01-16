//
//  NetworkingManager.swift
//  JSONApp
//
//  Created by Дарья Носова on 16.01.2022.
//

import Foundation
import UIKit

class NetworkingManager {
  static var shared = NetworkingManager()
  private init(){}
  
  func fetchPhoto(photosUrl: String, numberOfPhotos: Int, complition: @escaping(_ photo: Photo) -> Void) {
    guard let url = URL(string: photosUrl) else { return }

    for _ in 0..<numberOfPhotos {
      URLSession.shared.dataTask(with: url) { data, response, error in
        guard let data = data else {
          print(error?.localizedDescription ?? "No error description")
          return
        }
        
        do {
          let image = try JSONDecoder().decode(Photo.self, from: data)
          DispatchQueue.main.async {
            complition(image)
          }
        } catch {
          print(error.localizedDescription)
        }
      }.resume()
    }
  }
}
