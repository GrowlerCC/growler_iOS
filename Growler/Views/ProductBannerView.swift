//
// Created by Jeff H. on 2017-02-20.
// Copyright (c) 2017 growler. All rights reserved.
//

import Foundation
import UIKit

class ProductBannerView: UIView {

    var product: BUYProduct?

    @IBOutlet weak var image: AsyncImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var costLabel: UILabel!
    
    @IBOutlet weak var borderView: UIView!
    
    private var recognizer: UITapGestureRecognizer!

    override func awakeFromNib() {
        super.awakeFromNib()
        recognizer = UITapGestureRecognizer(target: self, action: #selector(self.didTap(_:)))
        addGestureRecognizer(recognizer)
        layer.masksToBounds = true
        layer.cornerRadius = 3

        borderView.layer.cornerRadius = 3
        borderView.layer.borderWidth = 1
        borderView.layer.borderColor = Colors.grayControlBorderColor.cgColor
    }

    func didTap(_ sender: UITapGestureRecognizer) {
        if let product = product {
            let controller = ProductPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: [:])
            controller.product = product
            AppDelegate.shared.navigationController.pushViewController(controller, animated: true)
        }
    }

}
