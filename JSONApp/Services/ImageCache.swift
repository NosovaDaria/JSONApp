//
//  ImageCache.swift
//  JSONApp
//
//  Created by Дарья Носова on 27.01.2022.
//

import UIKit

class ImageCache {
  static let shared = NSCache<NSString, UIImage>()
  
  private init() {}
}
