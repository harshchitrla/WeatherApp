//
//  WeatherViewController+UISearch.swift
//  SampleWeatherApp
//
//  Created by Harsh Chitrala on 13/09/24.
//

import Foundation
import UIKit

// MARK: - UISearchResultsUpdating Delegate
extension WeatherViewController: UISearchResultsUpdating {
    
    // Adding debounce to the search request.As of now added debounce logic, if I had more time I would have created a generic class and updated method 
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text, searchText.isEmpty == false else { return }
         //Invalidate and reinitiate
         self.searchTask?.cancel()
         let task = DispatchWorkItem { [weak self] in
             //Use search text and perform the query
             DispatchQueue.main.async {
                 self?.viewModel.getWeatherDataForCity(searchText)
             }
         }
         self.searchTask = task
         //2 is the wait or idle time for execution of the function
         DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2, execute: task)
    }
}
