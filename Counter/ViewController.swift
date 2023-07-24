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
 
    @IBOutlet weak var countPlusButton: UIButton!
    
    @IBOutlet weak var countMinesButton: UIButton!
    
    @IBOutlet weak var changedHistoryTextField: UITextView!
    
    lazy var resetCountButton: UIButton = {
        var configuration = UIButton.Configuration.filled()
        configuration.buttonSize = .large
        configuration.baseBackgroundColor = .systemGray5
        configuration.image = UIImage(systemName: "goforward.5.ar")?.withRenderingMode(.alwaysTemplate)
        configuration.cornerStyle = .capsule
        configuration.baseForegroundColor = .systemOrange
        let button = UIButton(configuration: configuration)
        button.addAction((UIAction(handler: { [weak self] _ in
            self?.countOfTapped = 0
            self?.changeHistoryText.insert("[дата и время]: значение сброшено", at: 0)
            self?.updateHistory()
        })), for: .touchUpInside)
        return button
    }()
    
    var changeHistoryText: [String] = []
    
    var countOfTapped: Int = 0 {
        didSet {
            counterLabel.text = "Значение счётчика: \(countOfTapped)"
        
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(resetCountButton)
        setupResetCountButtonView(button: resetCountButton)

    }
    func updateHistory(){
//        changeHistoryText.forEach { string in
        guard let string = changeHistoryText.first else {return}
        changedHistoryTextField.text = "\(string)\n\n"
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
    private func setupResetCountButtonView(button: UIButton) {
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            button.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
        ])
    }
    
    
}

