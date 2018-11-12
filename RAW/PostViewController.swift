//
//  ViewController.swift
//  RAW
//
//  Created by Bharat malhotra on 13/07/18.
//  Copyright © 2018 Bharat malhotra. All rights reserved.
//

import UIKit

class PostViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var posts : [Posts]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        fetchDataWithAPI()
    }
    
    
    func fetchDataWithAPI(){
        WebService().getPosts(completion: {[weak self](userdata, errorMessaage) in
            guard let `self` = self else{return}
            guard errorMessaage == nil else {
                self.displayAlert(title: "Error Fetching Data", message: errorMessaage?.localizedDescription)
                return
            }
            self.posts = userdata
            self.tableView.reloadData()
        })
    }
    
    
    func displayAlert(title: String, message: String?) {
            let alert = UIAlertController(title:title, message:message, preferredStyle:.alert)
            alert.addAction(UIAlertAction.init(title:"ok", style:.cancel, handler:nil))
            self.present(alert, animated: true, completion: nil)
    }
}

extension PostViewController: UITableViewDelegate{
    
}

extension PostViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let post = posts else {
            return 0
        }
        return post.count
    }
    
    fileprivate func updatePosts(_ indexPath: IndexPath, _ cell: UITableViewCell) {
        cell.textLabel?.numberOfLines = 0
        guard let post = posts else {
            cell.textLabel?.text = "No Data"
            return
        }
        let extractedExpr: String? = post[indexPath.row].title
        if let title = extractedExpr , let id = post[indexPath.row].id{
            cell.textLabel?.text = "\(title) + \(id)"
        } else {
            cell.textLabel?.text = "No Data"
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        updatePosts(indexPath, cell)
        
        return cell
    }
}

