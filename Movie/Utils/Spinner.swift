//
//  Spinner.swift
//  Movie
//
//  Created by Vinicius Ricci on 21/10/18.
//  Copyright © 2018 Vinicius Ricci. All rights reserved.
//

import UIKit

class Spinner: NSObject
{
    struct ActivitySize
    {
        static let height: CGFloat = 60.0
        static let width: CFloat  = 60.0
    }
    
    static let shared = Spinner()
    
    var viewActivity : UIView?
    var activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.whiteLarge)
    
    private func createSppiner(view: UIView) -> UIView
    {
        
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = UIColor.white
        activityIndicator.startAnimating()
        view.addSubview(activityIndicator)
        print(activityIndicator)
        
        return activityIndicator
    }
    
    func show(view:UIView)
    {
        let mainView = UIApplication.shared.keyWindow!.rootViewController!.view!
        
        viewActivity = UIView(frame: CGRect(x: mainView.frame.origin.x, y: mainView.frame.origin.y, width: mainView.frame.width, height: mainView.frame.height))
        viewActivity!.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
        viewActivity!.center = view.center
        
        view.addSubview(viewActivity!)
        
        self.activityIndicator = createSppiner(view: view) as! UIActivityIndicatorView
    }
    
    func stopAnimating()
    {
        self.viewActivity?.isHidden = true
        self.activityIndicator.stopAnimating()
        viewActivity?.removeFromSuperview()
    }

}


// TEMP
class SpinnerLaunchScreen: NSObject
{
    private let activityIndicator = UIActivityIndicatorView(style: .white)
    private let mainView = UIApplication.shared.keyWindow?.rootViewController?.view
    //private let viewActivity  = UIView?
    private let customSpinner = UIImageView()
    
    static let shared = SpinnerLaunchScreen()
    
    //    func show(view: UIView)
    //    {
    //        activityIndicator.center.y = (4 * view.center.y)/3
    //        activityIndicator.center.x = view.center.x
    //        activityIndicator.hidesWhenStopped = true
    //        activityIndicator.startAnimating()
    //        view.addSubview(activityIndicator)
    //    }
    
   
    
    func stop()
    {
        self.activityIndicator.stopAnimating()
        self.customSpinner.isHidden = true
        activityIndicator.removeFromSuperview()
    }
}
