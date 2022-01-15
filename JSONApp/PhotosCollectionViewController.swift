//
//  PhotosCollectionViewController.swift
//  JSONApp
//
//  Created by Дарья Носова on 15.01.2022.
//

import UIKit

class PhotosCollectionViewController: UICollectionViewController {
  
  @IBOutlet var activityIndicator: UIActivityIndicatorView!
  
  let itemsPerRow: CGFloat = 2
  let sectionInserts = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
  private var photos: [Photo] = []
  private let numberOfPhotos = 20

  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    activityIndicator.startAnimating()
    activityIndicator.hidesWhenStopped = true
    fetchPhoto()
  }
  
  override func numberOfSections(in collectionView: UICollectionView) -> Int {
    2
  }
  
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    if photos.count == numberOfPhotos {
      activityIndicator.stopAnimating()
      return numberOfPhotos
    }
    return 0
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as! PhotoCollectionViewCell
    
    if photos.count > indexPath.item {
      let photo = photos[indexPath.item]
      cell.configure(with: photo)
    }
    
    return cell
  }
}
  
//  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//    <#code#>
//  }

  extension PhotosCollectionViewController {
    func fetchPhoto() {
      guard let url = URL(string: "https://dog.ceo/api/breeds/image/random") else { return }

      for _ in 0..<numberOfPhotos {
        URLSession.shared.dataTask(with: url) { data, response, error in
          guard let data = data, let response = response else {
            print(error?.localizedDescription ?? "No error description")
            return
          }
          print(response)
          
          do {
            self.photos.append(try JSONDecoder().decode(Photo.self, from: data))
            DispatchQueue.main.async {
              self.collectionView.reloadData()
            }
          } catch {
            print(error.localizedDescription)
          }
        }.resume()
      }
    }
    
    
  }


extension PhotosCollectionViewController: UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let paddingWith = sectionInserts.left * (itemsPerRow + 1)
    let availableWidth = collectionView.frame.width - paddingWith
    let widthPerItem = availableWidth / itemsPerRow
    return CGSize(width: widthPerItem, height: widthPerItem)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return sectionInserts
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    sectionInserts.left
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    sectionInserts.left
  }
}
