//
//  File.swift
//  
//
//  Created by Eyad waleed on 05/07/2026.
//

import Foundation
import CoreLocation
import Combine

@MainActor
class AddressPickerViewModel: ObservableObject {
    @Published var pinCoordinate = CLLocationCoordinate2D(
        latitude: 30.0626, longitude: 31.2497
    )
    @Published var selectedAddress = SelectedAddress()
    @Published var isConfirmSheetPresented = false
    @Published var isResolvingAddress = false

    private let geocoder = CLGeocoder()
    private var hasAutoOpenedForUserLocation = false

    func pinDidMove(to coordinate: CLLocationCoordinate2D) {
        pinCoordinate = coordinate
    }

  
    func confirmLocation() {
        resolveAndPresent(coordinate: pinCoordinate)
    }

    
    func autoOpenForUserLocation(_ coordinate: CLLocationCoordinate2D) {
        guard !hasAutoOpenedForUserLocation else { return }
        hasAutoOpenedForUserLocation = true
        pinCoordinate = coordinate
        resolveAndPresent(coordinate: coordinate)
    }

    private func resolveAndPresent(coordinate: CLLocationCoordinate2D) {
        isResolvingAddress = true
        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)

        geocoder.reverseGeocodeLocation(location) { [weak self] placemarks, error in
            guard let self else { return }
            Task { @MainActor in
                self.isResolvingAddress = false

                if let error {
                    print("Reverse geocode failed: \(error.localizedDescription)")
                    return
                }
                guard let placemark = placemarks?.first else { return }

                let fullAddress = [
                    placemark.name,
                    placemark.locality,
                    placemark.administrativeArea
                ].compactMap { $0 }.joined(separator: ", ")

                self.selectedAddress = SelectedAddress(
                    fullAddress: fullAddress,
                    zipCode: placemark.postalCode ?? "",
                    country: placemark.country ?? "",
                    city:  placemark.locality ?? "",
                    coordinate: coordinate
                )
                self.isConfirmSheetPresented = true
            }
        }
    }
}
