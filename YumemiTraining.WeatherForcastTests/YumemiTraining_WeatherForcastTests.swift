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

        let sunny = UIImage(weather: .sunny)
        sunny.
        XCTAssertNotNil()
        XCTAssertNotNil(UIImage(weather: .cloudy))
        XCTAssertNotNil(UIImage(weather: .rainy))
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
