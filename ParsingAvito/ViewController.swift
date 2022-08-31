//
//  ViewController.swift
//  ParsingAvito
//
//  Created by Владимир Мирошин on 11.07.2022.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var company: Company?
    var root: Root?
    
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
            }catch{
                print(error)
            }
        }.resume()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return root?.company.employees.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return root?.company.employees[section].nameEmployee
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let company = company {
            return company.employees.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let text = root?.company.employees[indexPath.item].nameEmployee
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = text
        return cell
    }
}


//https://github.com/avito-tech/ios-trainee-problem-2021
//https://www.youtube.com/watch?v=xstqlNCOZT8
