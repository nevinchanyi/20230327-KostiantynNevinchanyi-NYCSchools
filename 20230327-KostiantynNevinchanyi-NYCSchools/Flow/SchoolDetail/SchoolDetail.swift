//
//  SchoolDetailView.swift
//  20230327-KostiantynNevinchanyi-NYCSchools
//
//  Created by Kostiantyn Nevinchanyi on 3/27/23.
//

import SwiftUI
import MapKit

struct SchoolDetailView: View {
    
    @StateObject var viewModel: SchoolDetailViewModel
    
    var body: some View {
        ScrollView {
            if let location = viewModel.school.location {
                Map(coordinateRegion:
                        .constant(MKCoordinateRegion(
                            center: CLLocationCoordinate2D(
                                latitude: location.latitude,
                                longitude: location.longitude),
                            latitudinalMeters: 1000,
                            longitudinalMeters: 1000)
                        )
                )
                .frame(width: UIScreen.main.bounds.width, height: 200.0)
            }
            
            
            Text(viewModel.school.schoolName)
                .font(.title)
                .bold()
            Text(viewModel.school.overviewParagraph ?? "")
                .padding(.horizontal)
            
            HStack {
                if let phoneNumber = viewModel.school.phoneNumber,
                    let url = URL(string: "tel://" + phoneNumber) {
                    QuickActionButton(type: .phone) {
                        UIApplication.shared.open(url)
                    }
                }
                
                /** Would be great to add `MFMailComposeViewController` and it's wrapper to
                 implement email sending. */
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
            
            VStack(alignment: .leading) {
                Text("SAT")
                    .bold()
                ScoreView(text: "Math avg score", score: viewModel.school.sat?.satMathAvgScore)
                ScoreView(text: "Writing avg score", score: viewModel.school.sat?.satWritingAvgScore)
                ScoreView(text: "Critical Reading avg score", score: viewModel.school.sat?.satCriticalReadingAvgScore)
            }
            .padding()
            
        }
        .navigationTitle("Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct SchoolDetailView_Previews: PreviewProvider {
    static var previews: some View {
        SchoolDetailView(
            viewModel: SchoolDetailViewModel(school: Mock.school)
        )
    }
}


struct ScoreView: View {
    
    var text: String
    var score: String?
    
    var body: some View {
        HStack {
            Text(text)
            Spacer()
            Text(score ?? "N/A")
        }
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
