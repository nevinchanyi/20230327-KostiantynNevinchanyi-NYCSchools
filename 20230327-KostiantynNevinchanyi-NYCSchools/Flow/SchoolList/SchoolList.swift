//
//  SchoolListView.swift
//  20230327-KostiantynNevinchanyi-NYCSchools
//
//  Created by Kostiantyn Nevinchanyi on 3/27/23.
//

import SwiftUI

struct SchoolListView: View {
    
    @StateObject
    private var viewModel = SchoolListViewModel()
    
    var body: some View {
        List {
            if viewModel.isLoading {
                ProgressView()
            } else if !viewModel.isLoading && !viewModel.errorText.isEmpty {
                Section {
                    Text("Oops, we can't load data.")
                        .foregroundColor(.pink)
                    Text(viewModel.errorText)
                }
                
                Section {
                    Button {
                        viewModel.loadData()
                    } label: {
                        Text("Reload")
                    }
                }
            } else {
                ForEach(viewModel.schools) { school in
                    NavigationLink {
                        SchoolDetailView(
                            viewModel: SchoolDetailViewModel(school: school))
                    } label: {
                        Text(school.schoolName)
                    }
                }
            }

        }
        .listStyle(.insetGrouped)
        .navigationTitle("NYC Schools")
    }
}

struct SchoolListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SchoolListView()
        }
    }
}
