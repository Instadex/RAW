//
//  ViewController.swift
//  RAW
//
//  Created by Bharat malhotra on 13/07/18.
//  Copyright © 2018 Bharat malhotra. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var posts : [PostModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        fetchDataWithAPI()
    }
    
    func fetchDataWithAPI(){
        WebService().fetchRawData(sucess:{[weak self](userData) in
            DispatchQueue.main.async {[weak self] () -> Void in
                guard let `self` = self else {return}
                self.posts = userData
                self.tableView.reloadData()
            }
            }, failure:{[weak self](error) in
                guard let `self` = self else {return}
                let alert = UIAlertController(title:"Alert", message:error, preferredStyle:.alert)
                alert.addAction(UIAlertAction.init(title:"ok", style:.cancel, handler:nil))
                self.present(alert, animated: true, completion: nil)
        })
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    fileprivate func updateCelldata(_ indexPath: IndexPath, _ cell: UITableViewCell) {
         cell.textLabel?.numberOfLines = 0
        let extractedExpr: String? = posts[indexPath.row].title
        if let title = extractedExpr , let id = posts[indexPath.row].id{
            cell.textLabel?.text = "\(title) + \(id)"
        }else{
            cell.textLabel?.text = "No Data"
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        updateCelldata(indexPath, cell)
        
        return cell
        
    }
    
}

