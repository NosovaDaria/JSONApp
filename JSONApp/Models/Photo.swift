//
//  Photo.swift
//  JSONApp
//
//  Created by Дарья Носова on 15.01.2022.
//

import Foundation

struct Photo: Decodable {
  let message: String?
  
  init(photosData: [String: Any]) {
    message = photosData["message"] as? String
  }
  
  static func getPhoto(from value: Any) -> Photo? {
    guard let photosData = value as? [String: Any] else { return nil }
    
//    var photos = Photo(photosData: photosData)
//
    let photo = Photo(photosData: photosData)
//    photos = photo
    
    return photo
  }
}
