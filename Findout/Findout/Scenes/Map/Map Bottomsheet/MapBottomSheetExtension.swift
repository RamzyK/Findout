//
//  MapBottomSheetExtension.swift
//  Findout
//
//  Created by Ramzy Kermad on 26/12/2019.
//  Copyright © 2019 Ramzy Kermad. All rights reserved.
//

import Foundation
import UIKit


extension PlacesScreenViewController{
    
    func setBottomSheetViewsConstraints(){
        setBottomSheetBar()
        setCloseButtonConstraint()
        setPlaceNameAndAdressConstraints()
        setRatingConstraints()
        setBookButtonConstraints()
        setAdressConstraint()
        setPlaceImageConstraints()
        setDisponibilitiesConstraints()
    }
    private func setBottomSheetBar(){
        let width = self.view.frame.width - 50
        let topBarCtn = UIView()
        topBarCtn.frame = CGRect(x: width/2, y: 3, width: 50, height: 5)
        topBarCtn.backgroundColor = #colorLiteral(red: 0.6071395874, green: 0.6035333276, blue: 0.609913528, alpha: 0.7863602312)
        topBarCtn.layer.cornerRadius = 3
        self.bottomSheetView.addSubview(topBarCtn)
    }
    
    private func setCloseButtonConstraint(){
        self.bottomSheetView.addSubview(self.closeBottomSheet)
        NSLayoutConstraint.activate([
            self.closeBottomSheet.rightAnchor.constraint(equalTo: bottomSheetView.rightAnchor, constant: -15),
            self.closeBottomSheet.topAnchor.constraint(equalTo: bottomSheetView.topAnchor, constant: 22),
        ])
    }
    
