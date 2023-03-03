//
//  BreedScreen.swift
//  fetchFreeApi
//
//  Created by Anton Honcharov on 02.03.2023.
//

import UIKit


class BreedScreen: ViewController {
    // MARK: - Props
    var breedTitle: String?
    var breedURL: String?
    
    @IBOutlet weak var breedImage: UIImageView!
    @IBOutlet weak var refreshButton: UIButton!

}

// MARK: - Lifecycle
extension BreedScreen {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        config(with: breedTitle)
    }
}

// MARK: - Setup
extension BreedScreen {
    func config(with title: String?) {
        guard let title = breedTitle else { return }
        self.title = title
        
        getDogImageURL(from: K.urlDogs + "/breed/\(title.lowercased())/images/random")
    }
}

// MARK: - Actions
extension BreedScreen {
    @IBAction func handleRefreshImageButton(_ sender: UIButton) {
        getDogImageURL(from: K.urlDogs + "/breed/\(breedTitle!.lowercased())/images/random")
    }
}

// MARK: - Network
extension BreedScreen {
    func getDogImageURL(from url: String) {
        guard let url = URL(string: url) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = K.RequestMethods.GET.rawValue
        request.addValue(K.RequestHeaderValue, forHTTPHeaderField: K.RequestHeaderField)
        
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            guard let data = data else { self?.title = "No data from request"; return  }
            
            do {
                let responseModel = try JSONDecoder().decode(DogImage.self, from: data)

                self?.breedURL = responseModel.message
                
                DispatchQueue.main.async {
                    self?.breedImage.load(from: responseModel.message)
                    self?.view?.setNeedsLayout()
                }
            } catch {
                print("🧨 Parsing response Error: \(error)")
            }
        }
        
        task.resume()
    }
}
