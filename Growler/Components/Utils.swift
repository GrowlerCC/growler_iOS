//
// Created by Jeff H. on 2017-02-19.
// Copyright (c) 2017 growler. All rights reserved.
//

import Foundation
import UIKit

@objc
class Utils: NSObject {

    // todo move to UIView extension
    static func loadViewFromNib(nibName: String, owner: AnyObject?) -> UIView {
        let views = Bundle.main.loadNibNamed(nibName, owner: owner, options: nil)
        return views![0] as! UIView
    }

    static func formatUSD(value: NSDecimalNumber) -> String {
        let numberFormatter = NumberFormatter();
        numberFormatter.numberStyle = .currency
        numberFormatter.locale = Locale(identifier: "en_US")
        return numberFormatter.string(from: value) ?? ""
    }

    static func formatDecimal(_ value: NSDecimalNumber) -> String {
        let numberFormatter = NumberFormatter();
        numberFormatter.numberStyle = .decimal
        return numberFormatter.string(from: value) ?? ""
    }

    static func alert(message: String) {
        self.alert(message: message, parent: nil)
    }

    static func alert(message: String, parent: UIViewController? = nil) {
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        let parent = parent ?? UIApplication.shared.keyWindow?.rootViewController
        mq {
            parent?.present(alertController, animated: true, completion: nil)
        }
    }

    class func calculateContentHeight(navigationController: UINavigationController) -> CGFloat {
        let screenHeight = UIScreen.main.bounds.height
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        let navigationBarHeight = navigationController.navigationBar.frame.height
        let toolbarHeight = navigationController.toolbar.frame.height
        return screenHeight - statusBarHeight - navigationBarHeight - toolbarHeight
    }


    class func calculateTopInset(navigationController: UINavigationController) -> CGFloat {
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        let navigationBarHeight = navigationController.navigationBar.frame.height
        return statusBarHeight + navigationBarHeight
    }

    static func inputBox(title: String, message: String, okTitle: String, callback: @escaping (String?) -> Void) {
        let alert = UIAlertController(title: title,
            message: message,
            preferredStyle: .alert)

        alert.addTextField { _ in }

        alert.addAction(UIAlertAction(title: okTitle, style: .default) {
            action in
            let textField = alert.textFields![0]
            callback(textField.text)
        })

        alert.addAction(UIAlertAction(title: "Cancel", style: .default) {
            action in callback(nil)
        })

        mq {
            UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
        }
    }

    static func formatErrorInfo(_ info: [AnyHashable: Any], message: String) -> String {
        let separator = "\n\n"
        var errors = [String]()
        if let error = info["error"] as? String {
            return error
        }
        guard let errorList = info["errors"] as? [AnyHashable: Any] else {
            return message
        }
        for (rawAction, rawActionErrors) in errorList {
            let action = Utils.humanReadable(rawAction as? String).capitalized
            guard let actionErrors = rawActionErrors as? NSDictionary else {
                continue
            }
            for (rawForm, rawFormErrors) in actionErrors {
                let form = Utils.humanReadable(rawForm as? String).capitalized
                if let formErrors = rawFormErrors as? NSDictionary {
                    parseErrorMap(form, formErrors, &errors)
                }
                if let formErrors = rawFormErrors as? NSArray {
                    parseErrorArray(form, formErrors, &errors)
                }
            }
        }
        return message + separator + errors.joined(separator: separator)
    }
    
    static func parseErrorMap(_ form: String, _ formErrors: NSDictionary, _ errors: inout [String]) {
        for (rawField, rawFieldErrors) in formErrors {
            let field = Utils.humanReadable(rawField as? String).capitalized
            guard let fieldErrors = rawFieldErrors as? NSArray else {
                continue
            }
            for rawError in fieldErrors {
                guard let error = rawError as? NSDictionary else {
                    continue
                }
                if let message = error["message"] as? String {
                    errors.append(
                        //"\(action) - "+
                        "\(form) - \(field): \(message)"
                    )
                }
            }
        }
    }
    
    static func parseErrorArray(_ form: String, _ formErrors: NSArray, _ errors: inout [String]) {
        print("\(formErrors)")
        for item in formErrors {
            if let dictionary = item as? NSDictionary {
                parseErrorMap(form, dictionary, &errors)
            }
        }
    }
    
    static func humanReadable(_ text: String?) -> String {
        return (text ?? "").replacingOccurrences(of: "_", with: " ")
    }

    static func maskCreditCardNumber(_ value: String) -> String {
        if value.isEmpty {
            return ""
        }
        var number = value
        let endIndex = max(0, number.characters.count - 4)
        let start = number.index(number.startIndex, offsetBy: 0)
        let end = number.index(number.startIndex, offsetBy: endIndex)
        number.replaceSubrange(start..<end, with: "************")
        return number
    }

}


/**
 * Stands for main queue. Asynchronously executes passed callback on main queue if calling code is not from main queue. Otherwise just calls block
 */
func mq(callback: @escaping () -> Void) {
    if Thread.isMainThread {
        callback()
    } else {
        DispatchQueue.main.async(execute: callback)
    }
}
