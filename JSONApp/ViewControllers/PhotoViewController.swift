//
//  PhotoViewController.swift
//  JSONApp
//
//  Created by Дарья Носова on 16.01.2022.
//

import UIKit

class PhotoViewController: UIViewController {
  
  @IBOutlet var photoImageView: UIImageView!
  
  var image: UIImage?
  
  override func viewDidLoad() {
    super.viewDidLoad()

    photoImageView.image = image
  }

  @IBAction func shareAction(_ sender: UIButton) {
    let shareController = UIActivityViewController(activityItems: [image!], applicationActivities: nil)
    
    shareController.completionWithItemsHandler = { _, bool, _, _ in
      if bool {
        print("Good")
      }
    }
    present(shareController, animated: true, completion: nil)
  }
}
