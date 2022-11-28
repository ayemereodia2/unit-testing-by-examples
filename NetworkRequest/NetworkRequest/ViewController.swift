//
//  ViewController.swift
//  NetworkRequest
//
//  Created by Ayemere  Odia  on 2022/11/25.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet private(set) var button: UIButton!
    private var dataTask: URLSessionDataTask?
    var session : URLSessionProtocol = URLSession.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction private func buttonTapped() {
        searchForBook(terms: "out from boneville")
        searchForBook(terms: "the great cow race")
    }

    private func searchForBook(terms: String) {
        
        guard let encodedTerms = terms.addingPercentEncoding(
            withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: "https://itunes.apple.com/search?" +
                            "media=ebook&term=\(encodedTerms)") else { return }
        
        let request = URLRequest(url: url)
        
        dataTask = session.dataTask(with: request) { [weak self] (data: Data?, response: URLResponse?, error: Error?) -> Void in
            guard let self = self else { return }
            
            let decoded = String(data: data ?? Data(), encoding: .utf8)
            
            print("response: \(String(describing: response))")
            print("data: \(String(describing: decoded))")
            print("error: \(String(describing: error))")
            
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.dataTask = nil
                self.button.isEnabled = true
            }
            
        }
        button.isEnabled = false
        dataTask?.resume()
        
    }
}

