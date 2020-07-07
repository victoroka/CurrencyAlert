//
//  CustomTabBarController.swift
//  CurrencyAlert
//
//  Created by Victor Oka on 06/07/20.
//  Copyright © 2020 Alerta Câmbio. All rights reserved.
//

import UIKit
import SnapKit

class CustomTabBarController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        
        guard let alertsImage = UIImage(named: Constants.TabBar.alertsIconImageName) else { return }
        let resizedAlertsImage = resizeImage(image: alertsImage, targetSize: CGSize(width: 35, height: 35))
        let viewModel = CurrenciesListViewModel(networkingService: NetworkingAPI())
        let currenciesListViewController = CurrenciesListViewController(viewModel: viewModel)
        currenciesListViewController.tabBarItem = UITabBarItem(title: Constants.TabBar.alertsItemTitle, image: resizedAlertsImage, tag: 0)
        
        let createAlertViewController = CreateAlertViewController()
        createAlertViewController.tabBarItem = UITabBarItem(title: nil, image: nil, tag: 1)
        
        guard let profileImage = UIImage(named: Constants.TabBar.profileIconImageName) else { return }
        let resizedProfileImage = resizeImage(image: profileImage, targetSize: CGSize(width: 35, height: 35))
        let userProfileViewController = UserProfileViewController()
        userProfileViewController.tabBarItem =  UITabBarItem(title: Constants.TabBar.profileItemTitle, image: resizedProfileImage, tag: 2)
        
        let tabBarList = [currenciesListViewController, createAlertViewController, userProfileViewController]
        viewControllers = tabBarList
        
        setupMiddleButton()
    }
    
    private func setupMiddleButton() {
        
        guard let image = UIImage(named: Constants.TabBar.addAlertIconImageName) else { return }
        let middleBtn = UIButton(frame: CGRect(x: (self.view.bounds.width / 2)-25, y: -20, width: 60, height: 60))
        let buttonImage = resizeImage(image: image, targetSize: CGSize(width: 35, height: 35))
        
        middleBtn.backgroundColor = UIColor.systemPurple.withAlphaComponent(0.8)
        middleBtn.layer.cornerRadius = 20
        middleBtn.setImage(buttonImage, for: .normal)
        
        self.tabBar.addSubview(middleBtn)
        middleBtn.addTarget(self, action: #selector(customButtonAction), for: .touchUpInside)

        self.view.layoutIfNeeded()
    }
    
    @objc func customButtonAction(sender: UIButton) {
        selectedIndex = 1
    }

    private func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size

        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }
        
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage!
    }
}

class CustomTabBar: UITabBar {
    
    private var shapeLayer: CALayer?
    
    private func addShape() {
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = createPath()
        shapeLayer.strokeColor = UIColor.lightGray.cgColor
        shapeLayer.fillColor = UIColor.white.cgColor
        shapeLayer.lineWidth = 1.0
        
        //The below 4 lines are for shadow above the bar. you can skip them if you do not want a shadow
        shapeLayer.shadowOffset = CGSize(width:0, height:0)
        shapeLayer.shadowRadius = 10
        shapeLayer.shadowColor = UIColor.gray.cgColor
        shapeLayer.shadowOpacity = 0.3

        if let oldShapeLayer = self.shapeLayer {
            self.layer.replaceSublayer(oldShapeLayer, with: shapeLayer)
        } else {
            self.layer.insertSublayer(shapeLayer, at: 0)
        }
        self.shapeLayer = shapeLayer
    }
    
    override func draw(_ rect: CGRect) {
        self.addShape()
    }
    
    func createPath() -> CGPath {
        let height: CGFloat = 37.0
        let path = UIBezierPath()
        let centerWidth = self.frame.width / 2
        path.move(to: CGPoint(x: 0, y: 0)) // start top left
        path.addLine(to: CGPoint(x: (centerWidth - height * 2), y: 0)) // the beginning of the trough

        path.addCurve(to: CGPoint(x: centerWidth, y: height),
        controlPoint1: CGPoint(x: (centerWidth - 30), y: 0), controlPoint2: CGPoint(x: centerWidth - 35, y: height))

        path.addCurve(to: CGPoint(x: (centerWidth + height * 2), y: 0),
        controlPoint1: CGPoint(x: centerWidth + 35, y: height), controlPoint2: CGPoint(x: (centerWidth + 30), y: 0))

        path.addLine(to: CGPoint(x: self.frame.width, y: 0))
        path.addLine(to: CGPoint(x: self.frame.width, y: self.frame.height))
        path.addLine(to: CGPoint(x: 0, y: self.frame.height))
        path.close()

        return path.cgPath
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        guard !clipsToBounds && !isHidden && alpha > 0 else { return nil }
        for member in subviews.reversed() {
            let subPoint = member.convert(point, from: self)
            guard let result = member.hitTest(subPoint, with: event) else { continue }
            return result
        }
        return nil
    }
}
