//
//  StationViewController.swift
//  Parsing-JSON-Using-URLSession
//
//  Created by Nikolai Maksimov on 18.01.2024.
//

import UIKit

class StationViewController: UIViewController {
    
    enum Section {
        case primary
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    private var dataSource: DataSource!
    
    let apiClient = APIClient()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    private func configure() {
        navigationItem.title = "Citi Bike Stations"
        configureDataSource()
        fetchData()
    }
    
    private func fetchData() {
        // Results types has two values
        // 1. .failure() or 2. .success()
        apiClient.fetchData { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .failure(let appError):
                print(appError)
            case .success(let stations):
                DispatchQueue.main.async {
                    self.updateSnapshot(with: stations)
                }
            }
        }
    }
    
    private func updateSnapshot(with stations: [Station]) {
        var snapshot = dataSource.snapshot()
        snapshot.appendItems(stations, toSection: .primary)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    private func configureDataSource() {
        dataSource = DataSource(tableView: tableView, cellProvider: { tableView, indexPath, station in
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = station.name
            cell.detailTextLabel?.text = "Bike Capacity: \(station.capacity)"
            return cell
        })
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, Station>()
        snapshot.appendSections([.primary])
        dataSource.apply(snapshot, animatingDifferences: false)
    }
}

// TODO: продолжить реализацию, чтобы отображались заголовки заголовков разделов
class DataSource: UITableViewDiffableDataSource<StationViewController.Section, Station> {
    // реализовать методы UITableViewDataSource здесь
}