    private func setPlaceNameAndAdressConstraints(){
        let width = self.view.frame.width - closeBottomSheet.frame.width - 30
        let tap = UITapGestureRecognizer(target: self, action: #selector(showMoreOnBottomSheet))
        placeName.addGestureRecognizer(tap)
        
        self.bottomSheetView.addSubview(placeName)
        NSLayoutConstraint.activate([
            placeName.leftAnchor.constraint(equalTo: bottomSheetView.leftAnchor, constant: 20),
            placeName.topAnchor.constraint(equalTo: bottomSheetView.topAnchor, constant: 20),
            
            placeName.heightAnchor.constraint(equalToConstant: 30),
            placeName.widthAnchor.constraint(equalToConstant: width),
        ])
    }
    
    private func setRatingConstraints(){
        let ratingContainerView = UIView()
        ratingContainerView.frame = CGRect(x: 20, y: placeName.frame.origin.y + 30, width: 30, height: 40)
        
        ratingContainerView.addSubview(placeRating)
        ratingContainerView.addSubview(ratingStar)
        
        self.bottomSheetView.addSubview(ratingContainerView)
        NSLayoutConstraint.activate([
            placeRating.leftAnchor.constraint(equalTo: ratingContainerView.leftAnchor, constant: 0),
            placeRating.topAnchor.constraint(equalTo: ratingContainerView.topAnchor, constant: 0),
            
            ratingStar.leftAnchor.constraint(equalTo: placeRating.rightAnchor, constant: 3),
            ratingStar.topAnchor.constraint(equalTo: ratingContainerView.topAnchor, constant:4),
            
            placeRating.heightAnchor.constraint(equalToConstant: 30),
            placeRating.widthAnchor.constraint(equalToConstant: 10),
            ratingStar.heightAnchor.constraint(equalToConstant: 20),
            ratingStar.widthAnchor.constraint(equalToConstant: 20),
        ])
    }
    
    private func setBookButtonConstraints(){
        let width = self.view.frame.width - 20
        let separator = UIView()
        separator.frame = CGRect(x: 20, y: 160, width: width - 20 , height: 0.5)
        separator.backgroundColor = #colorLiteral(red: 0.6071395874, green: 0.6035333276, blue: 0.609913528, alpha: 0.7863602312)
        
        bookingButton.layer.cornerRadius = 6
        bookingButton.setTitle(NSLocalizedString("places.bookButtonLabel", comment: ""), for: .normal)
        
        self.bottomSheetView.addSubview(separator)
        self.bottomSheetView.addSubview(bookingButton)
         NSLayoutConstraint.activate([
            bookingButton.leftAnchor.constraint(equalTo: bottomSheetView.leftAnchor, constant: 20),
            bookingButton.topAnchor.constraint(equalTo: placeRating.bottomAnchor, constant: 10),
            
            bookingButton.heightAnchor.constraint(equalToConstant: 60),
            bookingButton.widthAnchor.constraint(equalToConstant: width - 20),
        ])
    }
    
    private func setAdressConstraint(){
        let width = self.view.frame.width
        
        self.bottomSheetView.addSubview(placeStreetLabel)
        self.bottomSheetView.addSubview(placeRegionLabel)
        self.bottomSheetView.addSubview(placeCountryLabel)
        
        let sharePlaceButton = UIView()
        sharePlaceButton.frame = CGRect(x: width - 35 - closeBottomSheet.frame.width, y: 190, width: 50, height: 50)
        sharePlaceButton.layer.cornerRadius = 25
        
        shareButton.setBackgroundImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        sharePlaceButton.addSubview(shareButton)
        
        self.bottomSheetView.addSubview(sharePlaceButton)
        NSLayoutConstraint.activate([
            placeStreetLabel.leftAnchor.constraint(equalTo: bottomSheetView.leftAnchor, constant: 20),
            placeStreetLabel.topAnchor.constraint(equalTo: bookingButton.bottomAnchor, constant: 30),
            
            placeRegionLabel.leftAnchor.constraint(equalTo: bottomSheetView.leftAnchor, constant: 20),
            placeRegionLabel.topAnchor.constraint(equalTo: placeStreetLabel.bottomAnchor, constant: 3),
            
            placeCountryLabel.leftAnchor.constraint(equalTo: bottomSheetView.leftAnchor, constant: 20),
            placeCountryLabel.topAnchor.constraint(equalTo: placeRegionLabel.bottomAnchor, constant: 3),
            
            shareButton.centerXAnchor.constraint(equalTo: sharePlaceButton.centerXAnchor),
            shareButton.centerYAnchor.constraint(equalTo: sharePlaceButton.centerYAnchor),
            
            placeStreetLabel.heightAnchor.constraint(equalToConstant: 20),
            placeStreetLabel.widthAnchor.constraint(equalToConstant: width - 40),
            placeRegionLabel.heightAnchor.constraint(equalToConstant: 20),
            placeRegionLabel.widthAnchor.constraint(equalToConstant: width - 40),
            placeCountryLabel.heightAnchor.constraint(equalToConstant: 20),
            placeCountryLabel.widthAnchor.constraint(equalToConstant: width - 40),
            
            shareButton.heightAnchor.constraint(equalToConstant: 30),
            shareButton.widthAnchor.constraint(equalToConstant: 25),
        ])
    }
    
    private func setPlaceImageConstraints(){
        let yOrigin = placeCountryLabel.frame.origin.y + placeCountryLabel.frame.height + 40
        
        placeImageViewCtn.frame = CGRect(x: 20, y: yOrigin, width: self.view.frame.width - 40, height: 170)
        placeImageViewCtn.addSubview(placeImage)
        placeImageViewCtn.backgroundColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        
        self.bottomSheetView.addSubview(placeImageViewCtn)
    }
    
    private func setDisponibilitiesConstraints(){
        let width = self.view.frame.width - 30
        bookingButton.layer.cornerRadius = 6

        self.bottomSheetView.addSubview(placeDisponitbilitiesTitle)
        self.bottomSheetView.addSubview(placeDisponobolitiesWeekTime)
        self.bottomSheetView.addSubview(placeDisponobolitiesEndTime)
        
        NSLayoutConstraint.activate([
            placeDisponitbilitiesTitle.leftAnchor.constraint(equalTo: bottomSheetView.leftAnchor, constant: 20),
            placeDisponitbilitiesTitle.topAnchor.constraint(equalTo: placeImageViewCtn.bottomAnchor, constant: 25),
            
            placeDisponobolitiesWeekTime.leftAnchor.constraint(equalTo: bottomSheetView.leftAnchor, constant: 20),
            placeDisponobolitiesWeekTime.topAnchor.constraint(equalTo: placeDisponitbilitiesTitle.bottomAnchor, constant: 4),
            
            placeDisponobolitiesEndTime.rightAnchor.constraint(equalTo: bottomSheetView.rightAnchor, constant: -20),
            placeDisponobolitiesEndTime.topAnchor.constraint(equalTo: placeDisponitbilitiesTitle.bottomAnchor, constant: 4),
            
            placeDisponitbilitiesTitle.heightAnchor.constraint(equalToConstant: 20),
            placeDisponitbilitiesTitle.widthAnchor.constraint(equalToConstant: width/2),
            
            placeDisponobolitiesWeekTime.heightAnchor.constraint(equalToConstant: 20),
            placeDisponobolitiesWeekTime.widthAnchor.constraint(equalToConstant: width/2),
            
            placeDisponobolitiesEndTime.heightAnchor.constraint(equalToConstant: 20),
            placeDisponobolitiesEndTime.widthAnchor.constraint(equalToConstant: width/2),
        ])
    }
}
