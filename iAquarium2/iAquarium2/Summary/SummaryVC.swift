//
//  SummaryVC.swift
//  iAquarium2
//
//  Created by Maciej Zajecki on 10/04/2020.
//  Copyright © 2020 Maciej Zajecki. All rights reserved.
//
import UIKit
import Eureka
import SplitRow
import ViewRow
import Charts
import CoreData
// MARK: - TODO
/*
 - displaying all values
 - charts (loooooong way...)
 */
class SummaryVC: FormViewController, passTank {
    
    // MARK: - Class stuff
    var tank: Tank?
    var expectedParameters: ExpectedWaterParameters?
    var measurements: [Measurement]?
    var latestMeasurement: Measurement?
    
    let dateFormatter = DateFormatter()
    
    func finishPassing(selectedTank: Tank) {
        self.tank = selectedTank
        self.expectedParameters = self.tank?.expectedParameters
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if tank != nil {
            fetchTankMeasurements()
            updateFormValues()
            tableView.reloadData()
        } else {
            print("SummaryVC: Tank is nil!!")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupForm()
    }
    
    //MARK: -Form
    func setupForm() {
        form
            +++ Section()
            <<< LabelRow() {
                $0.title = "Selected tank"
                $0.tag = "selected_tank"
            }
            <<< LabelRow() {
                $0.title = "Status"
                $0.tag = "status"
            }
            <<< LabelRow() {
                $0.title = "Latest measurement"
                $0.tag = "date_last"
            }
            
            +++ Section("Temperature") {
                section in
                section.footer?.height = {15}
                section.header?.height = {15}
            }
            <<< SplitRow<LabelRow, LabelRow>() {
                $0.rowLeftPercentage = 0.5
                $0.tag = "split_temps"
                $0.rowLeft = LabelRow() {
                    $0.title = "Expected"
                    $0.tag = "temp_expected"
                }
                $0.rowRight = LabelRow() {
                    $0.title = "Last"
                    $0.tag = "temp_last"
                }
            }
            
            +++ Section("PH") {
                section in
                section.footer?.height = {15}
                section.header?.height = {15}
        }
            <<< SplitRow<LabelRow, LabelRow>() {
                $0.rowLeftPercentage = 0.5
                $0.tag = "split_ph"
                $0.rowLeft = LabelRow() {
                    $0.title = "Expected"
                }
                
                $0.rowRight = LabelRow() {
                    $0.title = "Last"
                }
            }
            +++ Section("GH") {
                section in
                section.footer?.height = {15}
                section.header?.height = {15}
        }
            <<< SplitRow<LabelRow, LabelRow>() {
                $0.rowLeftPercentage = 0.5
                $0.tag = "split_gh"
                $0.rowLeft = LabelRow() {
                    $0.title = "Expected"
                }
                
                $0.rowRight = LabelRow() {
                    $0.title = "Last"
                }
            }        
            +++ Section("NO#") {
                section in
                section.footer?.height = {15}
                section.header?.height = {15}
        }
            <<< SplitRow<LabelRow, LabelRow>() {
                $0.rowLeftPercentage = 0.5
                $0.tag = "split_no2"
                $0.rowLeft = LabelRow() {
                    $0.title = "Expected"
                }
                
                $0.rowRight = LabelRow() {
                    $0.title = "Last"
                }
            }
            <<< SplitRow<LabelRow, LabelRow>() {
                $0.rowLeftPercentage = 0.5
                $0.tag = "split_no3"
                $0.rowLeft = LabelRow() {
                    $0.title = "Expected"
                }
                
                $0.rowRight = LabelRow() {
                    $0.title = "Last"
                }
            }
    }
    
    func updateFormValues() {
        dateFormatter.dateFormat = "dd.MM, HH:mm"
        // tank values
        (form.rowBy(tag: "selected_tank") as! LabelRow).value = tank?.name
        (form.rowBy(tag: "split_temps") as! SplitRow<LabelRow, LabelRow>).rowLeft?.value = expectedParameters?.getTempComp()
        (form.rowBy(tag: "split_ph") as! SplitRow<LabelRow, LabelRow>).rowLeft?.value = expectedParameters?.getPhComp()
        (form.rowBy(tag: "split_gh") as! SplitRow<LabelRow, LabelRow>).rowLeft?.value = expectedParameters?.getGHComp()
        (form.rowBy(tag: "split_no2") as! SplitRow<LabelRow, LabelRow>).rowLeft?.value = expectedParameters?.getNO2Comp()
        (form.rowBy(tag: "split_no3") as! SplitRow<LabelRow, LabelRow>).rowLeft?.value  = expectedParameters?.getNO3Comp()
        
        // last measurement values
        if latestMeasurement != nil {
            (form.rowBy(tag: "date_last") as! LabelRow).value = dateFormatter.string(from: (latestMeasurement?.date)!)
            (form.rowBy(tag: "split_temps") as! SplitRow<LabelRow, LabelRow>).rowRight?.value = latestMeasurement?.parameter?.temp.description
            (form.rowBy(tag: "split_ph") as! SplitRow<LabelRow, LabelRow>).rowRight?.value = latestMeasurement?.parameter?.phValue.description
            (form.rowBy(tag: "split_gh") as! SplitRow<LabelRow, LabelRow>).rowRight?.value = latestMeasurement?.parameter?.ghValue.description
            (form.rowBy(tag: "split_no2") as! SplitRow<LabelRow, LabelRow>).rowRight?.value = latestMeasurement?.parameter?.no2Value.description
            (form.rowBy(tag: "split_no3") as! SplitRow<LabelRow, LabelRow>).rowRight?.value = latestMeasurement?.parameter?.no3Value.description
        } else {
            (form.rowBy(tag: "date_last") as! LabelRow).value = " ? "
            (form.rowBy(tag: "split_temps") as! SplitRow<LabelRow, LabelRow>).rowRight?.value = " ? "
            (form.rowBy(tag: "split_ph") as! SplitRow<LabelRow, LabelRow>).rowRight?.value = " ? "
            (form.rowBy(tag: "split_gh") as! SplitRow<LabelRow, LabelRow>).rowRight?.value = " ? "
            (form.rowBy(tag: "split_no2") as! SplitRow<LabelRow, LabelRow>).rowRight?.value = " ? "
            (form.rowBy(tag: "split_no3") as! SplitRow<LabelRow, LabelRow>).rowRight?.value  = " ? "
        }
    }
    
    // MARK: - CoreData
    private func fetchTankMeasurements() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<Measurement>(entityName: "Measurement")
        
        fetchRequest.predicate = NSPredicate(format: "ofTank.name == %@", (tank?.name)!)
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        do {
            let data = try context.fetch(fetchRequest)
            measurements = data
            latestMeasurement = data.first
        } catch let error as NSError {
            print("Couldn't fetch tank's measurements: \(error), \(error.userInfo)")
        }
    }
    
