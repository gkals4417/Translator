//
//  DetectedViewController.swift
//  Translator_Test
//
//  Created by Hamin Jeong on 2022/07/26.
//

import UIKit
//MARK: - 감지기 뷰컨트롤러

class DetectedViewController: UIViewController {

    @IBOutlet weak var mainDetectLabel: UILabel!
    @IBOutlet weak var mainTextField: UITextField!
    
    
    let detectNetworkManager = DetectorNetworkManager.detectedShared
    let detector = Detector()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurationUI()
        colorConfiguration()
        // Do any additional setup after loading the view.
    }
    
    func configurationUI(){
        mainTextField.delegate = self
        mainTextField.returnKeyType = .default
        mainTextField.keyboardType = .default
        
        mainTextField.clipsToBounds = true
        mainTextField.layer.cornerRadius = 10
    }
    
    private func colorConfiguration(){
        view.backgroundColor = ColorConstant.backgroundColor
        mainTextField.backgroundColor = ColorConstant.textFieldBackGroundColor
        mainTextField.textColor = .darkGray
        mainDetectLabel.textColor = .darkGray
    }
    
    func detectText(){
        detectNetworkManager.fetchText(detectTerm: mainTextField.text ?? "") { result in
            switch result {
            case .success(let text):
                DispatchQueue.main.async {
                    print(text)
                    self.mainDetectLabel.text = self.detector.detecFunc(detectTerm: text.langCode)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }


}

//MARK: - 텍스트필드 델리게이트

extension DetectedViewController: UITextFieldDelegate {
 
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        detectText()
        mainTextField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        mainTextField.resignFirstResponder()
    }
}
