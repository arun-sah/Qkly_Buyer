//
//  BaseView.swift
//  QklyBuyer
//
//  Created by arun sah on 18/01/2023.
//

import UIKit

/// The base view to be inherited by all screen child
open class BaseView: UIView {
    
    /// The size of the view indicator
    private var indicatorDimension = CGSize(width: 55.0, height: 55.0)
    
    /// flag to check if the indicator is indicating or not
    private var indicating: Bool = false
    
    /// indicator color
    public var indicatorColor: UIColor = .black
    
  
    
    /// The freeze view
    private lazy var freezerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    /// Frame Initializer
    override public init(frame: CGRect) {
        super.init(frame: frame)
        create()
    }
    
    /// Coder initializer
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        create()
    }
    
    /// base function to create the subviews
    /// This function is override by different views to create their own subviews
    open func create() {
        self.backgroundColor = .white
    }
    
    /// This method will add a non interactive, non visible overlay over the screen so that all elements appears to be disabled
    public func freezeAll() {
        
        addSubview(freezerView)
        
        NSLayoutConstraint.activate([
            freezerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            freezerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            freezerView.topAnchor.constraint(equalTo: topAnchor),
            freezerView.bottomAnchor.constraint(equalTo: bottomAnchor)
            
        ])
    }
    
    /// This method will remove the freezer view from screen
    public func unFreezeAll() {
        freezerView.removeConstraints(freezerView.constraints)
        freezerView.removeFromSuperview()
    }
    
   
   
 
    
    /// Deint call check
    deinit {
        debugPrint("De-Initialized --> \(String(describing: self))")
    }
}
