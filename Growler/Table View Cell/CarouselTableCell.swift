//
// Created by Jeff H. on 2017-02-23.
// Copyright (c) 2017 growler. All rights reserved.
//

import Foundation

class CarouselTableCell: UITableViewCell {

    @IBOutlet weak var carousel: SwiftCarousel!
    
    @IBOutlet weak var topCarouselConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var titleLabel: UILabel!

    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var topTitleMargin: NSLayoutConstraint!
    
    
    var bannerFactory: AbstractBannerFactory!

    private var carouselIsSetUp: Bool = false

    static func create(title: String, description: String = "", itemsPerPage: CGFloat, itemMargin: CGFloat = 0, bannerFactory: AbstractBannerFactory) -> CarouselTableCell {
        let cell = CarouselTableCell.loadFromNib()
        
        cell.bannerFactory = bannerFactory
        
        cell.titleLabel.text = title
        if title.isEmpty {
            cell.titleLabel.isHidden = true
            cell.topCarouselConstraint.constant = 0
        } else {
            if description.isEmpty {
                cell.topCarouselConstraint.constant = 43
                cell.topTitleMargin.constant = 11
                cell.titleLabel.font = UIFont(name: "Lato-Bold", size: 19)
            }
            cell.descriptionLabel.text = description
        }
        
        // visibleItemsPerPage is the only resize type in which SwiftCarousel doesn't crash when empty
        // so setting resize type here
        // also resizeType should always be set before setting items
        cell.carousel.resizeType = .visibleItemsPerPage(itemsPerPage)
        cell.carousel.itemMargin = itemMargin
        return cell
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        if !carouselIsSetUp {
            setupCarousel()
            carouselIsSetUp = true
        }
        carousel.layoutSubviews()
    }

    private func setupCarousel() {
        carousel.selectByTapEnabled = true
        let count = bannerFactory.getBannerCount()
        try! carousel.itemsFactory(itemsCount: count) {
            index in self.bannerFactory.getBannerForIndex(index, owner: self)
        }
        carousel.layoutSubviews() // this will update scrollview content size
        // todo? carousel.delegate = self
    }

}
