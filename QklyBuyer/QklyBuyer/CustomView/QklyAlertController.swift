//
//  QklyAlertController.swift
//  QklyBuyer
//
//  Created by Asmin Ghale on 1/31/23.
//

import UIKit

typealias QklyAlertControllerAction = (_ alertView: QklyAlertController)->()

final class QklyAlertController: UIViewController {
    
    init(title: String?, message: String?, buttonTitle: String? = "OK", buttonAction: @escaping(QklyAlertControllerAction)) {
        super.init(nibName: nil, bundle: nil)
        modalPresentationStyle = .overFullScreen
        modalTransitionStyle = .crossDissolve
        titleLabel.text = title
        titleLabel.isHidden = title == nil
        messageLabel.text = message
        messageLabel.isHidden = message == nil
        defaultButtonAction = buttonAction
        defaultActionButton.setTitle(buttonTitle, for: .normal)
    }
    
    private init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    required private init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    lazy var alertView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        //view.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 400)
        view.round(cornerRadius: 12.0)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = true
        return view
    }()
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .appBoldFont(ofSize: .size_14)
        label.textColor = .app_primary_black!
        return label
    }()
    
    var messageLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .appRegularFont(ofSize: .size_12)
        label.textColor = .app_primary_black!
        return label
    }()
    
    var buttonsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.spacing = 10.0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    var contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .center
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 20.0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isUserInteractionEnabled = true
        return stackView
    }()
    
    private var defaultButtonAction: QklyAlertControllerAction?
    
    lazy var defaultActionButton: QklyAlertActionButton = {
        QklyAlertActionButton(parent: self, title: "OK", buttonColor: .app_primary_green!, textColor: .white, action: self.defaultButtonAction)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black.withAlphaComponent(0.2)
        
        contentStackView.addArrangedSubview(titleLabel)
        contentStackView.addArrangedSubview(messageLabel)
        contentStackView.addArrangedSubview(buttonsStackView)
        
        alertView.addSubview(contentStackView)
        buttonsStackView.addArrangedSubview(defaultActionButton)
        self.view.addSubview(alertView)
        
        NSLayoutConstraint.activate([
            titleLabel.leftAnchor.constraint(equalTo: contentStackView.leftAnchor, constant: 0.0),
            messageLabel.leftAnchor.constraint(equalTo: contentStackView.leftAnchor, constant: 0.0),
            alertView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30.0),
            alertView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30.0),
            alertView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0.0),
            alertView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0.0),
            contentStackView.topAnchor.constraint(equalTo: alertView.topAnchor, constant: 30.0),
            contentStackView.leftAnchor.constraint(equalTo: alertView.leftAnchor, constant: 20.0),
            contentStackView.rightAnchor.constraint(equalTo: alertView.rightAnchor, constant: -20.0),
            contentStackView.bottomAnchor.constraint(equalTo: alertView.bottomAnchor, constant: -25.0),
            defaultActionButton.widthAnchor.constraint(equalToConstant: 80.0)
            
        ])
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(viewTapped)))
        alertView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(alertviewTapped)))
        
        
        
    }
    
    func addButton(title: String, buttonColor: UIColor, textColor: UIColor, action: QklyAlertControllerAction?){
        let button = QklyAlertActionButton(parent: self, title: title, buttonColor: buttonColor, textColor: textColor, action: action)
        buttonsStackView.addArrangedSubview(button)
    }
    
    @objc private func alertviewTapped() {}
    
    @objc private func viewTapped() {
        self.dismiss(animated: false)
    }
    
}

class QklyAlertActionButton: UIButton {
    
    init(parent: QklyAlertController, title: String, buttonColor: UIColor, textColor: UIColor, action: QklyAlertControllerAction?) {
        super.init(frame: CGRect(x: 0, y: 0, width: 79.0, height: 26.0))
        setTitle(title, for: .normal)
        backgroundColor = buttonColor
        titleLabel?.textColor = textColor
        titleLabel?.font = .appFont(ofSize: .size_12, weight: .regular)
        self.action = action
        self.parent = parent
        round(cornerRadius: 4.0)
        addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    weak var parent: QklyAlertController?
    
    private var action: QklyAlertControllerAction?
    
    private override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func buttonTapped() {
        guard let parent = parent else {return}
        action?(parent)
    }
    
}
