//
//  UIImageView.swift
//  Movie
//
//  Created by Vinicius Ricci on 17/10/18.
//  Copyright © 2018 Vinicius Ricci. All rights reserved.
//

import UIKit
import Kingfisher
extension UIImageView
{
        func download(image url: String, placeholder: String)
        {
            let imgPlaceholder = UIImage(named: placeholder)
            
            guard let imgURL = URL(string: url) else {
                self.image = imgPlaceholder
                return
            }
            self.kf.indicatorType = .activity
            self.kf.indicator?.startAnimatingView()
            self.kf.setImage(with: ImageResource(downloadURL: imgURL), placeholder: imgPlaceholder) // com cache
            //        self.kf.setImage(with: imgURL, placeholder: UIImage(named: placeholder)) // sem cache
            self.kf.indicator?.stopAnimatingView()
        }
        
//        public func loadGif(name: String) {
//            DispatchQueue.global().async {
//                let image = UIImage.gif(name: name)
//                DispatchQueue.main.async {
//                    self.image = image
//                }
//            }
//        }
//
//        @available(iOS 9.0, *)
//        public func loadGif(asset: String) {
//            DispatchQueue.global().async {
//                let image = UIImage.gif(asset: asset)
//                DispatchQueue.main.async {
//                    self.image = image
//                }
//            }
//        }
}
