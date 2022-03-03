//
//  LocationsViewController.swift
//  Rick&Morty
//
//  Created by Salih Topcu on 10.02.2022.
//

import UIKit
import Combine

class LocationsViewController: UIViewController {
    
    @IBOutlet weak var locationsTableView: UITableView!
    
    var viewModel = LocationsViewModel()
    var subscriptions = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.locationsTableView.accessibilityContainerType = .dataTable
        
        viewModel.$locationModels
            .receive(on: DispatchQueue.main)
            .sink { [weak self] items in
                self?.locationsTableView.reloadData()
            }
            .store(in: &subscriptions)
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

extension LocationsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.locationModels?.count ?? 0
    }
    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = LocationCell(style: .value1, reuseIdentifier: "LocationCell")
//        if let location = self.list?.results[indexPath.row] {
//            cell.textLabel?.text = location.name
//            if let residentsCount = location.residents?.count {
//                cell.detailTextLabel?.text = "\(residentsCount)"
//            }
//        }
//        return cell
//    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LocationCell2", for: indexPath) as! LocationTableViewCell
        if let locationViewModel = self.viewModel.locationModels?[indexPath.row] {
            cell.use(locationViewModel)
        }
        return cell
    }
}

extension LocationsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let locationViewModel = viewModel.locationModels![indexPath.row]
        debugPrint("SELECTED:", locationViewModel.location.name)
//        let vc = UIStoryboard(name: "Main", bundle: nil)
//            .instantiateViewController(withIdentifier: "CharactersViewController") as! CharactersViewController
//        vc.location = locationViewModel.location
//        navigationController?.pushViewController(vc, animated: true)
    }
}
