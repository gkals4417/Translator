//
//  NameTranslateViewController.swift
//  Translator_Test
//
//  Created by Hamin Jeong on 2022/07/26.
//

import UIKit

class NameTranslateViewController: UIViewController {

    @IBOutlet weak var korNameTextField: UITextField!
    @IBOutlet weak var translateButton: UIButton!
    @IBOutlet weak var mainTableView: UITableView!
    
    
    let nameTranslateNetworkManager = NameTranslateNetworkManager.nameShared
    let tableViewCell = NameTransTableViewCell()
    
    var totalResultArray: [AResult] = []
    var aItemArray:[AItem] = []
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurationUI()
        // Do any additional setup after loading the view.
    }
    

    func configurationUI(){
        korNameTextField.delegate = self
        
        korNameTextField.keyboardType = .default
        korNameTextField.returnKeyType = .continue
        
        mainTableView.register(UINib(nibName: "NameTransTableViewCell", bundle: nil), forCellReuseIdentifier: NameTransCell.cellIdentifier)
        mainTableView.dataSource = self
    }
    
    func getDatas(korName: String){
        nameTranslateNetworkManager.fetchNameTrans(yourName: korName) { result in
            switch result {
            case .success(let array):
                print(array)
                self.totalResultArray = array
                DispatchQueue.main.async {
                    self.totalResultArray.map { result in
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
