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

    func testWeatherKind() throws {

        XCTAssertEqual(Weather.Kind.sunny.image, UIImage.sunny)
        XCTAssertNotEqual(Weather.Kind.sunny.image, UIImage.cloudy)
        XCTAssertNotEqual(Weather.Kind.sunny.image, UIImage.rainy)
        
        XCTAssertNotEqual(Weather.Kind.cloudy.image, UIImage.sunny)
        XCTAssertEqual(Weather.Kind.cloudy.image, UIImage.cloudy)
        XCTAssertNotEqual(Weather.Kind.cloudy.image, UIImage.rainy)

        XCTAssertNotEqual(Weather.Kind.rainy.image, UIImage.sunny)
        XCTAssertNotEqual(Weather.Kind.rainy.image, UIImage.cloudy)
        XCTAssertEqual(Weather.Kind.rainy.image, UIImage.rainy)
        
        XCTAssertEqual(Weather.Kind.sunny.tintColor, .red)
        XCTAssertEqual(Weather.Kind.cloudy.tintColor, .gray)
        XCTAssertEqual(Weather.Kind.rainy.tintColor, .blue)
    }
    
    func testWeatherCodec() throws {
        
        let decoder = JSONDecoder()
        
        let weatherData1 = """
            {
                "weather" : "sunny",
                "maxTemp" : 20,
                "minTemp" : -20,
                "date" : "2020-04-01T12:00:00+09:00"
            }
            """.data(using: .utf8)!
        
        let weather1 = try decoder.decode(Weather.self, from: weatherData1)
        
        
        XCTAssertEqual(weather1.kind, .sunny)
        XCTAssertEqual(weather1.maximumTemperature, 20)
        XCTAssertEqual(weather1.minimumTemperature, -20)
        XCTAssertEqual(weather1.date, Calendar.current.date(from: DateComponents(year: 2020, month: 4, day: 1, hour: 12, minute: 0, second: 0)))
    }
}
