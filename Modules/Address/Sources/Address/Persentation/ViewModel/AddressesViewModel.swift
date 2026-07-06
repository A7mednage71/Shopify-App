//
//  File.swift
//  
//
//  Created by Eyad waleed on 04/07/2026.
//

import Foundation
import Combine
@MainActor
public final class AddressesViewModel:  ObservableObject {
    
    private let getAllAddressesUseCase: GetAllAddressesUseCase
    private let setDefaultAddressUseCase: SetDefaultAddressUseCase
    private let deleteAddressUseCase: DeleteAddressUseCase
    private let  createAddressUseCase : CreateAddressUseCase
    private let getUserName :
    GetCustomerNameUseCase
    @Published public private(set) var state: AddressesViewState = .initialState
    @Published public private(set) var addressesList: [AddressDomain] = []
    

    @Published public var selectedAddressID: String? = nil
    @Published public var initialAddressID: String? = nil
    
    private var cancellables = Set<AnyCancellable>()
    
    public init(
        getAllAddressesUseCase: GetAllAddressesUseCase,
        setDefaultAddressUseCase: SetDefaultAddressUseCase,
        deleteAddressUseCase: DeleteAddressUseCase ,
        createAddressUseCase : CreateAddressUseCase,
        getUserName : GetCustomerNameUseCase
    ) {
        self.getAllAddressesUseCase = getAllAddressesUseCase
        self.setDefaultAddressUseCase = setDefaultAddressUseCase
        self.deleteAddressUseCase = deleteAddressUseCase
        self.createAddressUseCase = createAddressUseCase
        self.getUserName = getUserName
    }
    
    
   
    public func fetchAddresses() async {
        state = .loading
        
        do {
                    let (defaultAddress, others) = try await getAllAddressesUseCase.execute()
                    
                    self.addressesList = others
            
            if(!defaultAddress.id.isEmpty){
                print("I'm not empty")
                addressesList.insert(defaultAddress, at: 0)
            }
                    self.selectedAddressID = defaultAddress.id
                    self.initialAddressID = self.selectedAddressID
                    state = .addressFetched
        } catch {
            print("InValidError in ViewModel \(error.localizedDescription)")

            handle(error: error)
        }
    }
    
  
    public func saveDefaultAddressSelection() async {
        guard let currentSelection = selectedAddressID else { return }
        state = .loading
        
        do {
            try await setDefaultAddressUseCase.execute(addressId: currentSelection)
            self.initialAddressID = currentSelection
            self.selectedAddressID = currentSelection
            state = .addressFetched
        } catch {
            handle(error: error)
        }
    }
    

    public func deleteAddress(id: String) async {
        do {
            self.addressesList.removeAll { $0.id == id }

            try await deleteAddressUseCase.execute(id: id)
            
            if addressesList.isEmpty {
                state = .NoAddressProvided
                selectedAddressID = nil
                initialAddressID = nil
                return
            }
        
        } catch {
             handle(error: error)
          }
    }
     func createNewAddress(from selected: SelectedAddress) async {
        let wasEmpty = addressesList.isEmpty
        state = .loading
        do {
            let (firstName,lastName) = try await fetchUserName()
           let newAddress = AddressDomain(
               id : "",
               address1: selected.fullAddress,
               address2: "",
               city: selected.city,
               province: "", zip: selected.zipCode,
               country: selected.country,
               firstName: firstName,
               lastName: lastName,
               phone: ""
           )
            state = .loading
            
            let created = try await createAddressUseCase.execute(address: newAddress)
            addressesList.append(created)
             print("is it empty check \(wasEmpty)")
            if wasEmpty {
                try await setDefaultAddressUseCase.execute(addressId: created.id)
                selectedAddressID = created.id
                initialAddressID = created.id
            }

            state = .addressFetched
        } catch {
            state = wasEmpty ? .NoAddressProvided : .addressFetched
        }
    }

    private func fetchUserName() async throws -> (firstName: String, lastName: String) {
        let profile = try await getUserName.execute()
        return (firstName: profile.firstName ?? "", lastName: profile.lastName ?? "")
    }

 
    public var isSelectionUnchanged: Bool {
        selectedAddressID == initialAddressID
    }
    
    private func handle(error: Error) {
        guard let addressError = error as? AddressError else {
          
            state = .NoAddressProvided
            return
        }
        
        switch addressError {
        case .notFound, .emptyAddresses:
            state = .NoAddressProvided
            
        case .unauthorized:
            state = .NoAddressProvided
            
        case .networkError:
            state = .networkProblem
            
        case .invalidInput:
            print("InValidError")
            state = .unKnownError
        case .unknown:
            print("Unkown")
            state = .unKnownError
        }
    }

}
