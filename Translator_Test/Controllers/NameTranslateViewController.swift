//
//  NameTranslateViewController.swift
//  Translator_Test
//
//  Created by Hamin Jeong on 2022/07/26.
//

import UIKit
//MARK: - 한글이름 로마자 번역기 뷰컨트롤러

class NameTranslateViewController: UIViewController {

    @IBOutlet weak var korNameTextField: UITextField!
    @IBOutlet weak var translateButton: UIButton!
    @IBOutlet weak var mainTableView: UITableView!
    @IBOutlet weak var mainLabel: UILabel!
    
    
    let nameTranslateNetworkManager = NameTranslateNetworkManager.nameShared
    let tableViewCell = NameTransTableViewCell()
    
    var totalResultArray: [AResult] = []
    var aItemArray:[AItem] = []
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurationUI()
        colorConfiguration()
        // Do any additional setup after loading the view.
    }
    

    func configurationUI(){
        korNameTextField.delegate = self
        
        korNameTextField.keyboardType = .default
        korNameTextField.returnKeyType = .default
        
        mainTableView.register(UINib(nibName: "NameTransTableViewCell", bundle: nil), forCellReuseIdentifier: NameTransCell.cellIdentifier)
        mainTableView.dataSource = self
        
        korNameTextField.clipsToBounds = true
        korNameTextField.layer.cornerRadius = 10
    }
    
    private func colorConfiguration(){
        view.backgroundColor = ColorConstant.backgroundColor
        mainLabel.textColor = .darkGray
        korNameTextField.backgroundColor = ColorConstant.textFieldBackGroundColor
        korNameTextField.textColor = .darkGray
        translateButton.tintColor = .darkGray
        mainTableView.backgroundColor = ColorConstant.textFieldBackGroundColor
    }
    
    func getDatas(korName: String){
        nameTranslateNetworkManager.fetchNameTrans(yourName: korName) { result in
            switch result {
            case .success(let array):
                print(array)
                self.totalResultArray = array
                DispatchQueue.main.async {
                    _ = self.totalResultArray.map { result in
                        self.aItemArray = result.aItems
                    }
                    self.mainTableView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    @IBAction func transButtonTapped(_ sender: UIButton) {
        mainTableView.reloadData()
        getDatas(korName: korNameTextField.text ?? "")
        
    }
    
}


//MARK: - 텍스트필드 델리게이트
extension NameTranslateViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        mainTableView.reloadData()
        getDatas(korName: korNameTextField.text ?? "")
        korNameTextField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        korNameTextField.resignFirstResponder()
    }
}


//MARK: - 테이블뷰 데이타소스
extension NameTranslateViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if totalResultArray.isEmpty {
            return 1
        } else {
            return aItemArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = mainTableView.dequeueReusableCell(withIdentifier: NameTransCell.cellIdentifier, for: indexPath) as! NameTransTableViewCell
        
        if totalResultArray.isEmpty {
            cell.firstNameLabel.text = "     올바른 이름을 입력하세요."
            cell.secondNameLabel.text = ""
            
        } else {
            cell.firstNameLabel.text = "     이름 : \(aItemArray[indexPath.row].name)"
            cell.secondNameLabel.text = "     빈도수 : \(aItemArray[indexPath.row].score)"
        }
        return cell
    }
    
    
}
