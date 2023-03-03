//
//  ViewController.swift
//  fetchFreeApi
//
//  Created by Anton Honcharov on 02.03.2023.
//

import UIKit

class ViewController: UIViewController {
    // MARK: - Properties
//    var list = [String: [String]]();
    var list = [String]();
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
}

// MARK: - Lifecycle
extension ViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Dogs";
        
        setupTableView()
        fetchBreedList(from: K.urlDogs + "/breeds/list/all")
        tableView?.rowHeight = 50
    }
}


// MARK: - TableView
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DogBreedCellItem.cellID) as! DogBreedCellItem
        
        let breed = list[indexPath.row].capitalized
        cell.configure(with: breed)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard.init(name: "BreedScreen",
                                   bundle: Bundle.main).instantiateViewController(withIdentifier: "breedScreen") as? BreedScreen
        
        vc?.breedTitle = list[indexPath.row].capitalized
        self.navigationController?.pushViewController(vc!, animated: true)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

// MARK: - SetUp
extension ViewController {
    func setupTableView() {
        self.tableView?.delegate = self;
        self.tableView?.dataSource = self;
    }
}

// MARK: - Network
extension ViewController {
    func fetchBreedList(from url: String) {
        guard let url = URL(string: url) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = K.RequestMethods.GET.rawValue
        request.addValue(K.RequestHeaderValue, forHTTPHeaderField: K.RequestHeaderField)
        
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            guard let data = data else { self?.title = "No data from request"; return  }
            
            do {
                let responseModel = try JSONDecoder().decode(DogListResp.self, from: data)
                self?.list = responseModel.message.keys.map { $0 }.sorted()
                
                DispatchQueue.main.async {
                    self?.tableView?.reloadData()
                }
            } catch {
                print("🧨 Parsing response Error: \(error)")
            }
        }
        
        task.resume()
    }
}
