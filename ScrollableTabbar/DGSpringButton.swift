

//  Created by dpd Ghimire (dip kasyap) on 8/18/17.
//  Copyright © 2017 dip. dpd.ghimire@gmail.com All rights reserved.
//

/*
 Copyright (c) <2017> <dpd Ghimire>
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 SOFTWARE.
 */



import UIKit

/// A UIButton subclass that renders a springy animation when tapped.
/// If the damping parameters are set to 1.0, this class may be used to provide subtle feedback to buttons with no elsasticity.
/// - parameter minimumScale: The minimum scale that the button may reach while pressed. Default 0.95
/// - parameter pressSpringDamping: The damping parameter for the spring animation used when the button is pressed. Default 0.4
/// - parameter releaseSpringDamping: The damping parameter for the spring animation used when the button is released. Default 0.35
/// - parameter pressSpringDuration: The duration of the spring animation used when the button is pressed. Default 0.4
/// - parameter releaseSpringDuration: The duration of the spring animation used when the button is reloeased. Default 0.5

open class DGSpringButton: UIButton {
  
  /** sets gradiant on button if yes , default is no*/
  @IBInspectable open var showGradiant:Bool = false {
    didSet {
      if showGradiant {
        setUpLayers()
      }
    }
  }
  @IBInspectable var languageButtonColor : UIColor = UIColor.clear {
    didSet{
      setUpSelctedState()
    }
  }
  @IBInspectable open var makeSelected: Bool = false {
    didSet {
      setUpSelctedState()
    }
  }
  
    @IBInspectable open var selectedTitleColor: UIColor = UIColor.white {
        didSet {
            setUpSelctedState()
        }
    }

    @IBInspectable open var unSelectedTitleColor: UIColor = UIColor.white {
        didSet {
            setUpSelctedState()
        }
    }
    
  open var minimumScale: CGFloat = 0.95
  open var pressSpringDamping: CGFloat = 0.4
  open var releaseSpringDamping: CGFloat = 0.35
  open var pressSpringDuration = 0.4
  open var releaseSpringDuration = 0.5
  open var cornorRadious:CGFloat = 6.0
  
  var shineLayer:CAGradientLayer?
  var highlightLayer:CALayer?
  
  open override func awakeFromNib() {
    
  }
  
  public init() {
    super.init(frame:  CGRect.zero)

    }

    
    override init(frame: CGRect) {
        super.init(frame:frame)
        if showGradiant {
            setUpLayers()
        }
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        if showGradiant {
            setUpLayers()
        }
    }
    
    open override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        shineLayer?.frame = self.bounds
        highlightLayer?.frame = self.bounds
    }
    
    
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)

        UIView.animate(withDuration: self.pressSpringDuration, delay: 0, usingSpringWithDamping: self.pressSpringDamping, initialSpringVelocity: 0, options: [.curveLinear, .allowUserInteraction], animations: { () -> Void in
            self.transform = CGAffineTransform(scaleX: self.minimumScale, y: self.minimumScale)
            }, completion: nil)
        
        self.setHighlighted(highlight: true)
    }
    
    open override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        
        UIView.animate(withDuration: self.releaseSpringDuration, delay: 0, usingSpringWithDamping: self.releaseSpringDamping, initialSpringVelocity: 0, options: [.curveLinear, .allowUserInteraction], animations: { () -> Void in
            self.transform = CGAffineTransform.identity
            }, completion: nil)
        
        self.setHighlighted(highlight: false)

    }
    
    open override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        
        let location = touches.first!.location(in: self)
        if !self.bounds.contains(location) {
            UIView.animate(withDuration: self.releaseSpringDuration, delay: 0, usingSpringWithDamping: self.releaseSpringDamping, initialSpringVelocity: 0, options: [.curveLinear, .allowUserInteraction], animations: { () -> Void in
                self.transform = CGAffineTransform.identity
                }, completion: nil)
        }
    }
    
    open override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        
        UIView.animate(withDuration: self.releaseSpringDuration, delay: 0, usingSpringWithDamping: self.releaseSpringDamping, initialSpringVelocity: 0, options: [.curveLinear, .allowUserInteraction], animations: { () -> Void in
            self.transform = CGAffineTransform.identity
            }, completion: nil)
    }
    
 
    
    func setUpLayers() {
        self.setUpBorder()
        self.addShileLayer()
        self.addHighlightLayer()

    }
    
    func setUpBorder() {
        let layer = self.layer
        layer.cornerRadius = 8
        layer.masksToBounds = true
        layer.borderWidth = 1
        layer.borderColor =  UIColor.white.withAlphaComponent(0.5).cgColor
    }
    
    func addShileLayer() {
       
        self.shineLayer = CAGradientLayer()
        self.shineLayer?.frame = self.layer.bounds
        shineLayer?.colors = [
            UIColor.init(white: 1, alpha: 0.4).cgColor,
            UIColor.init(white: 1, alpha: 0.2).cgColor,
            UIColor.init(white: 0.75, alpha: 0.2).cgColor,
            UIColor.init(white: 0.4, alpha: 0.2).cgColor,
            UIColor.init(white: 1, alpha: 0.4).cgColor
        ]
        
        shineLayer?.locations = [0.0,0.5,0.5,0.8,1.0]
        
        self.layer.addSublayer(shineLayer!)
    }
    
    func addHighlightLayer() {
        
        self.highlightLayer = CALayer()
        highlightLayer?.backgroundColor = UIColor.black.withAlphaComponent(0.4).cgColor
        highlightLayer?.isHidden = true
        self.layer.insertSublayer(highlightLayer!, below: self.shineLayer)
    }
    
    func setHighlighted(highlight:Bool) {
        self.highlightLayer?.isHidden = !highlight
        super.isHighlighted = highlight
    }
    
    func setUpSelctedState () {
        
        self.tintColor = .clear
        self.backgroundColor = .clear
        
        if makeSelected {
            self.backgroundColor = languageButtonColor
            self.setTitleColor(selectedTitleColor, for: UIControlState.normal)


        } else {
            self.layer.borderWidth = 1
            self.layer.borderColor = languageButtonColor.cgColor
            self.setTitleColor(unSelectedTitleColor, for: UIControlState.normal)

        }
    }

}



