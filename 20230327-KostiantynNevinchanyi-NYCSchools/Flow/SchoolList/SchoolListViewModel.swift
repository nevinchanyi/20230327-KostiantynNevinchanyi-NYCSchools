//
//  SchoolListViewModel.swift
//  20230327-KostiantynNevinchanyi-NYCSchools
//
//  Created by Kostiantyn Nevinchanyi on 3/27/23.
//

import SwiftUI


final class SchoolListViewModel: ObservableObject {
    
    let networkService: NetworkService
    
    @Published
    var isLoading = false
    
    @Published
    var errorText = String()
    
    @Published
    var schools = [SchoolModel]()
    
    init(networkService: NetworkService = NetworkService()) {
        self.networkService = networkService
        loadData()
    }
    
    func loadData() {
        Task {
            await showAnimation(true)
            await MainActor.run {
                errorText = String()
            }
            do {
                let sats: [SatModel] = try await networkService.request(endpoint: Endpoint.sats)
                var fetchedSchools: [SchoolModel] = try await networkService.request(endpoint: Endpoint.schools)
                
                for school in fetchedSchools {
                    if let index = fetchedSchools.firstIndex(where: { $0.dbn == school.dbn }),
                       let sat = sats.first(where: { $0.dbn == school.dbn }) {
                        fetchedSchools[index].set(sat: sat)
                    }
                }
                
                await set(schools: fetchedSchools)
                await showAnimation(false)
            } catch {
                await MainActor.run {
                    errorText = error.localizedDescription
                }
                await showAnimation(false)
            }
        }
    }
    
    @MainActor
    private func showAnimation(_ show: Bool) async {
        withAnimation(.spring()) {
            isLoading = show
        }
    }
    
    @MainActor
    private func set(schools: [SchoolModel]) async {
        self.schools = schools
    }
    
}
