//
//  ViewController.swift
//  Lab
//
//  Created by Roberto Evangelista da Silva Filho on 13/12/2018.
//  Copyright © 2018 Roberto Evangelista da Silva Filho. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    

    @IBOutlet weak var myTableView: UITableView!
    
//    let apiURL = "https://api.themoviedb.org/3"
//    let apiKey = "0424fa87b82e17923e0bf89b143c6fb2"
    let networkHelper = NetworkHelper()
    var search: String = "hugh"
    var searchActors: [Actor]?  {
        didSet {
            myTableView.reloadData()
        }
    }
    
    func searchActorRequest() {
        let searchRequest = "/search/person"
        let myQueryItems = [
            "api_key": networkHelper.apiKey,
            "query": search
        ]
        var urlComponents = URLComponents(string: networkHelper.apiURL + searchRequest)
        urlComponents?.queryItems = networkHelper.queryItems(dictionary: myQueryItems)
        print(urlComponents!)
        
        let task = URLSession.shared.dataTask(with: urlComponents!.url!) { (data, response, error) in
            guard let dataResponse = data,
                error == nil else {
                    print("Error")
                    return
            }
            do {
                let decode = try JSONDecoder().decode(SearchResponse.self, from: dataResponse)
                DispatchQueue.main.async {
                    guard let results = decode.results else {
                        return
                    }
                    
                    self.searchActors = results
                }
            } catch let parsinError {
                print("Error", parsinError)
            }
        }
        task.resume()
    }
    
    
    
//    func queryItems(dictionary: [String: String]) -> [URLQueryItem] {
//        return dictionary.map {
//            return URLQueryItem(name: $0, value: $1)
//        }
//    }

    override func viewDidLoad() {
        super.viewDidLoad()
        myTableView.delegate = self
        myTableView.dataSource = self
        searchActorRequest()
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchActors?.count ?? 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "actorCell", for: indexPath)
        cell.textLabel?.text = searchActors![indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let actor = searchActors![indexPath.row]
        performSegue(withIdentifier: "selectActorSegue", sender: actor)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? ActorDetailsViewController {
            controller.selectedActor = sender as? Actor
        }
    }
}
