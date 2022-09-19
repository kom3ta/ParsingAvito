//
//  ViewController.swift
//  ParsingAvito
//
//  Created by Владимир Мирошин on 11.07.2022.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var company: Company?
    var root: Root? {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    private let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(UITableViewCell.self,
        forCellReuseIdentifier: "cell")
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.delegate = self
        tableView.dataSource = self
        
        let urlString = "https://run.mocky.io/v3/1d1cb4ec-73db-4762-8c4b-0b8aa3cecd4c"
        
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error)
                return
            }
            
            guard let data = data else { return }
            do{
                let decoder = JSONDecoder()
                let root = try decoder.decode(Root.self, from: data)
                print(root.company.employees.count)
                self.root = root
            }catch{
                print(error)
            }
        }.resume()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return root?.company.employees.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return root?.company.employees[section].nameEmployee
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.textColor = UIColor.black
        header.textLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        header.textLabel?.frame = header.bounds
        header.textLabel?.textAlignment = .left
    }
    

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let person = root?.company.employees[indexPath.section]
        if indexPath.row == 0 {
            cell.textLabel?.text = "Phone number: \(person?.phoneNumber ?? "")"
        } else {
            cell.textLabel?.text = "Skills: \(person?.skills.joined(separator: ", ") ?? "")"
        }
        return cell
    }
}


//https://github.com/avito-tech/ios-trainee-problem-2021
//https://www.youtube.com/watch?v=xstqlNCOZT8
