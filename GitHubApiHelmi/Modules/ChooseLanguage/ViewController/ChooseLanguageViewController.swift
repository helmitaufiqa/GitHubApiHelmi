//
//  ChooseLanguageViewController.swift
//  GitHubApiHelmi
//
//  Created by helmi taufiq alhakim on 24/05/21.
//

import UIKit

class ChooseLanguageViewController: UIViewController {
    
    var viewModel: ChooseLanguageViewModel!
    
    @IBOutlet weak var chooseLanguageTextField: UITextField!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    
    @IBAction func nextBtnTapped(_ sender: UIButton) {
        viewModel.startDashboard()
    }
    
    private var picker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupPickerView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }


    private func setupViews() {
        let selectedLanguage = UserDefaults.standard.object(forKey: "lang")
        let path = Bundle.main.path(forResource: selectedLanguage as? String, ofType: "lproj")
        let bundle = Bundle(path: path!)
        
        let chooseLanguageTFLayer = chooseLanguageTextField.layer
        chooseLanguageTFLayer.cornerRadius = 15
        chooseLanguageTFLayer.borderWidth = 1
        chooseLanguageTFLayer.borderColor = UIColor.darkGray.cgColor
        
        let labelText = bundle!.localizedString(forKey: "Choose Language", value: "Load More", table: nil)
        label.text = labelText
        let buttonText = bundle!.localizedString(forKey: "Next To Dashboard", value: "Load More", table: nil)
        nextButton.setTitle(buttonText, for: .normal)
    }
    
    private func setupPickerView() {
        let selectedLanguage = UserDefaults.standard.object(forKey: "lang")
        let path = Bundle.main.path(forResource: selectedLanguage as? String, ofType: "lproj")
        let bundle = Bundle(path: path!)
        let localizedText = bundle!.localizedString(forKey: "Choose Language...", value: "Choose Language...", table: nil)
        
        picker = UIPickerView()
        picker?.delegate = self
        picker?.dataSource = self
        
        self.chooseLanguageTextField.inputView = picker
        self.chooseLanguageTextField.placeholder = localizedText
        self.chooseLanguageTextField.setupTextFieldPadding()
        self.chooseLanguageTextField.setupDoneButton()
    }
    
}

extension ChooseLanguageViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        self.chooseLanguageTextField.text = language?[row]
        
        if language?[row] == "English" {
            UserDefaults.standard.set("en", forKey: "lang")
        } else {
            UserDefaults.standard.set("id", forKey: "lang")
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        var numberOfRows = Int()
        
        if let count = self.language?.count {
            numberOfRows = count
        }
        
        return numberOfRows
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        var component: String!
        component = language?[row]
        
        return component
    }
    
    var language: [String]? {
        return ["English", "Indonesian"]
    }
}
