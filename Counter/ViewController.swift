//
//  ViewController.swift
//  Counter
//
//  Created by Альберт Хайдаров on 21.07.2023.
//

import UIKit

//enum ChangeHistoryState{
//    case
//
//}

class ViewController: UIViewController {
    
    @IBOutlet weak var counterLabel: UILabel!
 
    
    @IBOutlet weak var changedHistoryTextField: UITextView!
    
    lazy var countPlusButton: UIButton = {
        var configuration = UIButton.Configuration.filled()
        configuration.buttonSize = .large
        configuration.baseBackgroundColor = #colorLiteral(red: 1, green: 0.3294117647, blue: 0.4509803922, alpha: 1)
        configuration.image = .init(named: "plus32")?.withRenderingMode(.alwaysTemplate)
        configuration.cornerStyle = .capsule
        configuration.baseForegroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        let button = UIButton(configuration: configuration)
        button.addAction((UIAction(handler: { [weak self] _ in
            self?.countOfTapped += 1
            self?.changeHistoryText.insert("[дата и время]: значение изменено на +1", at: 0)
            self?.updateHistory()
        })), for: .touchUpInside)
      

        return button
    }()
    
    lazy var resetCountButton: UIButton = {
        var configuration = UIButton.Configuration.filled()
        configuration.buttonSize = .large
        configuration.baseBackgroundColor = #colorLiteral(red: 1, green: 0.3294117647, blue: 0.4509803922, alpha: 1)

        configuration.image = .init(named: "fa6-solid_repeat")?.withRenderingMode(.alwaysTemplate)
        configuration.cornerStyle = .capsule
        configuration.baseForegroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        let button = UIButton(configuration: configuration)
        button.addAction((UIAction(handler: { [weak self] _ in
            self?.countOfTapped = 0
            self?.changeHistoryText.insert("[дата и время]: значение сброшено", at: 0)
            self?.updateHistory()
        })), for: .touchUpInside)
        return button
    }()
    
    lazy var countMinesButton: UIButton = {
        var configuration = UIButton.Configuration.filled()
        configuration.buttonSize = .large
        configuration.baseBackgroundColor = #colorLiteral(red: 1, green: 0.3294117647, blue: 0.4509803922, alpha: 1)

        configuration.image = .init(named: "minus32")?.withRenderingMode(.alwaysTemplate)
        configuration.cornerStyle = .capsule
        configuration.baseForegroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        let button = UIButton(configuration: configuration)
        button.addAction((UIAction(handler: { [weak self] _ in
            self?.countOfTapped += 1
            self?.changeHistoryText.insert("[дата и время]: значение изменено на +1", at: 0)
            self?.updateHistory()
        })), for: .touchUpInside)
        return button
    }()
    
    lazy  var buttonsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        
        return stackView
    }()
    
    var changeHistoryText: [String] = ["\n"]
    
    var countOfTapped: Int = 0 {
        didSet {
            counterLabel.text = "Значение счётчика: \(countOfTapped)"
        
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonsStackView.addArrangedSubview(countPlusButton)
        buttonsStackView.addArrangedSubview(resetCountButton)
        buttonsStackView.addArrangedSubview(countMinesButton)
        view.addSubview(buttonsStackView)

        
        setupViews()
        
       

    }
    func updateHistory(){
//        changeHistoryText.forEach { string in
       let string = changeHistoryText
        changedHistoryTextField.text += "\(string)\n"
//        }
    }
    
    @IBAction func increaseCountAction(_ sender: UIButton) {
        countOfTapped += 1
        changeHistoryText.insert("[дата и время]: значение изменено на +1", at: 0)
        updateHistory()
    }
    @IBAction func decreaseCountAction(_ sender: UIButton) {
        if countOfTapped > 0 {
            countOfTapped -= 1
            changeHistoryText.insert("[дата и время]: значение изменено на -1", at: 0)
            updateHistory()
        } else {
            changeHistoryText.insert("[дата и время]: попытка уменьшить значение счётчика ниже 0", at: 0)
            updateHistory()
        }
    }
    private func setupViews() {
        countPlusButton.translatesAutoresizingMaskIntoConstraints = false
        resetCountButton.translatesAutoresizingMaskIntoConstraints = false
        countMinesButton.translatesAutoresizingMaskIntoConstraints = false
        buttonsStackView.translatesAutoresizingMaskIntoConstraints =  false
        
        NSLayoutConstraint.activate([
            countPlusButton.widthAnchor.constraint(equalToConstant: 100),
            countPlusButton.heightAnchor.constraint(equalToConstant: 100),
            countMinesButton.widthAnchor.constraint(equalToConstant: 100),
            countMinesButton.heightAnchor.constraint(equalToConstant: 100),
            resetCountButton.widthAnchor.constraint(equalToConstant: 100),
            resetCountButton.heightAnchor.constraint(equalToConstant: 100),
            buttonsStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonsStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    
}

