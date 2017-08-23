


import UIKit
class DGItem:UIButton {
    
    var selectedColor:UIColor = .gray {
        didSet {
            self.backgroundColor = selectedColor
        }
    }
    var unSelectedColor:UIColor = .darkGray {
        didSet {
            self.backgroundColor = unSelectedColor
        }
    }
    
    override var isSelected: Bool {
        didSet {
            self.backgroundColor = isSelected ? selectedColor : unSelectedColor
        }
    }
    
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



///Datasource
///DGScrollableSegmentControlDataSource
protocol DGScrollableSegmentControlDataSource:class {
    
    func numbersOfItem()->Int
    func itemfor(_ index:Int)->DGItem
    
}

///Delegate
///DGScrollableSegmentControlDelegate
@objc protocol DGScrollableSegmentControlDelegate:class {
    @objc optional func didSelect(_ item:DGItem, atIndex index:Int)
}

class DGScrollableSegmentControl: UIView {
    
    weak var delegate:DGScrollableSegmentControlDelegate?
    weak var datasource:DGScrollableSegmentControlDataSource?
    
    var scrollView: UIScrollView = UIScrollView()
    var dataArray:[String]?
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initialSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.initialSetup()
    }
    
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        self.loadScrollView()
    }
    
    func reload() {
        self.loadItems()
    }
    
    func loadScrollView() {
        self.scrollView.frame = self.frame
        self.scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.backgroundColor = UIColor.green.withAlphaComponent(0.4)
        
        self.addConstraintsWithFormat("H:|[v0]|", views: scrollView)
        self.addConstraintsWithFormat("V:|-2-[v0]|", views: scrollView)
        
        //scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        //scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        //scrollView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        //scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        self.loadItems()
    }
    
    func initialSetup() {
        self.addSubview(scrollView)
        //self.scrollView.delaysContentTouches = false
        self.scrollView.canCancelContentTouches = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    var itemSpacing:CGFloat = 4
   private func loadItems(){
        
        buttonArray.removeAll()
        for item in self.scrollView.subviews{
            item.removeFromSuperview()
        }
        
        guard let dataSource = self.datasource else { print("Data source not implemented"); return }
        
        let numbersOfItems = dataSource.numbersOfItem()
        
        guard numbersOfItems > 0 else {return}
        
        var x = itemSpacing, maxHeight = CGFloat(0.0)
        
        for index in 0 ..< numbersOfItems {
            
            guard let item = datasource?.itemfor(index) else {
                fatalError("Please implement item for index dataSource method") ;
            }
            
            item.addTarget(self, action: #selector(segmentTapped(_:)), for: .touchUpInside)
            item.frame.origin.x = x
            item.frame.origin.y = 0
            item.tag = index
            
            //View configuring
            //item.backgroundColor = .red
            
            /*
             if DeviceType.IS_IPAD{
             button.titleLabel?.font = UIFont(name: (button.titleLabel?.font.fontName)!, size: 26)
             } else if DeviceType.IS_IPAD_PRO_12_9{
             button.titleLabel?.font = UIFont(name: (button.titleLabel?.font.fontName)!, size: 32)
             }else{
             button.titleLabel?.font = UIFont(name: (button.titleLabel?.font.fontName)!, size: 13)
             }
             */
            
            let size:CGSize = item.intrinsicContentSize
            
            if size.width > self.scrollView.frame.width/4{
                item.frame.size = CGSize(width: size.width+10, height: scrollView.frame.height - 3)
            }else{
                item.frame.size = CGSize(width: self.scrollView.frame.width/4, height: scrollView.frame.height - 3 )
            }
            
            scrollView.addSubview(item)
            maxHeight = max(maxHeight, item.frame.size.height)
            
            x += item.frame.size.width + itemSpacing
            
            item.layer.cornerRadius = item.frame.height/2
            item.layer.masksToBounds = true

            buttonArray.append(item)
        }
        
        scrollView.frame.size.height = maxHeight
        scrollView.contentSize = CGSize(width: x, height:scrollView.frame.size.height)
        scrollView.showsHorizontalScrollIndicator = false
        //loadLoactionData(buttonTag: 0)
        scroll(toIndex: 0)
    }
    
    @objc func segmentTapped(_ sender:DGItem) {
        for buttonItem in buttonArray{
            let btn = sender
            if btn == buttonItem {
                buttonItem.isSelected = true
            }else{
                buttonItem.isSelected = false
            }
            //loadLoactionData(buttonTag: sender.tag)
        }
        scroll(toIndex: sender.tag)
        
        guard let delegate = self.delegate else {print("Delegate not implemented"); return }
        delegate.didSelect?(sender, atIndex: sender.tag)
    }
    
    
    var buttonArray:[UIButton] = []
    
    func scroll(toIndex index:Int) {
        guard  self.scrollView.contentSize.width > self.scrollView.frame.width else { return }
        
        let leftSideWidth:CGFloat = buttonArray.reduce(0) { (sum, button) -> CGFloat in
            return  button.tag < index ? sum + button.frame.size.width + 10 : sum
            } + 10
        
        let rightSideWidth:CGFloat = buttonArray.reduce(0) { (sum, button) -> CGFloat in
            return  button.tag > index ? sum + button.frame.size.width + 10 : sum
        }
        
        let selectedButtonWidth:CGFloat = buttonArray[index].frame.size.width + 10
        
        var finalContentOffset = CGPoint.zero
        if rightSideWidth < scrollView.frame.width/2{
            finalContentOffset = CGPoint(x: scrollView.contentSize.width - scrollView.frame.width, y: 0)
            
        }else if leftSideWidth < scrollView.frame.width/2{
            finalContentOffset = CGPoint.zero
            
        }else {
            finalContentOffset = CGPoint(x: leftSideWidth - scrollView.frame.size.width/2 + selectedButtonWidth/2, y: 0)
        }
        
        UIView.animate(withDuration: 0.2) {
            self.scrollView.contentOffset = finalContentOffset
        }
    }
}


private extension UIView {
    func addConstraintsWithFormat(_ format: String, views: UIView...) {
        var viewsDictionary = [String: UIView]()
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDictionary[key] = view
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
    }
    
}




