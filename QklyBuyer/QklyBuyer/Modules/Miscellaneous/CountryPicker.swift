//
//  CountryPicker.swift
//  QklyBuyer
//
//  Created by Asmin Ghale on 1/31/23.
//

import SwiftUI

struct CountryPicker: View {
    
    typealias CountrySelectionClosure = ((_ country: Country?)->())
    
    var viewModel = CountryPickerViewModel()
    
    @State var searchboxText: String = ""
    
    var countrySelected: CountrySelectionClosure?
    
    var body: some View {
        VStack {
            titleText
            searchBox
            list
            dismissButton
        }.padding(EdgeInsets(top: 20.0, leading: 20.0, bottom: 20.0, trailing: 20.0))
        
    }
    
    var titleText: some View {
        Text("Select Country")
            .font(Font(UIFont.appFont(ofSize: .size_16, weight: .bold)))
            .padding()
    }
    
    var searchBox: some View {
       // Form {
            HStack {
                Image("search").frame(width: 35.0)
                TextField("Search here...", text: $searchboxText.onChange(searchValueChanged))
                    .cornerRadius(6.0)
                    .font(Font(UIFont.appFont(ofSize: .size_16, weight: .regular)))
                    .frame(height: 20.0)
            }
            .padding()
            .background(Color(uiColor: UIColor(rgb: 0xF7F8F9)))
            .cornerRadius(8.0)
    //    }
    }
    
    var list: some View {
        List(viewModel.searchCountries){ country in
            CountryCell(countryName: country.name).onTapGesture {
                self.countrySelected?(country)
            }
        }
        .background(Color.white)
        .scrollContentBackground(.hidden)
        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
    }
    
    var dismissButton: some View {
        Button("Dismiss") {
            self.countrySelected?(nil)
        }
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 8)
            .frame(height: 48)
            .foregroundColor(Color(uiColor: .app_primary_black!))
            .background(Color(uiColor: .app_primary_black_0_1!))
            .cornerRadius(4)
            .font(Font(UIFont.appFont(ofSize: .size_16, weight: .medium)))
    }
    
    func searchValueChanged(to value: String) {
        if value == "" {
            viewModel.searchCountries = viewModel.countries
            return
        }
        viewModel.searchCountries = viewModel.countries.filter({$0.name.lowercased().contains(value.lowercased())})
    }
    
}

struct CountryCell: View {
    
    @State var countryName: String
    
    var body: some View {
        Text(countryName)
            .font(Font(UIFont.appFont(ofSize: .size_16, weight: .medium)))
            .foregroundColor(Color(uiColor: .app_primary_black!))
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 10))
            .frame(height: 24.0)
    }
    
}

struct CountryPicker_Previews: PreviewProvider {
    static var previews: some View {
        CountryPicker()
    }
}

struct Country: Identifiable, Codable {
    let id: UUID
    let name: String
    let prefix: String
    let code: String
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = UUID()
        self.name = try container.decode(String.self, forKey: .name)
        self.prefix = try container.decode(String.self, forKey: .prefix)
        self.code = try container.decode(String.self, forKey: .code)
    }
}

extension Binding {
    func onChange(_ handler: @escaping (Value) -> Void) -> Binding<Value> {
        Binding(
            get: { self.wrappedValue },
            set: { newValue in
                self.wrappedValue = newValue
                handler(newValue)
            }
        )
    }
}
