//
//  CountryPickerViewModel.swift
//  QklyBuyer
//
//  Created by Asmin Ghale on 2/1/23.
//

import Foundation
import SwiftUI

class CountryPickerViewModel: BaseViewModel {
    
    override init() {
        super.init()
        readLocalFile()
    }
    @Published var countries = [Country]()
    @Published var searchCountries = [Country]()
    
    private func readLocalFile() {
        guard let url = Bundle.main.url(forResource: "Countries", withExtension: "json"), let data = try? Data(contentsOf: url) else {
            assertionFailure("Unable to load countries data json")
            return
        }
        
        guard let countryData = try? JSONDecoder().decode([Country].self, from: data) else {
            assertionFailure("Decoding failed for countries data")
            return
        }
        countries = countryData
        searchCountries = countryData
    }
    
}
