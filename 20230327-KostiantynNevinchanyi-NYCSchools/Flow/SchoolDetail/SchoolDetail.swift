//
//  SchoolDetailView.swift
//  20230327-KostiantynNevinchanyi-NYCSchools
//
//  Created by Kostiantyn Nevinchanyi on 3/27/23.
//

import SwiftUI

struct SchoolDetailView: View {
    
    @StateObject var viewModel: SchoolDetailViewModel
    
    var body: some View {
        ScrollView {
            Text(viewModel.school.schoolName)
                .font(.title)
                .bold()
            Text(viewModel.school.overviewParagraph ?? "")
            
            HStack {
                if let phoneNumber = viewModel.school.phoneNumber,
                    let url = URL(string: "tel://" + phoneNumber) {
                    QuickActionButton(type: .phone) {
                        UIApplication.shared.open(url)
                    }
                }
                
                if let schoolEmailUrl = viewModel.school.emailURL,
                   UIApplication.shared.canOpenURL(schoolEmailUrl) {
                    QuickActionButton(type: .envelope) {
                        viewModel.openEmailApp(with: schoolEmailUrl)
                    }
                }
                
                QuickActionButton(type: .mappin) {
                    viewModel.openMapApp()
                }
            }
        }
    }
}

struct SchoolDetailView_Previews: PreviewProvider {
    static var previews: some View {
        SchoolDetailView(
            viewModel: SchoolDetailViewModel(school: Mock.school)
        )
    }
}

struct QuickActionButton: View {
    
    var type: ButtonType
    var onTap: (() -> Void)
    
    var body: some View {
        Button {
            onTap()
        } label: {
            Image(systemName: type.imageName)
                .font(.title)
                .padding()
        }
    }
    
    enum ButtonType: String {
        case phone, envelope, mappin
        
        var imageName: String {
            return self.rawValue + ".circle"
        }
    }
}
