/*
* Copyright (c) 2015 Droids on Roids LLC
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
* THE SOFTWARE.
*/

extension SwiftCarousel: UIScrollViewDelegate {
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        didSelectItem()
    }
    
    public func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        didSelectItem()
    }
    
    public func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        delegate?.willBeginDragging?(withOffset: scrollView.contentOffset)
    }
    
    public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        delegate?.didEndDragging?(withOffset: scrollView.contentOffset)
    }
    
    public func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity
        velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        /*
        var velocity = velocity.x * 300.0
        
        var targetX = 0 /* align left border of view to left border of carousel */ + velocity
        
        // When the target is being scrolled and we scroll again,
        // the position we need to take as base should be the destination
        // because velocity will stay and if we will take the current position
        // we won't get correct item because the X distance we skipped in the 
        // last circle wasn't included in the calculations.
        if let oldTargetX = currentVelocityX {
            targetX += (oldTargetX - scrollView.contentOffset.x)
        } else {
            targetX += scrollView.contentOffset.x
        }
        print("targetX: \(targetX)\n")
        
        if velocity >= maxVelocity {
            velocity = maxVelocity
        } else if velocity <= -maxVelocity {
            velocity = -maxVelocity
        }

        if targetX < 0.0 {
            targetX = 0
        }
        if (targetX > scrollView.contentSize.width) {
            switch resizeType {
                case .visibleItemsPerPage(let itemsPerPage):
                    let itemWidth = scrollView.bounds.width / itemsPerPage
                    targetX = scrollView.contentSize.width - itemWidth

                default: targetX = scrollView.contentSize.width
            }
        }
 
        let choiceView = nearestViewAtLocation(CGPoint(x: targetX, y: scrollView.frame.minY))
        let newTargetX: CGFloat = 0 /* align left border of view to left border of carousel */
        currentVelocityX = newTargetX
//        targetContentOffset.pointee.x = newTargetX
//        targetContentOffset.pointee.y = 0
//        if case .max(_) = scrollType {
//            scrollView.isScrollEnabled = false
//        }
        */
 
    }
}
