//
//  UIViewController+Additions.swift
//  Soundrenaline
//
//  Created by Wito Chandra on 13/07/16.
//  Copyright © 2016 Suitmedia. All rights reserved.
//

import UIKit

extension UIViewController {
    
//    func setupShareButton(white: Bool = false) {
//        let barButtonItemShare = UIBarButtonItem(image: UIImage(named: "ic_share"), style: .plain, target: self, action: #selector(UIViewController.sharePressed(_:)))
//        barButtonItemShare.tintColor = white ? UIColor.white : UIColor(hex: 0x232323)
//        navigationItem.rightBarButtonItem = barButtonItemShare
//    }
//
//    func setupLeftBarButtonItems(menu: Bool, close: Bool, back: Bool = false, white: Bool = false) {
//        var items = [UIBarButtonItem]()
//        if menu {
//            let barButtonItemMenu = UIBarButtonItem(image: UIImage(named: "hamburger_icon"), style: .plain, target: self, action: #selector(UIViewController.menuPressed(_:)))
//            barButtonItemMenu.tintColor = white ? UIColor.white : UIColor.primary()
//            items.append(barButtonItemMenu)
//        }
//        if close {
//            var barButtonItemClose = UIBarButtonItem(image: UIImage(named: "ic_close_white"), style: .plain, target: self, action: #selector(UIViewController.closePressed(_:)))
//            if back {
//                barButtonItemClose = UIBarButtonItem(image: UIImage(named: "ic_back_black"), style: .plain, target: self, action: #selector(UIViewController.backPressed(_:)))
//            }
//            barButtonItemClose.tintColor = white ? UIColor.white : UIColor(hex: 0x232323)
//            items.append(barButtonItemClose)
//        }
//        navigationItem.leftBarButtonItems = items
//    }
//
//    func setupBackBarButtonItems(back: Bool, title: String? = "") {
//        var items = [UIBarButtonItem]()
//        if back {
//            let barButtonItemMenu = UIBarButtonItem(image: UIImage(named: "ic_back_black"), style: .plain, target: self, action: #selector((backPressed)))
//            barButtonItemMenu.tintColor = UIColor(hex: 0x232323)
//            items.append(barButtonItemMenu)
//        }
//        if let title = title, title != "" {
//            let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 60))
//            label.textColor = UIColor.white
//            label.textAlignment = .left
//            label.text = title
//            label.font = UIFont.systemFont(ofSize: 16)
//            let barButtonItemMenu = UIBarButtonItem(customView: label)
//            items.append(barButtonItemMenu)
//        }
//        navigationItem.leftBarButtonItems = items
//    }
//
//    func setupPanGesture() {
//        view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(UIViewController.panGestureRecognized(_:))))
//    }
//
//    @objc func menuPressed(_ sender: UIBarButtonItem) {
////        self.view.endEditing(true)
////        self.frostedViewController?.view.endEditing(true)
////        self.frostedViewController?.presentMenuViewController()
//    }
//
//    @objc func closePressed(_ sender: UIBarButtonItem) {
//        self.dismiss(animated: true, completion: nil)
//    }
//
//    @objc func sharePressed(_ sender: UIBarButtonItem?) {
////        let items = [
////            "Download Soundrenaline app and get the latest updates! ",
////            URL(string: ShareManager.LINK_ITUNES_SOUNDRENALINE)!
////
////        ] as [Any]
////        let controller = UIActivityViewController(activityItems: items, applicationActivities: nil)
////        controller.excludedActivityTypes = [UIActivityType.assignToContact, UIActivityType.copyToPasteboard, UIActivityType.postToWeibo, UIActivityType.print]
////        present(controller, animated: true, completion: nil)
//    }
//
//    @objc func panGestureRecognized(_ recognizer: UIPanGestureRecognizer) {
//        view.endEditing(true)
//        frostedViewController?.view.endEditing(true)
//        frostedViewController?.panGestureRecognized(recognizer)
//    }
//
//    func setupTitle(_ title: String? = "title") {
////        var items = [UIBarButtonItem]()
//        if let title = title {
//            let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 60))
//            label.textColor = UIColor.primary()
//            label.textAlignment = .center
//            label.text = title
//            label.font = UIFont.systemFont(ofSize: 18)
////            let barButtonItemMenu = UIBarButtonItem(customView: label)
////            items.append(barButtonItemMenu)
////            navigationItem.title = title
//            navigationItem.titleView = label
//        }
////        navigationItem .leftBarButtonItems = items
//    }
//
////    func showAlertDialog(title: String? = nil, message: String) {
////        //let image = UIImage(named: "pexels-photo-103290")
////
////        // Create the dialog
////        let popup = PopupDialog(title: title, message: message) //, image: image)
////        popup.transitionStyle = PopupDialogTransitionStyle.fadeIn
////
////        let buttonClose = DefaultButton(title: "Close", height: 60) {
////            //print("Ah, maybe next time :)")
////        }
////
////        // Add buttons to dialog
////        // Alternatively, you can use popup.addButton(buttonOne)
////        // to add a single button
////        popup.addButtons([buttonClose])
////
////        // Present dialog
////        self.present(popup, animated: true, completion: nil)
////
//////        let alert = UIAlertController(title: nil, message: message, preferredStyle: UIAlertControllerStyle.alert)
//////        alert.addAction(UIAlertAction(title: "Close", style: UIAlertActionStyle.default, handler: nil))
//////        self.present(alert, animated: true, completion: nil)
////    }
//
//    func setupStatusBarTintByNavController() {
//        if let navigationController = navigationController {
//            navigationController.navigationBar.barStyle = UIBarStyle.default
//        }
//    }
//
//    @objc func backPressed(_ sender: UIBarButtonItem) {
//        if isModal() {
//            self.dismiss(animated: true, completion: nil)
//        } else {
//            let _ = self.navigationController?.popViewController(animated: true)
//        }
//    }
//
//    private func isModal() -> Bool {
//        if self.navigationController?.viewControllers.count == 1 {
//            return true
//        }
//        return false
//    }
//
//    func imageLayerForGradientBackground() -> UIImage {
//
//        var updatedFrame = self.navigationController?.navigationBar.bounds
//        // take into account the status bar
//        updatedFrame?.size.height += 20
//        let layer = self.setGradientLayerForBounds(firstColor: UIColor(hex: 0xffffff), secondColor: UIColor(hex: 0xffffff),bounds: updatedFrame!)
//        UIGraphicsBeginImageContext(layer.bounds.size)
//        layer.render(in: UIGraphicsGetCurrentContext()!)
//        let image = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//        return image!
//    }
//
//    func setGradientLayerForBounds(firstColor: UIColor, secondColor: UIColor, bounds: CGRect) -> CAGradientLayer {
//        let layer = CAGradientLayer()
//        layer.frame = bounds
//        layer.colors = [firstColor.cgColor, secondColor.cgColor]
//        return layer
//    }
    
}
