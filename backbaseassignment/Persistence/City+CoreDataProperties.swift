//
//  City+CoreDataProperties.swift
//  backbaseassignment
//
//  Created by Adam Lovastyik on 03/11/2018.
//  Copyright © 2018 Adam Lovastyik. All rights reserved.
//
//

import Foundation
import CoreData


extension City {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<City> {
        return NSFetchRequest<City>(entityName: "City")
    }

    @NSManaged public var name: String?
    @NSManaged public var id: String?
    @NSManaged public var longitude: Double
    @NSManaged public var latitude: Double
    @NSManaged public var currentTemp: Float
    @NSManaged public var maxTemp: Float
    @NSManaged public var minTemp: Float
    @NSManaged public var conditions: String?
    @NSManaged public var lastUpdate: NSDate?

}
