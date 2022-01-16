//
//  PhotosCollectionViewController.swift
//  JSONApp
//
//  Created by Дарья Носова on 15.01.2022.
//

import UIKit

class PhotosCollectionViewController: UICollectionViewController {
  
  // MARK: -  IB Outlets
  @IBOutlet var activityIndicator: UIActivityIndicatorView!
  
  // MARK: - Public Properties
  let itemsPerRow: CGFloat = 2
  let sectionInserts = UIEdgeInsets(top: 20 , left: 20, bottom: 20, right: 20)
  
  // MARK: - Private Properties
  private let photosUrl = "https://dog.ceo/api/breeds/image/random"
  private var photos: [Photo] = []
  private let numberOfPhotos = 30

  // MARK: - Override Methods
  override func viewDidLoad() {
    super.viewDidLoad()
    
    activityIndicator.startAnimating()
    activityIndicator.hidesWhenStopped = true
    
    NetworkingManager.shared.fetchPhoto(photosUrl: photosUrl, numberOfPhotos: numberOfPhotos) { photo in
      self.photos.append(photo)
      self.collectionView.reloadData()
    }
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "openPhotoSegue" {
      let photoVC = segue.destination as! PhotoViewController
      let cell = sender as! PhotoCollectionViewCell
      photoVC.image = cell.photoImageView.image
    }
  }
  
  override func numberOfSections(in collectionView: UICollectionView) -> Int {
    2
  }
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    if photos.count == numberOfPhotos {
      
      return numberOfPhotos
    }
    
    return 0
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as! PhotoCollectionViewCell
    
    if photos.count > indexPath.item {
      let photo = photos[indexPath.item]
      cell.configure(with: photo)
      self.activityIndicator.stopAnimating()
    }
    
    return cell
  }
}

  // MARK: - Private Methods
extension PhotosCollectionViewController: UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let paddingWidth = sectionInserts.left * (itemsPerRow + 1)
    let availableWidth = collectionView.frame.width - paddingWidth
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