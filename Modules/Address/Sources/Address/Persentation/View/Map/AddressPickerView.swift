//
//  SwiftUIView.swift
//  
//
//  Created by Eyad waleed on 05/07/2026.
//

import SwiftUI
import MapKit
import Common


@available(iOS 16.0, *)
public struct AddressPickerView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var mapViewModel = MapViewModel()
    @StateObject private var pickerViewModel = AddressPickerViewModel()
    @StateObject private var searchViewModel = LocationSearchViewModel()
    @FocusState private var searchFieldFocused: Bool
    let onAddressConfirmed: (SelectedAddress) -> Void

       init(onAddressConfirmed: @escaping (SelectedAddress) -> Void) {
          self.onAddressConfirmed = onAddressConfirmed
      }
   public  var body: some View {
        ZStack(alignment: .top) {
            TapToPlacePinMapView(
                region: $mapViewModel.region,
                pinCoordinate: $pickerViewModel.pinCoordinate,
                onPinMoved: { coordinate in
                    pickerViewModel.pinDidMove(to: coordinate)
                }
            )
            .ignoresSafeArea()
            .onAppear { mapViewModel.checkIfLocationServicesIsEnabled() }
            .onChange(of: mapViewModel.authorizationStatus) { newStatus in
                if newStatus == .authorizedWhenInUse || newStatus == .authorizedAlways,
                   let userCoordinate = mapViewModel.userCoordinate {
                    pickerViewModel.autoOpenForUserLocation(userCoordinate)
                }
            }

            VStack(spacing: 8) {
                searchBar
                if searchFieldFocused && !searchViewModel.results.isEmpty {
                    suggestionsList
                }
            }
            .padding(.horizontal)
            .padding(.top, 12)

            VStack {
                Spacer()
                confirmButton
                    .padding(.bottom, 32)
            }
        }
        .sheet(isPresented: $pickerViewModel.isConfirmSheetPresented) {
            AddressConfirmationForm(
                address: $pickerViewModel.selectedAddress,
                onAddAddress: { address in
                    onAddressConfirmed(address)
//                    dismiss()
                }
            )
            .presentationDetents([.medium])
            .presentationDragIndicator(.visible)
        }
    }

    private var searchBar: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(AppColors.secondary)
            TextField("Search for an address", text: $searchViewModel.query)
                .focused($searchFieldFocused)
                .font(AppFonts.body)
        }
        .padding(10)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 3)
    }

    private var suggestionsList: some View {
        VStack(alignment: .leading, spacing: 0) {
            ForEach(searchViewModel.results, id: \.self) { completion in
                Button {
                    Task { await selectCompletion(completion) }
                } label: {
                    VStack(alignment: .leading, spacing: 2) {
                        Text(completion.title).font(AppFonts.body)
                        Text(completion.subtitle)
                            .font(AppFonts.caption)
                            .foregroundColor(.gray)
                    }
                    .padding(.vertical, 6)
                    .padding(.horizontal, 10)
                }
                Divider()
            }
        }
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 3)
    }

    private var confirmButton: some View {
        Button {
            pickerViewModel.confirmLocation()
        } label: {
            HStack(spacing: 8) {
                if pickerViewModel.isResolvingAddress {
                    ProgressView().tint(.white)
                }
                Text(pickerViewModel.isResolvingAddress ? "Locating..." : "Confirm Location")
                    .font(AppFonts.body)
            }
            .foregroundColor(.white)
            .padding(.vertical, 14)
            .padding(.horizontal, 32)
            .background(AppColors.primary)
            .cornerRadius(12)
        }
        .disabled(pickerViewModel.isResolvingAddress)
    }

    private func selectCompletion(_ completion: MKLocalSearchCompletion) async {
        guard let coordinate = await searchViewModel.resolveCoordinate(for: completion) else { return }
        pickerViewModel.pinCoordinate = coordinate
        mapViewModel.region = MKCoordinateRegion(
            center: coordinate,
            span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        )
        searchViewModel.query = completion.title
        searchFieldFocused = false
    }
}


