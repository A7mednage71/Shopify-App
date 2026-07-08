//
//  SwiftUIView 2.swift
//
//
//  Created by Eyad waleed on 04/07/2026.
//

import SwiftUI
import Common

public struct AddressesView: View {
    @ObservedObject private var viewModel: AddressesViewModel
    let onAddAddress: () -> Void
    let onSelectionApplied: () -> Void
    @State private var showSnackbar = false
    @State private var snackbarMessage = ""
    @State private var showingDeleteAlert = false
    @State private var addressToDelete: AddressDomain? = nil
    
    public init(
        viewModel: AddressesViewModel,
        onAddAddress: @escaping () -> Void,
        onSelectionApplied: @escaping () -> Void = {}
    ) {
        self.viewModel = viewModel
        self.onAddAddress = onAddAddress
        self.onSelectionApplied = onSelectionApplied
    }
    
    public var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                List {
                    ForEach(viewModel.addressesList, id: \.id) { address in
                        AddressItem(
                            isSelected: Binding(
                                get: { viewModel.selectedAddressID == address.id },
                                set: { isSelected in
                                    if isSelected {
                                        viewModel.selectedAddressID = address.id
                                    }
                                }
                            ), addressItem: address
                        )
                        .onTapGesture {
                            viewModel.selectedAddressID = address.id
                        }
                        .listRowInsets(EdgeInsets(top: 6, leading: 24, bottom: 6, trailing: 24))
                        .listRowSeparator(.hidden)
                        .listRowBackground(Color.clear)
                        .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                            Button(role: .destructive) {
                                addressToDelete = address
                                showingDeleteAlert = true
                            } label: {
                                Label(L10n.Address.delete, systemImage: "trash")
                            }
                        }
                    }
                    
                    NewAddressButton(action: {
                        onAddAddress()
                    })
                    .listRowInsets(EdgeInsets(top: 10, leading: 24, bottom: 10, trailing: 24))
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.clear)
                }
                .listStyle(.plain)
                .background(Color.clear)
                .padding(.top, 12)
                
                CustomBtn(label: L10n.Address.apply, action: {
                    Task {
                        let didSaveSelection = await viewModel.saveDefaultAddressSelection()

                        if didSaveSelection {
                            triggerSnackbar(message: L10n.Address.defaultAddressUpdated)
                            onSelectionApplied()
                        }
                    }
                })
                .disabled(viewModel.isSelectionUnchanged)
                .opacity(viewModel.isSelectionUnchanged ? 0.5 : 1.0)
                .padding(.horizontal, 24)
                .padding(.bottom, 16)
            }
            
            if showSnackbar {
                VStack {
                    Spacer()
                    HStack(spacing: 12) {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(AppColors.textWhite)
                        Text(snackbarMessage)
                            .font(.subheadline)
                            .foregroundColor(AppColors.textWhite)
                            .fontWeight(.medium)
                    }
                    .padding(.vertical, 14)
                    .padding(.horizontal, 24)
                    .background(AppColors.primary)
                    .cornerRadius(25)
                    .shadow(color: AppColors.shadow.opacity(0.18), radius: 6, x: 0, y: 3)
                    .transition(.move(edge: .bottom).combined(with: .opacity))
                    .padding(.bottom, 90)
                }
                .animation(.spring(), value: showSnackbar)
            }
        }
        .background(AppColors.backgroundSecondary)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                HStack(spacing: 8) {
                    Image(systemName: "mappin.and.ellipse")
                    Text(L10n.Address.savedAddresses)
                        .font(.headline)
                        .fontWeight(.bold)
                }
                .foregroundColor(AppColors.primary)
            }
        }
        .alert(L10n.Address.deleteAddressAlert, isPresented: $showingDeleteAlert, presenting: addressToDelete) { address in
            Button(L10n.Address.delete, role: .destructive) {
                var transaction = Transaction()
                transaction.disablesAnimations = true
                
                withTransaction(transaction) {
                    Task {
                        let targetTitle = address.address1
                        await viewModel.deleteAddress(id: address.id)
                        triggerSnackbar(message: L10n.Address.removeAddressSuccess(targetTitle))
                    }
                }
            }
            Button(L10n.Address.cancel, role: .cancel) {}
        } message: { address in
            Text(L10n.Address.deleteAddressMessage(address.address1))
        }
    }
    
    private func triggerSnackbar(message: String) {
        snackbarMessage = message
        withAnimation {
            showSnackbar = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            withAnimation {
                showSnackbar = false
            }
        }
    }
}
