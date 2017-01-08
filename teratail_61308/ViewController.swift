//
//  ViewController.swift
//  teratail_61308
//
//  Created by Kentarou on 2017/01/08.
//  Copyright © 2017年 Kentarou. All rights reserved.
//


import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var sectionTitleArray = [String]()
    var dataArrayGroup: [[DataModel]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.tableFooterView  = UIView()
    }
    
    
    @IBAction func addSection(_ sender: UIButton) {
        
        let alert = UIAlertController(title:"Sction追加",
                                      message: "SectionTitleを入力してください",
                                      preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .cancel,
                                         handler:
            { action -> Void in
                print("Cancel")
        })
        
        let defaultAction = UIAlertAction(title: "OK",
                                          style: .default,
                                          handler:
            { action -> Void in
                
                // TextFieldから値を取得
                if let textFields = alert.textFields {
                    for textField in textFields {
                        
                        if let text = textField.text, !text.isEmpty {
                            
                            // 取得したテキストをセクションのタイトルとして追加する
                            print(text)
                            
                            self.sectionTitleArray.insert(text, at: 0)
                            self.dataArrayGroup.insert([], at: 0)
                            self.tableView.insertSections(IndexSet(integer: 0), with: .automatic)
                        }
                    }
                }
        })
        
        alert.addAction(cancelAction)
        alert.addAction(defaultAction)
        alert.addTextField(configurationHandler: { text -> Void in })
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func deleteSection(_ sender: UIButton) {
        
        if sectionTitleArray.isEmpty {
            return
        }
        
        let alert = UIAlertController(title:"Sction削除",
                                      message: "削除するSectionTitleを入力してください",
                                      preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .cancel,
                                         handler:
            { action -> Void in
                print("Cancel")
        })
        
        let defaultAction = UIAlertAction(title: "OK",
                                          style: .default,
                                          handler:
            { action -> Void in
                
                // TextFieldから値を取得
                if let textFields = alert.textFields {
                    for textField in textFields {
                        
                        if let text = textField.text,
                            !text.isEmpty,
                            let index = self.sectionTitleArray.index(of: text) {
                            
                            self.sectionTitleArray.remove(at: index)
                            self.dataArrayGroup.remove(at: index)
                            self.tableView.deleteSections(IndexSet(integer: index), with: .automatic)
                        }
                    }
                }
        })
        
        alert.addAction(cancelAction)
        alert.addAction(defaultAction)
        alert.addTextField(configurationHandler: { text -> Void in })
        present(alert, animated: true, completion: nil)
    }
    
    @IBOutlet weak var deletetext: UITextField!
    
    // Rowを追加する(アニメーションはご自由に)
    @IBAction func addRow(_ sender: UIButton) {
        //func addRow() {
        
        if dataArrayGroup.count == 0 {
            return
        }
        
        let alert = UIAlertController(title:"Row追加",
                                      message: "個数と金額を入力してください",
                                      preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .cancel,
                                         handler:
            { action -> Void in
                print("Cancel")
        })
        
        let count = dataArrayGroup[0].count
        let defaultAction = UIAlertAction(title: "OK",
                                          style: .default,
                                          handler:
            { action -> Void in
                
                // TextFieldから値を取得
                if let textFields = alert.textFields {
                    
                    let data = DataModel()
                    
                    for textField in textFields {
                        
                        if let text = textField.text, !text.isEmpty, let _ = Int(text) {
                            if textField.tag == 1 {
                                data.count = text
                            } else {
                                data.price = text
                            }
                        }
                    }
                    
                    self.dataArrayGroup[0].insert(data, at: count)
                    self.tableView.insertRows(at: [IndexPath(row: count, section: 0)], with: .automatic)
                }
        })
        
        
        alert.addTextField {
            $0.placeholder = "個数"
            $0.keyboardType = .numberPad
            $0.tag = 1
        }
        alert.addTextField {
            $0.placeholder = "金額"
            $0.keyboardType = .numberPad
            $0.tag = 2
        }
        
        alert.addAction(cancelAction)
        alert.addAction(defaultAction)
        present(alert, animated: true, completion: nil)
    }
    
    
    
    // MARK: - TableView Delegate & DataSource
    //この部分です。
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if sectionTitleArray.count == 0 {
            return nil
        } else {
            return sectionTitleArray[section]
        }
    }
    
    // Section Count
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataArrayGroup.count
    }
    
    // Row Count
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArrayGroup[section].count
    }
    
    // Generate Cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! CustomCell
        cell.data = dataArrayGroup[indexPath.section][indexPath.row]
        cell.indexLabel.text = String(indexPath.row + 1)
        return cell
    }
    
    // Select Cell
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            dataArrayGroup[indexPath.section].remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
        }
    }
    
    //cellが削除が可能なことを伝える
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return UITableViewCellEditingStyle.delete;
    }
}
