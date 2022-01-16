//
//  PhotoCollectionViewCell.swift
//  JSONApp
//
//  Created by Дарья Носова on 15.01.2022.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    
  @IBOutlet var photoImageView: UIImageView!
  
  func configure(with photo: Photo) {
    
    DispatchQueue.global().async {
      guard let url = URL(string: photo.message) else { return }
      guard let imageData = try? Data(contentsOf: url) else { return }
      
      DispatchQueue.main.async {
        self.photoImageView.image = UIImage(data: imageData)
      }
    }
  }
}
