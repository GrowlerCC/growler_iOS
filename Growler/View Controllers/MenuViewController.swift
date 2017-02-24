//
// Created by Alexander Gorbovets on 2017-02-19.
// Copyright (c) 2017 growler. All rights reserved.
//

import Foundation
import UIKit

class MenuViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var homeController: HomeViewController? // todo move to appdelegate? or to new class AppController?

    // todo store link to navigation controller here or retrieve it from app.
    // todo store all view controllers which can be reused instead of recreating them. they can be store in menu object or in AppDelegate/AppController

    @IBOutlet weak var tableView: UITableView!
    
    var menuItems: [MenuItem] = [
        // menu items with darker color
        MenuItem.create(title: "Profile", color: UIColor(0x25313b), image: UIImage(named: "AccountProfileIcon")) {
            AppDelegate.shared.navigationController.viewControllers = [AccountProfileViewController()]
        },
        MenuItem.create(title: "My orders", color: UIColor(0x25313b), image: UIImage(named: "MyOrdersIcon")) {
            AppDelegate.shared.navigationController.viewControllers = [MyOrdersViewController()]
        },
        MenuItem.create(title: "Recommendations", color: UIColor(0x25313b), image: UIImage(named: "RecommendationsIcon")) {
            AppDelegate.shared.navigationController.viewControllers = [RecommendationListViewController()]
        },
        MenuItem.create(title: "Favorites", color: UIColor(0x25313b), image: UIImage(named: "FavoritesIcon")) {
            AppDelegate.shared.navigationController.viewControllers = [FavoriteListViewController()]
        },

        MenuItem.create(title: "", image: nil), // separator

        // menu items with lighter color
//        MenuItem.create(title: "App settings", image: UIImage(named: "SettingsIcon")),
        MenuItem.create(title: "FAQs", image: UIImage(named: "FaqsIcon")) {
            AppDelegate.shared.navigationController.viewControllers = [FaqViewController.loadFromStoryboard()]
        },
        MenuItem.create(title: "About", image: UIImage(named: "AboutIcon")) {
            AppDelegate.shared.navigationController.viewControllers = [AboutViewController.loadFromStoryboard()]
        },
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorStyle = .none
        tableView.contentInset = UIEdgeInsetsMake(50, 0, 0, 0) // make room for status bar
    }

    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        let selectedItem = menuItems[indexPath.row]
        AppDelegate.shared.sideMenuViewController!.hideViewController()
        selectedItem.didSelect?()
        return indexPath
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return menuItems[indexPath.row]
    }

    func tableView(_ tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60
    }

    @IBAction func didTapCloseButton(_ sender: Any) {
        AppDelegate.shared.sideMenuViewController!.hideViewController()
    }

    @IBAction func didTapLogo(_ sender: Any) {
        let nav = self.homeController!.navigationController
        nav!.viewControllers = [homeController!]
        AppDelegate.shared.sideMenuViewController!.hideViewController()
    }
    
}
