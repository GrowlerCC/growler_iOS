//
// Created by Jeff H. on 2017-02-24.
// Copyright (c) 2017 growler. All rights reserved.
//

import Foundation

extension Notification.Name {

    static let favoritesChanged = Notification.Name("favoritesChanged")
    
    static let cartChanged = Notification.Name("cartChanged")

    static let accountChanged = Notification.Name("accountChanged")

    static let creditCardChanged = Notification.Name("creditCardChanged")

    static let promoCodeChanged = Notification.Name("promoCodeChanged")

    func send() {
        NotificationCenter.default.post(name: self, object: nil)
    }
    
}

protocol Notifiable {
}

extension Notifiable {
    
    func subscribeTo(_ notification: Notification.Name, selector: Selector) {
        NotificationCenter.default.addObserver(
                self,
                selector: selector,
                name: notification,
                object: nil
            )
    }

    func unsubscribeFromNotifications() {
        NotificationCenter.default.removeObserver(self)
    }

}
