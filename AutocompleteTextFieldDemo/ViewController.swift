//
//  ViewController.swift
//  AutocompleteTextFieldDemo
//
//  Created by Yogesh Rathore on 17/05/17.
//  Copyright © 2017 Sybrant Technologies. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var SearchTxt: UITextField!
    var search:String=""
    
    @IBOutlet weak var ShowLbl: UILabel!
    @IBOutlet var ListTable: UITableView!
    var AllData:Array<Dictionary<String,String>> = []
    var SearchData:Array<Dictionary<String,String>> = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        AllData = [["name":"Dubai"],
                   ["name":"Dubai Marina"],
                   ["name":"India"],
                   ["name":"USA"],
                   ["name":"Pakistan"],
                   ["name":"China"],
                   ["name":"Danmark"],
                   ["name":"Dubai Media city"],
                   ["name":"Dubmesh"]]
            
        
        ListTable.isHidden = true
      // AllData = sorted(AllData)
      
        SearchData=AllData
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        ListTable.isHidden = false
        if string.isEmpty
        {
           
            search = String(search.characters.dropLast())
        }
        else
        {
            
            search=textField.text!+string
        }
        
        print(search)
        let predicate=NSPredicate(format: "SELF.name CONTAINS[cd] %@", search)
        let arr=(AllData as NSArray).filtered(using: predicate)
        
        if arr.count > 0
        {
            ListTable.isHidden = false
            SearchData.removeAll(keepingCapacity: true)
            SearchData=arr as! Array<Dictionary<String,String>>
        }
        else
        {
            ListTable.isHidden = true
            SearchData=AllData
        }
        ListTable.reloadData()
        return true
    }
    
    
   
   // Search data display in tableview :
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return SearchData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell")
        
        var Data:Dictionary<String,String> = SearchData[indexPath.row]
        
        cell?.textLabel?.text = Data["name"]
    
    
        cell?.selectionStyle = .none
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var Data:Dictionary<String,String> = SearchData[indexPath.row]
        
        SearchTxt.text = Data["name"]
        ListTable.isHidden = true
        ShowLbl.text = SearchTxt.text
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.tag == 0 {
            textField.resignFirstResponder()
            ShowLbl.text = SearchTxt.text
            ListTable.isHidden = true
           
        }
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

