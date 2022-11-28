//
//  ViewController.swift
//  NetworkResponse
//
//  Created by Ayemere  Odia  on 2022/11/28.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet private(set) var button: UIButton!
    private var dataTask: URLSessionDataTask?
    var session: URLSessionProtocol = URLSession.shared
    var handleResults: ([SearchResult]) -> Void = { print($0) }
    
    private(set) var results : [SearchResult] = [] {
        didSet {
            handleResults(results)
        }
    }
    
    @IBAction private func buttonTapped() {
        searchForBook(terms: "out from boneville")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    private func searchForBook(terms: String) {
        guard let encodedTerms = terms.addingPercentEncoding(
            withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: "https://itunes.apple.com/search?" +
                            "media=ebook&term=\(encodedTerms)") else { return }
        let request = URLRequest(url: url)
        
        dataTask = session.dataTask(with: request) {
            [weak self] (data: Data?, response: URLResponse?, error: Error?)
            -> Void in
            guard let self = self else { return }
            
            let decoded2 = String(data: data ?? Data(), encoding: .utf8)
            
            print("response: \(String(describing: response))")
            print("data: \(String(describing: decoded2))")
            print("error: \(String(describing: error))")
            
            
            var decoded: Search?
            var errorMessage: String?
            
            if let error = error {
                errorMessage = error.localizedDescription
            } else if let response = response as? HTTPURLResponse,
                      response.statusCode != 200 {
                
                errorMessage = "Response:" + HTTPURLResponse.localizedString(forStatusCode: response.statusCode)
            } else if let data = data {
                do {
                    decoded = try JSONDecoder().decode(Search.self, from: data)
                } catch {
                    errorMessage = error.localizedDescription
                }
            }
            
            
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                
                if let decoded = decoded {
                    self.results = decoded.results
                }
                
                if let errorMessage = errorMessage {
                    self.showError(errorMessage)
                }
                
                self.dataTask = nil
                self.button.isEnabled = true
            }
        }
        
        button.isEnabled = false
        dataTask?.resume()
    }

}

extension ViewController {
    private func showError(_ message: String) {
        let title = "Network problem"
        print("\(title): \(message)")
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        alert.preferredAction = okAction
        present(alert, animated: true)
    }
}


protocol URLSessionProtocol {
    func dataTask(with request: URLRequest,completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void ) -> URLSessionDataTask
}
extension URLSession: URLSessionProtocol {}

struct Search: Decodable {
    let results: [SearchResult]
}

struct SearchResult: Decodable, Equatable {
    let artistName: String
    let trackName: String
    let averageUserRating: Float?
    let description: String
    let genres: [String]
}
