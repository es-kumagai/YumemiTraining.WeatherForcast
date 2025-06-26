//
//  YumemiTraining_WeatherForcastTests.swift
//  YumemiTraining.WeatherForcastTests
//
//  Created by Tomohiro Kumagai on 2021/08/05.
//

import XCTest
@testable import YumemiTraining_WeatherForcast

class YumemiTraining_WeatherForcastTests: XCTestCase {

    final class ConstantWeatherModel : WeatherModel {
        
        var weather: Weather
        weak var delegate: WeatherModelDelegate?
        
        init(_ weather: Weather) {
        
            self.weather = weather
        }
        
        func fetchWeatherAsync(with request: Weather.Request) {
            
            delegate?.weatherModel(self, fetchWillStartWithRequest: request)
            
            DispatchQueue.global().async {
                
                self.delegate?.weatherModel(self, fetchDidSucceed: self.weather, request: request)
            }
        }

        func fetchWeatherAsync(with request: Weather.Request, completionHandler: WeatherModel.FetchCompletionHandler?) {
            
            DispatchQueue.global().async {

                completionHandler?(.success(self.weather))
            }
        }
    }
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testWeatherKind() throws {

        XCTAssertEqual(Weather.Condition.sunny.image, UIImage.sunny)
        XCTAssertNotEqual(Weather.Condition.sunny.image, UIImage.cloudy)
        XCTAssertNotEqual(Weather.Condition.sunny.image, UIImage.rainy)
        
        XCTAssertNotEqual(Weather.Condition.cloudy.image, UIImage.sunny)
        XCTAssertEqual(Weather.Condition.cloudy.image, UIImage.cloudy)
        XCTAssertNotEqual(Weather.Condition.cloudy.image, UIImage.rainy)

        XCTAssertNotEqual(Weather.Condition.rainy.image, UIImage.sunny)
        XCTAssertNotEqual(Weather.Condition.rainy.image, UIImage.cloudy)
        XCTAssertEqual(Weather.Condition.rainy.image, UIImage.rainy)
        
        XCTAssertEqual(Weather.Condition.sunny.tintColor, .red)
        XCTAssertEqual(Weather.Condition.cloudy.tintColor, .gray)
        XCTAssertEqual(Weather.Condition.rainy.tintColor, .blue)
    }
    
    func testWeatherCodec() throws {
        
        let decoder = JSONDecoder()
        let encoder = JSONEncoder()
        
        encoder.outputFormatting = .prettyPrinted
        
        let weatherData1 = """
            {
              "max_temp" : 20,
              "date" : "2020-04-01T12:00:00+09:00",
              "min_temp" : -20,
              "weather" : "sunny"
            }
            """.data(using: .utf8)!
        
        let weather1 = try decoder.decode(Weather.self, from: weatherData1)
        let encodedWeatherData1 = try encoder.encode(weather1)
        
        XCTAssertEqual(weather1.condition, .sunny)
        XCTAssertEqual(weather1.maximumTemperature, 20)
        XCTAssertEqual(weather1.minimumTemperature, -20)
        XCTAssertEqual(weather1.date.rawDate, Calendar.current.date(from: DateComponents(year: 2020, month: 4, day: 1, hour: 12, minute: 0, second: 0)))
        
        XCTAssertEqual(String(data: weatherData1, encoding: .utf8), String(data: encodedWeatherData1, encoding: .utf8))
    }
    
    func testWeatherRequestCodec() throws {
        
        let encoder = JSONEncoder()
        let decoder = JSONDecoder()
        
        let request1 = Weather.Request(area: "tokyo", date: Weather.Date(rawDate: Date(timeIntervalSince1970: 0)))
        let jsonData1 = try encoder.encode(request1)
        let decodedRequest1 = try decoder.decode(Weather.Request.self, from: jsonData1)
        
        XCTAssertEqual(String(data: jsonData1, encoding: .utf8), #"{"date":"1970-01-01T09:00:00+09:00","area":"tokyo"}"#)
        XCTAssertEqual(decodedRequest1, request1)
    }
    
    func testInstantiateWeatherViewController() throws {
        
        let bundle = Bundle(for: WeatherViewController.self)
        let storyboard = UIStoryboard(name: "Main", bundle: bundle)
        
        let viewController = storyboard.instantiateWeatherViewController()
        
        XCTAssertNotNil(viewController)
    }
    
    func testWeatherViewController() throws {
        
        let bundle = Bundle(for: WeatherViewController.self)
        let storyboard = UIStoryboard(name: "Main", bundle: bundle)
        
        let weathers = [
        
            Weather(kind: .sunny, maximumTemperature: 32, minimumTemperature: 15, date: Weather.Date()),
            Weather(kind: .cloudy, maximumTemperature: 16, minimumTemperature: 8, date: Weather.Date()),
            Weather(kind: .rainy, maximumTemperature: 12, minimumTemperature: 4, date: Weather.Date()),
        ]

        let queue = DispatchQueue(label: "Test")
        var testedCount = 0
        
        for weather in weathers {
            
            let viewController = storyboard.instantiateWeatherViewController()!
            let expectation = XCTestExpectation(description: "\(weather.condition)")
            
            viewController.loadView()

            viewController.weatherModel = ConstantWeatherModel(weather)

            queue.async {

                viewController.reloadWeather { result in
                    
                    expectation.fulfill()
                }
            }
            
            wait(for: [expectation], timeout: 10)
            
            DispatchQueue.main.async {
                
                XCTAssertEqual(viewController.weatherImageView.image, weather.condition.imageWithTintColor)
                XCTAssertEqual(viewController.minimumTemperatureLabel.text, weather.minimumTemperature.description)
                XCTAssertEqual(viewController.maximumTemperatureLabel.text, weather.maximumTemperature.description)
                
                testedCount += 1
            }
        }
        
        let expectation = XCTestExpectation(description: "All Tests")
        
        DispatchQueue.main.async {
            
            XCTAssertEqual(testedCount, weathers.count)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10)
        
        XCTAssertFalse(expectation.isInverted)
    }
}
