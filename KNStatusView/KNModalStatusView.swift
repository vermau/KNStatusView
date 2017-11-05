//
//  KNModalStatusView.swift
//  KNModalStatusView
//
//  Created by Ujjwal Verma on 3/11/17.
//  Copyright © 2017 XpertLogic. All rights reserved.
//

import UIKit

public class KNModalStatusView: UIView {
    @IBOutlet private weak var statusImage: UIImageView!
    @IBOutlet private weak var headlineLabel: UILabel!
    @IBOutlet private weak var subheadLabel: UILabel!
    
    let nibName = "KNModalStatusView"
    var contentView: UIView!
    var timer: Timer?
    
    /*
     ---------------------------------------------
     MARK: SETUP THE VIEW
     ---------------------------------------------
     */
    
    private func setupView() {
        // :Access the Bundle for this framework
        let bundle = Bundle(for: type(of: self))
        
        // :Access the NIB for this Bundle
        let nib = UINib(nibName: self.nibName, bundle: bundle)
        
        // :Set the contentView refer to the view inside our XIB
        contentView = nib.instantiate(withOwner: self, options: nil).first as! UIView
        
        // :Add the contentView as a subview to the current view
        // :This means that the contentView is being added as a subview to the File's Owner
        addSubview(contentView)
        
        // :Pass an empty array to .autoresizingMask
        // :as no resizing of this control required 'cuz this control has a fixed size
        contentView.center = self.center
        contentView.autoresizingMask = []
        contentView.translatesAutoresizingMaskIntoConstraints = true
        
        headlineLabel.text = ""
        subheadLabel.text = ""
    }
    
    @objc private func removeSelf() {
        UIView.animate(withDuration: 0.25, animations: {
            self.contentView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            self.contentView.alpha = 0.0
        }) { _ in
            self.removeFromSuperview()
        }
    }
    
    public override init(frame: CGRect) {
        // For use in code
        super.init(frame: frame)
        setupView()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        // For use in interface builder
        super.init(coder: aDecoder)
        setupView()
    }
    
    public override func didMoveToSuperview() {
        // :Make the contentView half it's size
        self.contentView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        
        // :Apply animation to contentView as an inline function to "animations" parameter below
        UIView.animate(withDuration: 0.25, animations: {
            self.contentView.alpha = 1.0
            self.contentView.transform = CGAffineTransform.identity
        }) { _ in // :Apply timer to the "completion" (last) parameter as a closure
            self.timer = Timer.scheduledTimer(timeInterval: TimeInterval(3.0),
                                              target: self,
                                              selector: #selector(self.removeSelf),
                                              userInfo: nil, repeats: false)
        }
    }
    
    // :Implement rounded corners for the control
    public override func layoutSubviews() {
        self.layoutIfNeeded()
        self.contentView.layer.masksToBounds = true
        self.contentView.clipsToBounds = true
        self.contentView.layer.cornerRadius = 15
    }
    
    /*
     ---------------------------------------------
     MARK: UPDATE THE VIEW
     ---------------------------------------------
     */
    
    public func set(image: UIImage) {
        statusImage.image = image
    }
    
    public func set(headline toText: String) {
        headlineLabel.text = toText
    }
    
    public func set(subHeading toText: String) {
        subheadLabel.text = toText
    }
}
