import UIKit
protocol CustomSegmentedControlDelegate:class {
    func changeToIndex(index:Int)
}

class CustomSegmentedControl: UIView {
    private var buttonTitles: [String]!
    private var buttons: [UIButton] = []
    private var selectorView: UIView!
    
    var textColor: UIColor = .black
    var selectorViewColor: UIColor = .lightBlue
    var selectorTextColor: UIColor = .lightBlue
    
    weak var delegate: CustomSegmentedControlDelegate?
    
    public private(set) var selectedIndex : Int = 0
    
    convenience init(frame:CGRect, buttonTitle:[String]) {
        self.init(frame: frame)
        self.buttonTitles = buttonTitle
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.backgroundColor = .white
        updateView()
    }
    
    func setButtonTitles(buttonTitles:[String]) {
        self.buttonTitles = buttonTitles
        self.updateView()
    }
    
    func setIndex(position: CGFloat) {
        buttons.forEach( { $0.setTitleColor(textColor, for: .normal) })
        let index = Int(position + 0.5)
        let button = buttons[index]
        selectedIndex = index
        button.setTitleColor(selectorTextColor, for: .normal)
        let selectorPosition = frame.width/CGFloat(buttonTitles.count) * CGFloat(position)
        self.selectorView.frame.origin.x = selectorPosition
    }
    
    func setCurrentDay(index: Int) {
        //        let button = buttons[index]
        //        selectedIndex = index
        //        button.setTitleColor(selectorTextColor, for: .normal)
        //        let selectorPosition = frame.width/CGFloat(buttonTitles.count) * CGFloat(index)
        //        self.selectorView.frame.origin.x = selectorPosition
        delegate?.changeToIndex(index: index)
    }
    
    
    
    
    @objc func buttonAction(sender: UIButton) {
        for (buttonIndex, btn) in buttons.enumerated() {
            //            btn.setTitleColor(textColor, for: .normal)
            if btn == sender {
                selectedIndex = buttonIndex
                delegate?.changeToIndex(index: selectedIndex)
                
                //                btn.setTitleColor(selectorTextColor, for: .normal)
            }
        }
    }
}

//Configuration View
extension CustomSegmentedControl {
    private func updateView() {
        createButton()
        configSelectorView()
        configStackView()
    }
    
    private func configStackView() {
        let stack = UIStackView(arrangedSubviews: buttons)
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fillEqually
        addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: self.topAnchor),
            stack.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            stack.leftAnchor.constraint(equalTo: self.leftAnchor),
            stack.rightAnchor.constraint(equalTo: self.rightAnchor)
        ])
        
    }
    
    private func configSelectorView() {
        let selectorWidth = frame.width / CGFloat(self.buttonTitles.count)
        selectorView = UIView(frame: CGRect(x: 0, y: self.frame.height, width: selectorWidth, height: 2))
        selectorView.backgroundColor = selectorViewColor
        addSubview(selectorView)
    }
    
    private func createButton() {
        
        buttons.removeAll()
        subviews.forEach({$0.removeFromSuperview()})
        for buttonTitle in buttonTitles {
            let button = UIButton(type: .system)
            button.setTitle(buttonTitle, for: .normal)
            button.titleLabel?.font = .systemFont(ofSize: 18, weight: .thin)
            button.addTarget(self, action:#selector(buttonAction(sender:)), for: .touchUpInside)
            button.setTitleColor(textColor, for: .normal)
            buttons.append(button)
        }
    }
}
