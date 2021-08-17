//
//  YumemiTraining_WeatherForcastTests.swift
//  YumemiTraining.WeatherForcastTests
//
//  Created by Tomohiro Kumagai on 2021/08/05.
//

import XCTest
@testable import YumemiTraining_WeatherForcast

class YumemiTraining_WeatherForcastTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testWeather() throws {

        XCTAssertEqual(Weather.sunny.image, UIImage.sunny)
        XCTAssertNotEqual(Weather.sunny.image, UIImage.cloudy)
        XCTAssertNotEqual(Weather.sunny.image, UIImage.rainy)
        
        XCTAssertNotEqual(Weather.cloudy.image, UIImage.sunny)
        XCTAssertEqual(Weather.cloudy.image, UIImage.cloudy)
        XCTAssertNotEqual(Weather.cloudy.image, UIImage.rainy)

        XCTAssertNotEqual(Weather.rainy.image, UIImage.sunny)
        XCTAssertNotEqual(Weather.rainy.image, UIImage.cloudy)
        XCTAssertEqual(Weather.rainy.image, UIImage.rainy)
        
        XCTAssertEqual(Weather.sunny.tintColor, .red)
        XCTAssertEqual(Weather.cloudy.tintColor, .gray)
        XCTAssertEqual(Weather.rainy.tintColor, .blue)
    }
}