    // MARK: - Chart
    private func createChartView(valueKey: String, label: String) -> LineChartView {
        let chartCell = LineChartView(frame: CGRect(x: 0, y: 0, width: 100, height: 200))
        var lineChartEntries = [ChartDataEntry]()
        var referenceTimeInterval: TimeInterval = 0

        if let minTimeInterval = (measurements?.map({ $0.date!.timeIntervalSince1970 }))?.min() {
            referenceTimeInterval = minTimeInterval
        }
        
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.dateFormat = "dd/MM\nhh:mm"
        
        let xValuesDateFormatter = ChartXAxisFormatter(referenceTimeInterval: referenceTimeInterval, dateFormatter: formatter)
        chartCell.xAxis.valueFormatter = xValuesDateFormatter
        
        measurements?.enumerated().reversed().forEach({ measurementTuple in
            let timeInterval = measurementTuple.element.date?.timeIntervalSince1970
            let xValue = (timeInterval! - referenceTimeInterval) / (3600 * 24)
            print(xValue)
            let yValue = measurementTuple.element.parameter?.getParameter(forKey: valueKey)
            let entry = ChartDataEntry(x: xValue, y: yValue!)
            
            lineChartEntries.append(entry)
        })
        
        let lineDataSet = LineChartDataSet(entries: lineChartEntries)
        lineDataSet.colors = [NSUIColor.orange]
        
        let chartData = LineChartData()
        chartData.addDataSet(lineDataSet)
        
        chartCell.data = chartData
        
        chartCell.xAxis.labelPosition = .bottom
        chartCell.doubleTapToZoomEnabled = false
        chartCell.xAxis.avoidFirstLastClippingEnabled = true
        chartCell.xAxis.wordWrapEnabled = true
        return chartCell
    }
    
    //MARK: -Navigation
    
    @IBAction func comingFromTankSelector(segue: UIStoryboardSegue) {
        
    }
}
