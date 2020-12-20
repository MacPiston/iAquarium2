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
import Firebase

class SummaryVC: FormViewController, passTank {
    // MARK: - Variables
    var tank: Tank?
    var expectedParameters: ExpectedWaterParameters?
    var measurements: [Measurement]?
    var latestMeasurement: Measurement?
    var settings: SummarySettingsEntity?
    
    let dateFormatter = DateFormatter()
    
    // MARK: - Class stuff
    
    func finishPassing(selectedTank: Tank) {
        self.tank = selectedTank
        self.expectedParameters = self.tank?.expectedParameters
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if tank != nil {
            fetchTankMeasurements()
            fetchSummarySettings()
            updateFormValues(reloadData: false)
            updateChartViews(reloadData: true)
        } else {
            print("SummaryVC: Tank is nil!!")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let user = Auth.auth().currentUser
        if (user == nil) {
            UIView.setAnimationsEnabled(false)
            performSegue(withIdentifier: "LoginSegue", sender: self)
            UIView.setAnimationsEnabled(false)
        }
        
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
            <<< ViewRow<LineChartView>() {
                $0.tag = "temp_chart"
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
            <<< ViewRow<LineChartView>() {
                $0.tag = "ph_chart"
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
            <<< ViewRow<LineChartView>() {
                $0.tag = "gh_chart"
            }
            
            +++ Section("NOx") {
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
            <<< ViewRow<LineChartView>() {
                $0.tag = "no2_chart"
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
    
    private func updateFormValues(reloadData: Bool) {
        dateFormatter.dateFormat = "dd.MM, HH:mm"
        
        // rows
        let selected_tanks = form.rowBy(tag: "selected_tank") as! LabelRow
        let split_temps = form.rowBy(tag: "split_temps") as! SplitRow<LabelRow, LabelRow>
        let split_ph = form.rowBy(tag: "split_ph") as! SplitRow<LabelRow, LabelRow>
        let split_gh = form.rowBy(tag: "split_gh") as! SplitRow<LabelRow, LabelRow>
        let split_no2 = form.rowBy(tag: "split_no2") as! SplitRow<LabelRow, LabelRow>
        let split_no3 = form.rowBy(tag: "split_no3") as! SplitRow<LabelRow, LabelRow>
        let date_last = form.rowBy(tag: "date_last") as! LabelRow
        
        // tank values
        selected_tanks.value = tank?.name
        split_temps.rowLeft?.value = expectedParameters?.getTempComp()
        split_ph.rowLeft?.value = expectedParameters?.getPhComp()
        split_gh.rowLeft?.value = expectedParameters?.getGHComp()
        split_no2.rowLeft?.value = expectedParameters?.getNO2Comp()
        split_no3.rowLeft?.value  = expectedParameters?.getNO3Comp()
        
        // last measurement values
        if latestMeasurement != nil {
            date_last.value = dateFormatter.string(from: (latestMeasurement?.date)!)
            split_temps.rowRight?.value = latestMeasurement?.parameter?.temp.description
            split_ph.rowRight?.value = latestMeasurement?.parameter?.phValue.description
            split_gh.rowRight?.value = latestMeasurement?.parameter?.ghValue.description
            split_no2.rowRight?.value = latestMeasurement?.parameter?.no2Value.description
            split_no3.rowRight?.value = latestMeasurement?.parameter?.no3Value.description
        } else {
            date_last.value = " ? "
            split_temps.rowRight?.value = " ? "
            split_ph.rowRight?.value = " ? "
            split_gh.rowRight?.value = " ? "
            split_no2.rowRight?.value = " ? "
            split_no3.rowRight?.value  = " ? "
        }
        if reloadData {
            tableView.reloadData()
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
    
    func fetchSummarySettings() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<SummarySettingsEntity>(entityName: "SummarySettingsEntity")
        
        do {
            let data = try context.fetch(fetchRequest)
            
            if data.isEmpty {
                settings = SummarySettingsEntity(context: context)
            } else {
                settings = data.first
            }
        } catch let error as NSError {
            print("Couldn't fetch summary settings: \(error), \(error.userInfo)")
        }
    }
    
    // MARK: - Chart
    private func createChartView(valueKey: String, label: String) -> LineChartView {
        let chartView = LineChartView(frame: CGRect(x: 0, y: 0, width: 100, height: 200))
        var lineChartEntries = [ChartDataEntry]()
        var referenceTimeInterval: TimeInterval = 0

        if let minTimeInterval = (measurements?.map({ $0.date!.timeIntervalSince1970 }))?.min() {
            referenceTimeInterval = minTimeInterval
        }
        
        let formatter = DateFormatter()
        let xValuesDateFormatter = ChartXAxisFormatter(referenceTimeInterval: referenceTimeInterval, dateFormatter: formatter)
        formatter.locale = Locale.current
        formatter.dateFormat = "dd/MM\nhh:mm"
        chartView.xAxis.valueFormatter = xValuesDateFormatter
        
        measurements?.enumerated().reversed().forEach({ measurementTuple in
            let timeInterval = measurementTuple.element.date?.timeIntervalSince1970
            let xValue = (timeInterval! - referenceTimeInterval) / (3600 * 24)
            //print(xValue)
            let yValue = measurementTuple.element.parameter?.getParameter(forKey: valueKey)
            let entry = ChartDataEntry(x: xValue, y: yValue!)
            
            lineChartEntries.append(entry)
        })
        
        let lineDataSet = LineChartDataSet(entries: lineChartEntries)
        lineDataSet.colors = [NSUIColor.orange]
        
        let chartData = LineChartData()
        chartData.addDataSet(lineDataSet)
        
        chartView.data = chartData
        chartView.xAxis.labelPosition = .bottom
        chartView.doubleTapToZoomEnabled = false
        chartView.xAxis.avoidFirstLastClippingEnabled = true
        chartView.xAxis.wordWrapEnabled = true
        return chartView
    }
    
    func updateChartViews(reloadData: Bool) {
        let temp_chart = form.rowBy(tag: "temp_chart") as! ViewRow<LineChartView>
        let ph_chart = form.rowBy(tag: "ph_chart") as! ViewRow<LineChartView>
        let gh_chart = form.rowBy(tag: "gh_chart") as! ViewRow<LineChartView>
        let no2_chart = form.rowBy(tag: "no2_chart") as! ViewRow<LineChartView>
        
        if settings?.tempChartEnabled == true && measurements?.isEmpty == false {
            temp_chart.hidden = false
            temp_chart.evaluateHidden()
            temp_chart.cell.view = createChartView(valueKey: "temp", label: "")
        } else {
            temp_chart.hidden = true
            temp_chart.evaluateHidden()
        }
        
        if settings?.phChartEnabled == true && measurements?.isEmpty == false  {
            ph_chart.hidden = false
            ph_chart.evaluateHidden()
            ph_chart.cell.view = createChartView(valueKey: "ph", label: "")
        } else {
            ph_chart.hidden = true
            ph_chart.evaluateHidden()
        }
        
        if settings?.ghChartEnabled == true && measurements?.isEmpty == false  {
            gh_chart.hidden = false
            gh_chart.evaluateHidden()
            gh_chart.cell.view = createChartView(valueKey: "gh", label: "")
        } else {
            gh_chart.hidden = true
            gh_chart.evaluateHidden()
        }
        
        if settings?.no2ChartEnabled == true && measurements?.isEmpty == false {
            no2_chart.hidden = false
            no2_chart.evaluateHidden()
            no2_chart.cell.view = createChartView(valueKey: "no2", label: "")
        } else {
            no2_chart.hidden = true
            no2_chart.evaluateHidden()
        }
        
        if reloadData {
            tableView.reloadData()
        }
    }
    
    //MARK: -Navigation
    
}
