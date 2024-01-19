//
//  ViewController.swift
//  Parsing-JSON-USING-Bundle
//
//  Created by Nikolai Maksimov on 19.01.2024.
//

import UIKit

class ViewController: UIViewController {

    enum Section {
        case main
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    typealias DataSource = UITableViewDiffableDataSource<Section, President>
    
    private var dataSource: DataSource!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        configureDataSource()
        fetchPresidents()
    }

    private func configureDataSource() {
        dataSource = DataSource(tableView: tableView, cellProvider: { tableView, indexPath, president in
            // configure cell
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = president.name
            cell.detailTextLabel?.text = "\(president.number)"
            return cell
        })
        
        // setup initial snapshot
        var snapshot = NSDiffableDataSourceSnapshot<Section, President>()
        snapshot.appendSections([.main])
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    private func fetchPresidents() {
        var presidents: [President] = []
        do {
            presidents = try Bundle.main.parseJSON(with: "presidents")
        } catch {
            print("error: \(error)")
        }
        
        // update snapshot
        var snapshot = dataSource.snapshot()
        snapshot.appendItems(presidents, toSection: .main)
        dataSource.apply(snapshot, animatingDifferences: true)
    }


}

