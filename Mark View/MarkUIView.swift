//
//  MarkUIView.swift
//  CityMarks
//
//  Created by André Emiliano on 01/12/2023.
//

import SwiftUI
import MapKit

struct MarkUIView: View {
    @Environment(\.dismiss) var dismiss
    var cityName: String = ""
    var countryName: String = ""
    var mark: Mark

    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                AsyncImage(url: URL(string: mark.image)) { image in
                    image.resizable()
                        .scaledToFit()
                        .overlay(closeButton)

                } placeholder: {
                    ProgressView()
                          .progressViewStyle(CircularProgressViewStyle(tint: .black))
                          .scaleEffect(2.0, anchor: .center)
                          .padding()
                }
                Text(mark.name)
                    .foregroundColor(.primary)
                    .font(.title)
                    .padding()
                Text("\(cityName), \(countryName)")
                    .foregroundColor(.primary)
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(mark.description)
                    .foregroundColor(.primary)
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                setUpMap
                .padding()
                .frame(width: 400, height: 300, alignment: .bottom)
            }
        }
    }
}


extension MarkUIView {
    var setUpMap: some View {
        Map(coordinateRegion: .constant(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: mark.latitude,
                                                                                          longitude: mark.longitude),
                                                           span: MKCoordinateSpan(latitudeDelta: 0.01,
                                                                                  longitudeDelta: 0.01))),
            interactionModes: .all,
            showsUserLocation: true,
            userTrackingMode: .constant(.follow),
            annotationItems: [MarkLocation(name: mark.name,
                                           coordinate: .init(latitude: mark.latitude,
                                                             longitude: mark.longitude))]){ item in
            MapMarker(coordinate: item.coordinate, tint: .red)
        }
    }

    var closeButton: some View {
        VStack {
            HStack {
                Spacer()
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "xmark.circle")
                        .padding(10)
                        .foregroundColor(.black)
                }
            }
            .padding(5)
            Spacer()
        }
    }
}
