//
//  PhotoCollectionViewCell.swift
//  JSONApp
//
//  Created by Дарья Носова on 15.01.2022.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    
  @IBOutlet var photoImageView: UIImageView!
  
  private var imageURL: URL? {
    didSet {
      photoImageView.image = nil
      updateImage()
    }
  }
  
  func configure(with photo: Photo) {
    imageURL = URL(string: photo.message ?? "")
  }
  
  private func updateImage() {
    guard let url = self.imageURL else { return }
    getImage(from: url) { result in
      switch result {
      case .success(let image):
        if url == self.imageURL {
          self.photoImageView.image = image
        }
      case .failure(let error):
        print(error)
      }
    }
  }
  private func getImage(from url: URL, completion: @escaping(Result<UIImage, Error>) -> Void) {
    if let cachedImage = ImageCache.shared.object(forKey: url.lastPathComponent as NSString) {
      print("Image from cache: ", url.lastPathComponent)
      completion(.success(cachedImage))
      return
    }
    NetworkingManager.shared.fetchImage(from: url) { result in
      switch result {
      case .success(let data):
        guard let image = UIImage(data: data) else { return }
        ImageCache.shared.setObject(image, forKey: url.lastPathComponent as NSString)
        print("Image from network: ", url.lastPathComponent)
        completion(.success(image))
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }
}
