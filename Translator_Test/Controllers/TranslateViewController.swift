//
//  ViewController.swift
//  Translator_Test
//
//  Created by Hamin Jeong on 2022/07/24.
//

import UIKit
//MARK: - 번역기 뷰컨트롤러

class TranslateViewController: UIViewController {

    @IBOutlet weak var srcPickerView: UIPickerView!
    @IBOutlet weak var targetPickerView: UIPickerView!
    @IBOutlet weak var srcTextField: UITextField!
    @IBOutlet weak var translatedTextField: UITextField!
    @IBOutlet weak var translateButton: UIButton!
    @IBOutlet weak var rightArrow: UIButton!
    
    let transNetworkManager = TransLateNetworkManager.transShared
    let translator = Translator()
    var transString: TransResult = .init(srcLangType: "", tarLangType: "", translatedText: "")

    var tempSrcLanguageValues:String = ""
    var tempTargetLanguageValues: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        colorConfiguration()
        configurationUI()
    }
    
    func configurationUI(){
        srcPickerView.dataSource = self
        targetPickerView.dataSource = self
        srcPickerView.delegate = self
        targetPickerView.delegate = self
        srcTextField.delegate = self
        translatedTextField.delegate = self
        
        srcTextField.clipsToBounds = true
        srcTextField.layer.cornerRadius = 10
        translatedTextField.clipsToBounds = true
        translatedTextField.layer.cornerRadius = 10
        
        srcTextField.keyboardType = .default
        srcTextField.returnKeyType = .default
    }
    
    private func colorConfiguration(){
        view.backgroundColor = ColorConstant.backgroundColor
        srcTextField.backgroundColor = ColorConstant.textFieldBackGroundColor
        srcTextField.textColor = .darkGray
        translatedTextField.backgroundColor = ColorConstant.textFieldBackGroundColor
        translatedTextField.textColor = .darkGray
        rightArrow.tintColor = .darkGray
        translateButton.tintColor = .darkGray
    }
    func getTransText(){
        transNetworkManager.fetchTrans(srcString: tempSrcLanguageValues, targetString: tempTargetLanguageValues, text: srcTextField.text ?? "") { result in
            switch result {
            case .success(let translatedDatas):
                self.transString = translatedDatas
                DispatchQueue.main.async {
                    self.translatedTextField.text = self.transString.translatedText
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    @IBAction func transButtonTapped(_ sender: UIButton) {
        getTransText()
    }

}


//MARK: - 피커뷰 데이터소스
extension TranslateViewController: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return translator.languageKeys.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        tempSrcLanguageValues = translator.getSrcIndex(tempSrcIndex: srcPickerView.selectedRow(inComponent: 0))
        
        tempTargetLanguageValues = translator.getTargetIndex(tempTargetIndex: targetPickerView.selectedRow(inComponent: 0))
        
        print("src: \(tempSrcLanguageValues)")
        print("target: \(tempTargetLanguageValues)")
    }
}

//MARK: - 피커뷰 델리게이트
extension TranslateViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return translator.languageKeys[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var label = UILabel()
        if let v = view as? UILabel {label = v}
        label.font = UIFont(name: "Helvetica Neue", size: 20)
        label.textColor = .darkGray
        label.backgroundColor = ColorConstant.selectBackGroundColor
        label.text = translator.languageKeys[row]
        label.textAlignment = .center
        return label
    }
}

//MARK: - 텍스트필드 델리게이트
extension TranslateViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        getTransText()
        srcTextField.resignFirstResponder()
        return true
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        srcTextField.resignFirstResponder()
        translatedTextField.resignFirstResponder()
    }
}
