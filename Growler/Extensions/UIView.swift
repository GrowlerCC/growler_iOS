//
// Created by Jeff H. on 2017-02-23.
// Copyright (c) 2017 growler. All rights reserved.
//

import Foundation

extension UIView {

    static func loadFromNib() -> Self {
        return self.loadFromNibInternal()
    }

    private static func loadFromNibInternal<T: UIView>() -> T {
        let mirror = Mirror(reflecting: T.self)
        let name = String(describing: mirror.subjectType).replacingOccurrences(of: "\\.Type$", with: "", options: .regularExpression)
        let items = Bundle.main.loadNibNamed(name, owner: nil, options: nil)
        return items?.first as! T
    }

}
