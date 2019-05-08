//
//  ListViewController.swift
//  Proteins
//
//  Created by Rapula MAAKE on 2018/11/20.
//  Copyright © 2018 Rapula MAAKE. All rights reserved.
//

import UIKit

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var list: [Substring] = []
    var subList: [Substring] = []
    var isSearching = false
    override func viewDidLoad() {
        super.viewDidLoad()
        self.stackView.isHidden = true
        self.activityIndicator.startAnimating()
        self.download()
        
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (self.isSearching == true)
        {
            return self.subList.count
        }
        return self.list.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "protein", for: indexPath) as! ProteinTableViewCell
        cell.displayData(view: self, index: indexPath.row)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "model")
        {
            let vc = segue.destination as? ProteinViewController
            let obj = sender as! ProteinTableViewCell
            vc?.name = obj.proteinLabel.text
        }
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if (searchBar.text == nil || searchBar.text == "")
        {
            self.isSearching = false
            //view.endEditing(true)
            self.tableView.reloadData()
        }
        else
        {
            self.isSearching = true
            self.subList = self.list.filter({
                let v = $0.lowercased()
                if v.hasPrefix(searchText.lowercased()) == true
                {
                    return true
                }
                else
                {
                    return false
                }
                
            })
            self.tableView.reloadData()
        }
    }
    func download()
    {
        let url = URL(string: "https://projects.intra.42.fr/uploads/document/document/312/ligands.txt")
        
        URLSession.shared.dataTask(with: url!, completionHandler: {(data:Data?, resp: URLResponse?, err: Error?) -> Void in
            if let data = data
            {
                let dat = String(data: data, encoding: String.Encoding.utf8)!
                self.list = dat.split(separator: "\n")
                DispatchQueue.main.async {
                    self.stackView.isHidden = false;
                    self.activityIndicator.stopAnimating()
                    self.activityIndicator.isHidden = true
                    self.tableView.reloadData()
                }
            }
            else
            {
                ViewController.displayMessage(title: "Error", msg: "Failed to download file.\nReason: " + (err?.localizedDescription)!, view: self);
            }
        }).resume()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
