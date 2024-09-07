//
//  MainTabBarController.swift
//  BursaKart
//
//  Created by Fatih Oğuz on 23.08.2024.
//

import UIKit

class MainTabBarController: UITabBarController, UITabBarControllerDelegate {
    //MARK: - UIComponents
    public let ovalView: UIView = {
        let ovalView = UIView()
        ovalView.backgroundColor = .white
        ovalView.layer.cornerRadius = 35
        ovalView.translatesAutoresizingMaskIntoConstraints = false
        ovalView.layer.shadowColor = UIColor.black.cgColor // Gölgenin rengi
        ovalView.layer.shadowOpacity = 0.3 // Gölgenin opaklığı (0.0 - 1.0)
        ovalView.layer.shadowOffset = CGSize(width: 0, height: 4) // Gölgenin kaydırma miktarı
        ovalView.layer.shadowRadius = 8 // Gölgenin yayılma yarıçapı
        return ovalView
    }()
    //MARK: - Life Cycle
    override func viewIsAppearing(_ animated: Bool) {
        super.viewIsAppearing(animated)
        self.delegate = self
        setupUI()
        setupContraits()    }
    //MARK: - Tab Bar
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let tabBarHeight: CGFloat = 60
        let verticalOffset: CGFloat = 13
        let tabBarYPosition = view.frame.height - tabBarHeight - view.safeAreaInsets.bottom - verticalOffset
        tabBar.frame = CGRect(x: 0, y: tabBarYPosition, width: view.frame.width, height: tabBarHeight)
        
        tabBar.itemPositioning = .centered
        tabBar.tintColor = AppColorS.addViewColor
        tabBar.unselectedItemTintColor = .lightGray
        tabBar.isTranslucent = false
        view.bringSubviewToFront(ovalView)
        view.bringSubviewToFront(tabBar)
    }
    
    //MARK: - SetupUI
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(ovalView)
        
              let homeVC = HomeVC()
              homeVC.title = "Home"
              homeVC.tabBarItem = UITabBarItem( title: "", image: UIImage(systemName: "house.fill"), tag: 0)
              
              let qrVC = QrVC()
              qrVC.title = "qr"
              qrVC.tabBarItem = UITabBarItem(title: "", image: UIImage(systemName: "qrcode.viewfinder"), tag: 1)
              
              let profileVC = ProfileVC()
              profileVC.title = "Profile"
              profileVC.tabBarItem = UITabBarItem(title:"", image: UIImage(systemName: "rectangle.stack.person.crop.fill"), tag: 2)
              
        viewControllers = [homeVC, qrVC, profileVC]
    }
    private func setupContraits() {
        NSLayoutConstraint.activate([
            ovalView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            ovalView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: -5),
            ovalView.widthAnchor.constraint(equalToConstant: 330),
            ovalView.heightAnchor.constraint(equalToConstant: 75)
        ])
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if let navController = viewController as? UINavigationController {
            if navController.topViewController is QrVC {
                tabBar.isHidden = true
                ovalView.isHidden = true
                navigationItem.hidesBackButton = false
            } else {
                tabBar.isHidden = false
                ovalView.isHidden = false
                navigationItem.leftBarButtonItem = nil
            }
        }
    }
}

