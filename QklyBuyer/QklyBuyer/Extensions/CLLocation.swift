//
//  CLLocation.swift
//  Qkly
//
//  Created by Asmin Ghale on 9/16/22.
//

import CoreLocation

extension CLLocation {
    func fetchCityAndCountry(completion: @escaping (_ city: String?,  _ country:  String?, _ error: Error?) -> ()) {
        CLGeocoder().reverseGeocodeLocation(self) { completion($0?.first?.locality, $0?.first?.country, $1) }
    }
}
