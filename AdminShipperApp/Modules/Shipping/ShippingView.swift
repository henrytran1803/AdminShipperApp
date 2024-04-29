//
//  ShippingView.swift
//  AdminShipperApp
//
//  Created by Tran Viet Anh on 29/04/2024.
//

import SwiftUI
import MapKit
import CoreLocation

struct ShippingView: View {
    @State var order : Order
    @State var isAdd  = false
    @State private var mapHeight: CGFloat = 400
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194),
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )

    @State private var annotations: [MKPointAnnotation] = []
    let locationManager = CLLocationManager()

    var body: some View {
        VStack {
            MapView(region: $region, annotations: $annotations)
                .frame(height: 300)
            Spacer()
            Text("Đơn hàng: \(order.orderId)")
                .bold()
                .font(.title)
            Text("Địa chỉ: \(order.address)")
                .bold()
                .font(.title)
            Button(action: {
                isAdd = true
                OrderMV().deleteOrder(orderId: order.orderId)
            }, label: {
                RoundedRectangle(cornerRadius: 5)
                     .frame(width: 300, height: 60)
                     .foregroundColor(Color("buttonwelcome"))
                     .overlay{
                         Text("Giao thành công")
                             .bold()
                             .foregroundColor(.white)
                     }
             }).padding()
        }
        .onAppear {
            startUpdatingLocation()
            Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { timer in
                if let location = locationManager.location {
                    updateMapView(with: location)
                }
            }
        }
        .fullScreenCover(isPresented: $isAdd, content: {
            TabBarShiperView()
        })
    }
    
    private func startUpdatingLocation() {
        locationManager.requestWhenInUseAuthorization()
        
        locationManager.startUpdatingLocation()
    }
    
    private func updateMapView(with location: CLLocation) {
        let newCoordinate = location.coordinate
        region = MKCoordinateRegion(center: newCoordinate, span: region.span)
        
        let newAnnotation = MKPointAnnotation()
        newAnnotation.coordinate = newCoordinate
        annotations = [newAnnotation]
        
        let longitudeString = String(format: "%.6f", newCoordinate.longitude)
        let latitudeString = String(format: "%.6f", newCoordinate.latitude)
        OrderMV().updateLongLatForOrder(orderId: order.orderId, newLong: longitudeString, newLat: latitudeString)
    }
}

#Preview {
    ShippingView(order: Order(userId: "5GrSfED6Tti9lp8uIGJc", orderId: "", name: "", address: "", shiper: "", lat: "", long: ""))
}
