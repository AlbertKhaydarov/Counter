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
    
    @IBOutlet weak var historyChangesTextView: UITextView!
    
    lazy var countPlusButton: UIButton = {
        var configuration = UIButton.Configuration.filled()
        configuration.buttonSize = .large
        configuration.baseBackgroundColor = #colorLiteral(red: 0.9804422259, green: 0.5767289996, blue: 0.5899683237, alpha: 1)
        configuration.image = .init(named: "plus32")?.withRenderingMode(.alwaysTemplate)
        configuration.cornerStyle = .capsule
        configuration.baseForegroundColor = #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)
        let button = UIButton(configuration: configuration)
        button.addAction((UIAction(handler: { [weak self] _ in
            self?.increaseCountAction(button)
            print(self?.changeHistoryText)
        })), for: .touchUpInside)
      

        return button
    }()
    
    lazy var resetCountButton: UIButton = {
        var configuration = UIButton.Configuration.filled()
        configuration.buttonSize = .large
        configuration.baseBackgroundColor = #colorLiteral(red: 0.9804422259, green: 0.5767289996, blue: 0.5899683237, alpha: 1)

        configuration.image = .init(named: "fa6-solid_repeat")?.withRenderingMode(.alwaysTemplate)
        configuration.cornerStyle = .capsule
        configuration.baseForegroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        let button = UIButton(configuration: configuration)
        button.addAction((UIAction(handler: { [weak self] _ in
            self?.countOfTapped = 0
            self?.changeHistoryText.insert("[дата и время]: значение сброшено", at: 0)
//            self?.changeHistoryText.append("[дата и время]: значение сброшено")
            self?.updateHistory()
            print(self?.changeHistoryText)
        })), for: .touchUpInside)
        return button
    }()
    
    lazy var countMinesButton: UIButton = {
        var configuration = UIButton.Configuration.filled()
        configuration.buttonSize = .large
        configuration.baseBackgroundColor = #colorLiteral(red: 0.9804422259, green: 0.5767289996, blue: 0.5899683237, alpha: 1)

        configuration.image = .init(named: "minus32")?.withRenderingMode(.alwaysTemplate)
        configuration.cornerStyle = .capsule
        configuration.baseForegroundColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
        let button = UIButton(configuration: configuration)
        button.addAction((UIAction(handler: { [weak self] _ in
            self?.decreaseCountAction(button)
//            self?.changeHistoryText.append("[дата и время]: значение изменено на -1")
            print(self?.changeHistoryText)
        })), for: .touchUpInside)
        return button
    }()
    
    lazy  var buttonsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        
        return stackView
    }()
    
    var changeHistoryText: [String] = []
    
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
        guard let string = changeHistoryText.last else {return}
        
        var text = "История изменений:\n"
        for item in changeHistoryText {
        text = text + item + "\n"
        }
        historyChangesTextView.text = text
//        historyChangesTextView.text.append(string + "\n")
//        changedHistoryTextField.text += "\(string[string.count - 1])\n"
//        }
    }
    
    
    
    func increaseCountAction(_ sender: UIButton) {
        countOfTapped += 1
        changeHistoryText.insert("[дата и время]: значение изменено на +1", at: 0)
//        changeHistoryText.append("[дата и время]: значение изменено на +1")
        updateHistory()
    }
   func decreaseCountAction(_ sender: UIButton) {
        if countOfTapped > 0 {
            countOfTapped -= 1
            changeHistoryText.insert("[дата и время]: значение изменено на -1", at: 0)
//            changeHistoryText.append("[дата и время]: значение изменено на -1")
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

