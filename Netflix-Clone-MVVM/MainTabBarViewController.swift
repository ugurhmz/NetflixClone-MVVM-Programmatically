//
//  ViewController.swift
//  Netflix-Clone-MVVM
//
//  Created by ugur-pc on 29.03.2022.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        let homeTab = UINavigationController(rootViewController: HomeVC())
        let upComingTab = UINavigationController(rootViewController: UpComingVC())
        let searchTab = UINavigationController(rootViewController: SearchVC())
        let downloadTab = UINavigationController(rootViewController: DownloadVC())
        
        
        homeTab.tabBarItem.image = UIImage(systemName: "house")
        upComingTab.tabBarItem.image = UIImage(systemName: "play.circle")
        searchTab.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        downloadTab.tabBarItem.image = UIImage(systemName: "arrow.down.to.line")
        

        homeTab.title = "Home"
        upComingTab.title = "UpComing"
        searchTab.title = "Search"
        downloadTab.title = "Downloads"
        
        tabBar.tintColor  = .label

        setViewControllers([homeTab, upComingTab, searchTab, downloadTab], animated: true)
        
        
    }
}




