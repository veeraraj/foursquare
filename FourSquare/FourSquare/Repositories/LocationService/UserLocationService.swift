//
//  UserLocationService.swift
//  FourSquare
//
//  Created by Veera on 20/07/22.
//

import Foundation
import CoreLocation
import Combine

final class UserLocationService {
    // MARK: Properties
    let authorizationStatus: () -> CLAuthorizationStatus
    let requestLocation: () -> Void
    let currentUserLocation: () -> CLLocationCoordinate2D?
    let didChangeAuthorization: AnyPublisher<CLAuthorizationStatus, Never>
    let didDeallocate: () -> Void
    
    // MARK: Initialization
    
    init(
        authorizationStatus: @escaping () -> CLAuthorizationStatus,
        requestLocation: @escaping () -> Void,
        currentUserLocation: @escaping () -> CLLocationCoordinate2D?,
        didChangeAuthorization: AnyPublisher<CLAuthorizationStatus, Never>,
        didDeallocate: @escaping () -> Void
    ) {
        self.authorizationStatus = authorizationStatus
        self.requestLocation = requestLocation
        self.currentUserLocation = currentUserLocation
        self.didChangeAuthorization = didChangeAuthorization
        self.didDeallocate = didDeallocate
    }
    
    deinit {
        didDeallocate()
    }
}

extension UserLocationService {
    // Live Location
    static var live: UserLocationService = {
        final class Delegate: NSObject, CLLocationManagerDelegate {
            let authorizationSubject: PassthroughSubject<CLAuthorizationStatus, Never>
            let currentLocationSubject: CurrentValueSubject<CLLocation?, Error>
            
            init(
        authorizationSubject: PassthroughSubject<CLAuthorizationStatus, Never>,
        currentLocationSubject: CurrentValueSubject<CLLocation?, Error>
            ) {
                self.authorizationSubject = authorizationSubject
                self.currentLocationSubject = currentLocationSubject
            }
            
            func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
                authorizationSubject.send(status)
            }
            
            func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
                guard let location = locations.last else { return }
                currentLocationSubject.send(location)
            }
        }
        
        let locationManager = CLLocationManager()
        let authorizationSubject = PassthroughSubject<CLAuthorizationStatus, Never>()
        let currentLocationSubject = CurrentValueSubject<CLLocation?, Error>(nil)
        var delegate: Delegate? = Delegate(authorizationSubject: authorizationSubject, currentLocationSubject: currentLocationSubject)
        locationManager.delegate = delegate
        
        let currentLocationPublisher = currentLocationSubject
            .unwrap()
            .eraseToAnyPublisher()
        return UserLocationService(
            authorizationStatus: { locationManager.authorizationStatus },
            requestLocation: locationManager.requestWhenInUseAuthorization,
            currentUserLocation: {
                defer {
                    locationManager.startUpdatingLocation()
                }
                return currentLocationSubject.value?.coordinate
            },
            didChangeAuthorization:  authorizationSubject.eraseToAnyPublisher(),
            didDeallocate: { delegate = nil }
        )
    }()
    
    // TODO: Mock locations
}
