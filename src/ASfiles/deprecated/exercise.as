/**
 * NOTE: This file has been deprecated, and has been replaced by ExercisesController, ExercisesModel and ExercisesModule.
 */
import components.exercise.addPersonalExercise;
import components.exercise.recordResultsWindow;
import components.exercise.runEditGoal;

import mx.charts.ChartItem;
import mx.charts.events.ChartItemEvent;
import mx.charts.series.items.LineSeriesItem;
import mx.charts.series.items.PlotSeriesItem;
import mx.collections.ArrayCollection;
import mx.core.ClassFactory;
import mx.graphics.IFill;
import mx.managers.PopUpManager;

import spark.components.TitleWindow;

import util.DateUtil;

[Bindable] public var exerciseCurrentIndex:uint = 4;

/*MOVED TO SHARED
[Bindable] public var exerciseData:ArrayCollection = new ArrayCollection([
	{dateProvider: '03/11/2011', date: '03/11/2011', series:"PRTresults", PRTscore: 61, mileRun: 61, curlUps: 60, pushUps: 48, weight: 200, min:14, sec:40, curlTimes:40, pushTimes:20, type: "provider", expectation:'expectation', index:0},
	{datePatient: '04/03/2011', date: '04/03/2011', series:"PRTresults", PRTscore: 74, mileRun: 46, curlUps: 60, pushUps: 56, weight: 205, min:14, sec:10, curlTimes:30, pushTimes:20, type: "patient", expectation:'expectation', index:1},
	{datePatient: '06/03/2011', date: '06/03/2011', series:"PRTresults", PRTscore: 81, mileRun: 56, curlUps: 50, pushUps: 70, weight: 210, min:15, sec:0, curlTimes:35, pushTimes:25, type: "patient", expectation:'expectation', index:2},
	{dateProvider: '01/03/2012', date: '01/03/2012', series:"PRTresults", PRTscore: 92, mileRun: 64, curlUps: 55, pushUps: 50, weight: 205, min:13, sec:50, curlTimes:40, pushTimes:24, type: "provider", expectation:'expectation', index:3}
]);

[Bindable] public var exerciseDataByMeasure:ArrayCollection = new ArrayCollection([
	{ measure: "Avg. PRT Score", chartMin: 35, chartMax: 100,
		chart:[ { data:[{value:61, expectation:45, date:'03/11/2011', type:'provider', measure:'PRTscore'},{value:74, expectation:45, date:'04/03/2011', type:'patient', measure:'PRTscore'},{value:81, expectation:45, date:'06/03/2011', type:'patient', measure:'PRTscore'},{value:92, expectation:45, date:'01/03/2012', type:'provider', measure:'PRTscore'}]} ] },
	{ measure: "1.5 Mile Run", chartMin: 35, chartMax: 100,
		chart:[ { data:[{value:63, expectation:45, target:62, targetMin:14, targetSec:40, date:'03/11/2011', type:'provider', measure:'mileRun', min:14, sec:35},{value:64, expectation:45, target:62, date:'04/03/2011', type:'patient', measure:'mileRun', min:14, sec:30},{value:60, expectation:45, target:62, date:'06/03/2011', type:'patient', measure:'mileRun', min:14, sec:50},{value:62, expectation:45, target:62, date:'01/03/2012', type:'provider', measure:'mileRun', min:14, sec:40}]} ] },
	{ measure: "Curl Ups", chartMin: 35, chartMax: 100,
		chart:[ { data:[{value:81, expectation:45, date:'03/11/2011', type:'provider', measure:'curlUps', times:40},{value:56, expectation:45, date:'04/03/2011', type:'patient', measure:'curlUps', times:30},{value:50, expectation:45, date:'06/03/2011', type:'patient', measure:'curlUps', times:35},{value:70, expectation:45, date:'01/03/2012', type:'provider', measure:'curlUps', times:40}]} ] },
	{ measure: "Push Ups", chartMin: 35, chartMax: 100,
		chart:[ { data:[{value:92, expectation:45, date:'03/11/2011', type:'provider', measure:'pushUps', times:20},{value:64, expectation:45, date:'04/03/2011', type:'patient', measure:'pushUps', times:20},{value:55, expectation:45, date:'06/03/2011', type:'patient', measure:'pushUps', times:25},{value:50, expectation:45, date:'01/03/2012', type:'provider', measure:'pushUps', times:24}]} ] }
]);

[Bindable] public var exerciseDataPhysicianAssigned:ArrayCollection = new ArrayCollection([
	{date: '03/11/2011', runWalk: 30, runWalkMiles: 3.0, bike: 30, expectation:'expectation', index:0, comments:'I was feeling fine and enjoying exercising.'},
	{date: '04/11/2011', runWalk: 32, runWalkMiles: 3.0, bike: 29, expectation:'expectation', index:1, comments:'I was feeling fine and enjoying exercising.'},
	{date: '05/11/2011', runWalk: 34, runWalkMiles: 3.0, bike: 28, expectation:'expectation', index:2, comments:'I was feeling fine and enjoying exercising.'},
	{date: '06/11/2011', runWalk: 27, runWalkMiles: 3.0, bike: 31, expectation:'expectation', index:3, comments:'I was feeling fine and enjoying exercising.'},
	{date: '01/03/2012', runWalk: 30, runWalkMiles: 3.0, bike: 34, expectation:'expectation', index:4, comments:'I was feeling fine and enjoying exercising.'}
]);

[Bindable] public var exerciseDataByMeasurePhysicianAssigned:ArrayCollection = new ArrayCollection([
	{ measure: "Run / Walk", chartMin:15, chartMax:45,
		chart:[ {data:[{value:30, expectation:30, date:'03/11/2011',miles:3.0, measure:'runWalk'},{value:32, expectation:30, date:'04/11/2011',miles:3.0, measure:'runWalk'},{value:34, expectation:30, date:'05/11/2011',miles:3.0, measure:'runWalk'},{value:27, expectation:30, date:'06/11/2011',miles:3.0, measure:'runWalk'},{value:30, expectation:30, date:'01/03/2012',miles:3.0, measure:'runWalk'}]}]},
	{ measure: "Bike", chartMin:15, chartMax:45,
		chart:[ {data:[{value:30, expectation:30, date:'03/11/2011', measure:'bike'},{value:29, expectation:30, date:'04/11/2011', measure:'bike'},{value:28, expectation:30, date:'05/11/2011', measure:'bike'},{value:31, expectation:30, date:'06/11/2011', measure:'bike'},{value:34, expectation:30, date:'01/03/2012', measure:'bike'}]}]},
	{ measure: "Comments", chartType: "comments",
		chart:[ { data:[{type:'patient',expectation:'expectation',author:fullname,datePatient:'03/11/2011',comments:'I was feeling fine and enjoying exercising.', measure:'comments'},{type:'patient',expectation:'expectation',author:fullname,datePatient:'04/11/2011',comments:'I was feeling fine and enjoying exercising.', measure:'comments'},{type:'patient',expectation:'expectation',author:fullname,datePatient:'05/11/2011',comments:'I was feeling fine and enjoying exercising.', measure:'comments'},{type:'patient',expectation:'expectation',author:fullname,datePatient:'06/11/2011',comments:'I was feeling fine and enjoying exercising.', measure:'comments'},{type:'patient',expectation:'expectation',author:fullname,datePatient:'01/03/2012',comments:'I was feeling fine and enjoying exercising.', measure:'comments'}]}]}
]);

//for list view
[Bindable] public var exerciseDataPersonal:ArrayCollection = new ArrayCollection([
	{date: '03/11/2011', activity: 'Bike', comments:'I was feeling fine and enjoying exercising.'},
	{date: '03/11/2011', activity: 'Hike', comments:'I was feeling fine and enjoying exercising.'},
	{date: '04/11/2011', activity: 'Bike', comments:'I was feeling fine and enjoying exercising.'},
	{date: '04/11/2011', activity: 'Hike', comments:'I was feeling fine and enjoying exercising.'},
	{date: '05/11/2011', activity: 'Bike', comments:'I was feeling fine and enjoying exercising.'},
	{date: '05/11/2011', activity: 'Hike', comments:'I was feeling fine and enjoying exercising.'},
	{date: '06/11/2011', activity: 'Bike', comments:'I was feeling fine and enjoying exercising.'},
	{date: '06/11/2011', activity: 'Hike', comments:'I was feeling fine and enjoying exercising.'},
	{date: '01/03/2012', activity: 'Bike', comments:'I was feeling fine and enjoying exercising.'},
	{date: '01/03/2012', activity: 'Hike', comments:'I was feeling fine and enjoying exercising.'}
]);

[Bindable] public var exerciseDataByMeasurePersonal:ArrayCollection = new ArrayCollection([
	{ measure: "Bike", chartMin:15, chartMax:45, chartType:'trackable',
		chart:[ {data:[{value:30, expectation:30, date:'03/11/2011', measure:'bike'},{value:29, expectation:30, date:'04/11/2011', measure:'bike'},{value:28, expectation:30, date:'05/11/2011', measure:'bike'},{value:31, expectation:30, date:'06/11/2011', measure:'bike'},{value:34, expectation:30, date:'01/03/2012', measure:'bike'}]}]},
	{ measure: "Hike", chartMin:15, chartMax:45, chartType: 'untrackable',
		chart:[ {data:[{value:"This is my comment", expectation:30, date:'03/11/2011',measure:'hike', yvalue:30},{value:"This is my comment", expectation:30, date:'04/11/2011', measure:'hike', yvalue:30},{value:"This is my comment", expectation:30, date:'05/11/2011', measure:'hike', yvalue:30},{value:"This is my comment", expectation:30, date:'06/11/2011',measure:'hike', yvalue:30},{value:"This is my comment", expectation:30, date:'01/03/2012', measure:'hike', yvalue:30}]}]},
	{ measure: "Comments", chartType: 'untrackable',
		chart:[ { data:[{type:'patient',expectation:'expectation',author:fullname,datePatient:'03/11/2011',comments:'I was feeling fine and enjoying exercising.', measure:'comments'},{type:'patient',expectation:'expectation',author:fullname,datePatient:'04/11/2011',comments:'I was feeling fine and enjoying exercising.', measure:'comments'},{type:'patient',expectation:'expectation',author:fullname,datePatient:'05/11/2011',comments:'I was feeling fine and enjoying exercising.', measure:'comments'},{type:'patient',expectation:'expectation',author:fullname,datePatient:'06/11/2011',comments:'I was feeling fine and enjoying exercising.', measure:'comments'},{type:'patient',expectation:'expectation',author:fullname,datePatient:'01/03/2012',comments:'I was feeling fine and enjoying exercising.', measure:'comments'}]}]}
]);

[Bindable] public var chartMinExPA:Date = new Date(2011,0,26);
[Bindable] public var chartMaxExPA:Date = new Date(2012,0,11);
[Bindable] public var chartMinExPER:Date = new Date(2011,0,26);
[Bindable] public var chartMaxExPER:Date = new Date(2012,0,11);

//
[Bindable] public var PRTscoreMax:String = "01/03/2012";
[Bindable] public var mileRunMax:String = "01/03/2012";
[Bindable] public var curlUpsMax:String = "01/03/2012";
[Bindable] public var pushUpsMax:String = "01/03/2012";
[Bindable] public var runWalkChartMin:Date = new Date(2010,11,7);
[Bindable] public var runWalkChartMax:Date = new Date(2012,3,22);
[Bindable] public var runWalkMax:String = "01/03/2012";
[Bindable] public var bikeChartMin:Date = new Date(2010,11,7);
[Bindable] public var bikeChartMax:Date = new Date(2012,3,22);
[Bindable] public var bikeMax:String = "01/03/2012";
[Bindable] public var exPAcommentsMax:String = "01/03/2012";


[Bindable] public var PAproviderCopy:ArrayCollection = new ArrayCollection(exerciseDataByMeasurePhysicianAssigned.toArray());
[Bindable] public var PERproviderCopy:ArrayCollection = new ArrayCollection(exerciseDataByMeasurePersonal.toArray());
[Bindable] public var arrExerciseForWidget:ArrayCollection = new ArrayCollection([
	{ exerciseType: "Most Recent PRT", lastDate: exerciseData.getItemAt(3).date, chartType: "normal", chartMin: 155, chartMax: 190, chart: exerciseData.getItemAt(3) },
	{ exerciseType: "Physician-assigned", lastDate: exerciseDataByMeasurePhysicianAssigned.getItemAt(0).chart[0].data[exerciseDataByMeasurePhysicianAssigned.getItemAt(0).chart[0].data.length - 1].date, chartType: "double", chartMin: 40, chartMax: 160, chart: PAproviderCopy },
	{ exerciseType: "Personal", lastDate: exerciseDataByMeasurePersonal.getItemAt(0).chart[0].data[exerciseDataByMeasurePersonal.getItemAt(0).chart[0].data.length - 1].date, chartType: "normal", chartMin: 40, chartMax: 85, chart: PERproviderCopy }	
]);
[Bindable] public var collapsedExercisesPixels:uint = 0;	//used for recalculating widget's height
//this function removes "Comments" and "Hiking" (untrackable exercise) for the WIDGET
public function filterProvidersForWidget():void {
	PAproviderCopy.source.splice(-1);
	PERproviderCopy.source.splice(-2);
}*/

public function exercisePlotFillFunction(element:ChartItem, index:Number):IFill {
	var item:PlotSeriesItem = PlotSeriesItem(element);
	return (item.item.type == 'provider') ? chartStyles.colorVitalSignsProvider : chartStyles.colorVitalSignsPatient;
}

public function exerciseLineFillFunction(element:ChartItem, index:Number):IFill {
	var item:LineSeriesItem = LineSeriesItem(element);
	return (item.item.type == 'provider') ? chartStyles.colorVitalSignsProvider : chartStyles.colorVitalSignsPatient;
}

private function displayExerciseData(e:ChartItemEvent):void {
	//(e.hitData.item.type == 'provider') ? e.hitData.item.dateProvider : e.hitData.item.datePatient;
	//exerciseCurrentIndex = e.hitData.item.index;
	var radarChartSeries:Array = myRadarChart.series;
	var radarChartAxes:Array = myRadarChart.axes;
	exerciseCurrentIndex = e.hitData.item.index; //myRadarChart.dataProvider = exerciseData.getItemAt(e.hitData.item.index);
	myRadarChart.series = radarChartSeries;
	myRadarChart.axes = radarChartAxes;
	exPlotSeriesPatient.setStyle("itemRenderer",new ClassFactory(ASclasses.MyCircleItemRendererExSliderOver));
	exPlotSeriesProvider.setStyle("itemRenderer",new ClassFactory(ASclasses.MyBoxItemRendererExSliderOver));
}

[Bindable] public var exerciseIndices:Array = new Array();
public function updateExerciseIndices():void {
	var exerciseIndicesTemp:Array = new Array();
	for(var i:uint = 0; i < exerciseDataByMeasure.length; i++) {
		exerciseIndicesTemp.push(exerciseDataByMeasure.getItemAt(i).measure);
	}
	exerciseIndices = exerciseIndicesTemp;
}

/*
moved to SHARED
[Bindable] public var exercisePAIndices:Array = new Array();
public function updateExercisePAIndices():void {
	var exercisePAIndicesTemp:Array = new Array();
	for(var i:uint = 0; i < exerciseDataByMeasurePhysicianAssigned.length; i++) {
		exercisePAIndicesTemp.push(exerciseDataByMeasurePhysicianAssigned.getItemAt(i).measure);
	}
	exercisePAIndices = exercisePAIndicesTemp;
}*/

[Bindable] public var exercisePERIndices:Array = new Array();
public function updateExercisePERIndices():void {
	var exercisePERIndicesTemp:Array = new Array();
	for(var i:uint = 0; i < exerciseDataByMeasurePersonal.length; i++) {
		exercisePERIndicesTemp.push(exerciseDataByMeasurePersonal.getItemAt(i).measure);
	}
	exercisePERIndices = exercisePERIndicesTemp;
}

private function switchExerciseView(index:uint):void {
	viewsExercisePRT.selectedIndex = index;
	/*if(index == 1) {
		btnVitalChart.setStyle("chromeColor", 0xB3B3B3);
		btnVitalList.setStyle("chromeColor", 0xFF931E);
	}
	else {
		btnVitalChart.setStyle("chromeColor", 0xFF931E);
		btnVitalList.setStyle("chromeColor", 0xB3B3B3);
	}*/
	
	if(index == 0) highlightSelectedExercise('All');
	else if(index == 2) highlightSelectedExercise('1.5 Mile Run');
	//else if(index == 3) highlightSelectedVital('Blood Pressure');
}

private function switchExercisePhyView(index:uint):void {
	viewsExercisePA.selectedIndex = index;
	/*if(index == 1) {
	btnVitalChart.setStyle("chromeColor", 0xB3B3B3);
	btnVitalList.setStyle("chromeColor", 0xFF931E);
	}
	else {
	btnVitalChart.setStyle("chromeColor", 0xFF931E);
	btnVitalList.setStyle("chromeColor", 0xB3B3B3);
	}*/
	
	if(index == 0) highlightSelectedExercisePA('All');
	else if(index == 2) highlightSelectedExercisePA('Run / Walk');
	//else if(index == 3) highlightSelectedVital('Blood Pressure');
}

private function highlightSelectedExercise(exercise:String = "none"):void {
	btnExAll.styleName = "messageFolderNotSelected";
	btnExRun.styleName = "messageFolderNotSelected";
	//btnVSBloodPressure.styleName = "messageFolderNotSelected";
	if(exercise == "All") btnExAll.styleName = "messageFolderSelected";
	else if(exercise == "1.5 Mile Run") btnExRun.styleName = "messageFolderSelected";
	//else if(vital == "Blood Pressure") btnVSBloodPressure.styleName = "messageFolderSelected";
}

private function highlightSelectedExercisePA(exercise:String = "none"):void {
	btnExEndurance.styleName = "messageFolderNotSelected";
	btnExRunWalk.styleName = "messageFolderNotSelected";
	if(exercise == "All") btnExEndurance.styleName = "messageFolderSelected";
	else if(exercise == "Run / Walk") btnExRunWalk.styleName = "messageFolderSelected";
}

private function runChartRolloverEventHandler(event:ChartItemEvent):void {
	lblExRun.text = exerciseDataByMeasure.getItemAt(exerciseIndices.indexOf('1.5 Mile Run')).chart[0].data[event.hitData.chartItem.index].value;
	lblExRunDiff.text = '(+' + String(exerciseDataByMeasure.getItemAt(exerciseIndices.indexOf('1.5 Mile Run')).chart[0].data[event.hitData.chartItem.index].value - 45) + ')';
	lblExRunMin.text = exerciseDataByMeasure.getItemAt(exerciseIndices.indexOf('1.5 Mile Run')).chart[0].data[event.hitData.chartItem.index].min;
	lblExRunSec.text = exerciseDataByMeasure.getItemAt(exerciseIndices.indexOf('1.5 Mile Run')).chart[0].data[event.hitData.chartItem.index].sec;
	lblExRunDate.text = DateUtil.formatDateFromString(exerciseDataByMeasure.getItemAt(exerciseIndices.indexOf('1.5 Mile Run')).chart[0].data[event.hitData.chartItem.index].date);
	lblRunDiff.text = (event.hitData.chartItem.index == 0) ? '' : String(Math.abs(exerciseDataByMeasure.getItemAt(exerciseIndices.indexOf('1.5 Mile Run')).chart[0].data[event.hitData.chartItem.index].value - exerciseDataByMeasure.getItemAt(exerciseIndices.indexOf('1.5 Mile Run')).chart[0].data[event.hitData.chartItem.index - 1].value));
	lblRunDiffUnits.text = (event.hitData.chartItem.index == 0) ? '' : exerciseDataByMeasure.getItemAt(exerciseIndices.indexOf('1.5 Mile Run')).chart[0].data[event.hitData.chartItem.index].value - exerciseDataByMeasure.getItemAt(exerciseIndices.indexOf('1.5 Mile Run')).chart[0].data[event.hitData.chartItem.index - 1].value < 0 ? 'points down' : 'points up';
	lblRunDiffSeconds.text = (event.hitData.chartItem.index == 0) ? '' : String(Math.abs(exerciseDataByMeasure.getItemAt(exerciseIndices.indexOf('1.5 Mile Run')).chart[0].data[event.hitData.chartItem.index].sec - exerciseDataByMeasure.getItemAt(exerciseIndices.indexOf('1.5 Mile Run')).chart[0].data[event.hitData.chartItem.index - 1].sec));
	lblRunDiffSecondsUnits.text = (event.hitData.chartItem.index == 0) ? '' : exerciseDataByMeasure.getItemAt(exerciseIndices.indexOf('1.5 Mile Run')).chart[0].data[event.hitData.chartItem.index].value - exerciseDataByMeasure.getItemAt(exerciseIndices.indexOf('1.5 Mile Run')).chart[0].data[event.hitData.chartItem.index - 1].value < 0 ? 'seconds slower' : 'seconds faster';
	lblRunDatePrev.text = (event.hitData.chartItem.index == 0) ? '' : 'from ' + DateUtil.formatDateFromString(exerciseDataByMeasure.getItemAt(exerciseIndices.indexOf('1.5 Mile Run')).chart[0].data[event.hitData.chartItem.index - 1].date);
	lblRunDiffUnits.visible = (event.hitData.chartItem.index != 0);
	imgRunDiffPos.visible = imgRunDiffPos.includeInLayout = event.hitData.chartItem.index != 0 && lblRunDiffUnits.text == 'points up';
	imgRunDiffNeg.visible = imgRunDiffNeg.includeInLayout = event.hitData.chartItem.index != 0 && lblRunDiffUnits.text == 'points down';
	myLineSeriesRun.setStyle("itemRenderer",new ClassFactory(components.itemrenderers.MyCircleItemRendererOverIndividual));
}
private function runChartRolloutEventHandler(event:ChartItemEvent):void {
	lblExRun.text = exerciseDataByMeasure.getItemAt(exerciseIndices.indexOf('1.5 Mile Run')).chart[0].data[exerciseDataByMeasure.getItemAt(exerciseIndices.indexOf('1.5 Mile Run')).chart[0].data.length - 1].value;
	lblExRunDiff.text = '(+' + String(exerciseDataByMeasure.getItemAt(exerciseIndices.indexOf('1.5 Mile Run')).chart[0].data[exerciseDataByMeasure.getItemAt(exerciseIndices.indexOf('1.5 Mile Run')).chart[0].data.length - 1].value - 45) + ')';
	lblExRunMin.text = exerciseDataByMeasure.getItemAt(exerciseIndices.indexOf('1.5 Mile Run')).chart[0].data[exerciseDataByMeasure.getItemAt(exerciseIndices.indexOf('1.5 Mile Run')).chart[0].data.length - 1].min;
	lblExRunSec.text = exerciseDataByMeasure.getItemAt(exerciseIndices.indexOf('1.5 Mile Run')).chart[0].data[exerciseDataByMeasure.getItemAt(exerciseIndices.indexOf('1.5 Mile Run')).chart[0].data.length - 1].sec;
	lblExRunDate.text = DateUtil.formatDateFromString(exerciseDataByMeasure.getItemAt(exerciseIndices.indexOf('1.5 Mile Run')).chart[0].data[exerciseDataByMeasure.getItemAt(exerciseIndices.indexOf('1.5 Mile Run')).chart[0].data.length - 1].date);
	lblRunDiff.text = String(Math.abs(exerciseDataByMeasure.getItemAt(exerciseIndices.indexOf('1.5 Mile Run')).chart[0].data[exerciseDataByMeasure.getItemAt(exerciseIndices.indexOf('1.5 Mile Run')).chart[0].data.length - 1].value - exerciseDataByMeasure.getItemAt(exerciseIndices.indexOf('1.5 Mile Run')).chart[0].data[exerciseDataByMeasure.getItemAt(exerciseIndices.indexOf('1.5 Mile Run')).chart[0].data.length - 2].value));
	lblRunDiffUnits.text = exerciseDataByMeasure.getItemAt(exerciseIndices.indexOf('1.5 Mile Run')).chart[0].data[exerciseDataByMeasure.getItemAt(exerciseIndices.indexOf('1.5 Mile Run')).chart[0].data.length - 1].value - exerciseDataByMeasure.getItemAt(exerciseIndices.indexOf('1.5 Mile Run')).chart[0].data[exerciseDataByMeasure.getItemAt(exerciseIndices.indexOf('1.5 Mile Run')).chart[0].data.length - 2].value < 0 ? 'points down' : 'points up';
	lblRunDiffSeconds.text = String(Math.abs(exerciseDataByMeasure.getItemAt(exerciseIndices.indexOf('1.5 Mile Run')).chart[0].data[exerciseDataByMeasure.getItemAt(exerciseIndices.indexOf('1.5 Mile Run')).chart[0].data.length - 1].sec - exerciseDataByMeasure.getItemAt(exerciseIndices.indexOf('1.5 Mile Run')).chart[0].data[exerciseDataByMeasure.getItemAt(exerciseIndices.indexOf('1.5 Mile Run')).chart[0].data.length - 2].sec));
	lblRunDiffSecondsUnits.text = exerciseDataByMeasure.getItemAt(exerciseIndices.indexOf('1.5 Mile Run')).chart[0].data[exerciseDataByMeasure.getItemAt(exerciseIndices.indexOf('1.5 Mile Run')).chart[0].data.length - 1].value - exerciseDataByMeasure.getItemAt(exerciseIndices.indexOf('1.5 Mile Run')).chart[0].data[exerciseDataByMeasure.getItemAt(exerciseIndices.indexOf('1.5 Mile Run')).chart[0].data.length - 2].value < 0 ? 'seconds slower' : 'seconds faster';
	lblRunDatePrev.text = 'from ' + DateUtil.formatDateFromString(exerciseDataByMeasure.getItemAt(exerciseIndices.indexOf('1.5 Mile Run')).chart[0].data[exerciseDataByMeasure.getItemAt(exerciseIndices.indexOf('1.5 Mile Run')).chart[0].data.length - 2].date);
	lblRunDiffUnits.visible = true;
	imgRunDiffPos.visible = imgRunDiffPos.includeInLayout = lblRunDiffUnits.text == 'points up';
	imgRunDiffNeg.visible = imgRunDiffNeg.includeInLayout = lblRunDiffUnits.text == 'points down';
	myLineSeriesRun.setStyle("itemRenderer",new ClassFactory(components.itemrenderers.MyCircleItemRendererIndividual));
}

private function runWalkChartRolloverEventHandler(event:ChartItemEvent):void {
	lblExDistance.text = exerciseDataByMeasurePhysicianAssigned.getItemAt(exercisePAIndices.indexOf('Run / Walk')).chart[0].data[event.hitData.chartItem.index].miles;
	lblExDuration.text = exerciseDataByMeasurePhysicianAssigned.getItemAt(exercisePAIndices.indexOf('Run / Walk')).chart[0].data[event.hitData.chartItem.index].value;
	lblExSpeed.text = String(int((exerciseDataByMeasurePhysicianAssigned.getItemAt(exercisePAIndices.indexOf('Run / Walk')).chart[0].data[event.hitData.chartItem.index].miles / exerciseDataByMeasurePhysicianAssigned.getItemAt(exercisePAIndices.indexOf('Run / Walk')).chart[0].data[event.hitData.chartItem.index].value) * 60 * 10) / 10);
	lblExCalories.text = String(Math.round(180 * .3 * exerciseDataByMeasurePhysicianAssigned.getItemAt(exercisePAIndices.indexOf('Run / Walk')).chart[0].data[event.hitData.chartItem.index].miles));
	lblExDistanceDate.text = lblExDurationDate.text = lblExSpeedDate.text = lblExCaloriesDate.text = lblExHeartDate.text = lblExWeightDate.text = DateUtil.formatDateFromString(exerciseDataByMeasurePhysicianAssigned.getItemAt(exercisePAIndices.indexOf('Run / Walk')).chart[0].data[event.hitData.chartItem.index].date);
	myLineSeriesRunWalk.setStyle("itemRenderer",new ClassFactory(components.itemrenderers.MyCircleItemRendererOverIndividual));
}

private function runWalkChartRolloutEventHandler(event:ChartItemEvent):void {
	lblExDistance.text = exerciseDataByMeasurePhysicianAssigned.getItemAt(exercisePAIndices.indexOf('Run / Walk')).chart[0].data[exerciseDataByMeasurePhysicianAssigned.getItemAt(exercisePAIndices.indexOf('Run / Walk')).chart[0].data.length - 1].miles;
	lblExDuration.text = exerciseDataByMeasurePhysicianAssigned.getItemAt(exercisePAIndices.indexOf('Run / Walk')).chart[0].data[exerciseDataByMeasurePhysicianAssigned.getItemAt(exercisePAIndices.indexOf('Run / Walk')).chart[0].data.length - 1].value;
	lblExSpeed.text = String(int((exerciseDataByMeasurePhysicianAssigned.getItemAt(exercisePAIndices.indexOf('Run / Walk')).chart[0].data[exerciseDataByMeasurePhysicianAssigned.getItemAt(exercisePAIndices.indexOf('Run / Walk')).chart[0].data.length - 1].miles / exerciseDataByMeasurePhysicianAssigned.getItemAt(exercisePAIndices.indexOf('Run / Walk')).chart[0].data[exerciseDataByMeasurePhysicianAssigned.getItemAt(exercisePAIndices.indexOf('Run / Walk')).chart[0].data.length - 1].value) * 60 * 10) / 10);
	lblExCalories.text = String(Math.round(180 * .3 * exerciseDataByMeasurePhysicianAssigned.getItemAt(exercisePAIndices.indexOf('Run / Walk')).chart[0].data[exerciseDataByMeasurePhysicianAssigned.getItemAt(exercisePAIndices.indexOf('Run / Walk')).chart[0].data.length - 1].miles));
	lblExDistanceDate.text = lblExDurationDate.text = lblExSpeedDate.text = lblExCaloriesDate.text = lblExHeartDate.text = lblExWeightDate.text = DateUtil.formatDateFromString(exerciseDataByMeasurePhysicianAssigned.getItemAt(exercisePAIndices.indexOf('Run / Walk')).chart[0].data[exerciseDataByMeasurePhysicianAssigned.getItemAt(exercisePAIndices.indexOf('Run / Walk')).chart[0].data.length - 1].date);
	myLineSeriesRunWalk.setStyle("itemRenderer",new ClassFactory(components.itemrenderers.MyCircleItemRendererIndividual));
}


private function recordExResults():void {
	var myRecordResults:recordResultsWindow = recordResultsWindow(PopUpManager.createPopUp(this, recordResultsWindow) as spark.components.TitleWindow);
	PopUpManager.centerPopUp(myRecordResults);
}

private function addPerExercise():void {
	var myAddPersonalExercise:addPersonalExercise = addPersonalExercise(PopUpManager.createPopUp(this, addPersonalExercise) as spark.components.TitleWindow);
	PopUpManager.centerPopUp(myAddPersonalExercise);
}

private function editRunGoal():void {
	var myRunEditGoal:runEditGoal = runEditGoal(PopUpManager.createPopUp(this, runEditGoal) as spark.components.TitleWindow);
	PopUpManager.centerPopUp(myRunEditGoal);
}

private function switchExercisePerView(index:uint):void {
	viewsExercisePER.selectedIndex = index;
	if(index == 1) {
		btnExPerChart.setStyle("chromeColor", 0xB3B3B3);
		btnExPerList.setStyle("chromeColor", 0xFF931E);
	}
	else {
		btnExPerChart.setStyle("chromeColor", 0xFF931E);
		btnExPerList.setStyle("chromeColor", 0xB3B3B3);
	}
	
	/*if(index == 0) highlightSelectedVital('All');
	else if(index == 2) highlightSelectedVital('Weight');
	else if(index == 3) highlightSelectedVital('Blood Pressure');*/
}

public function getGoalMinutes(points:uint):uint {
	if(points <= 52) return 15;
	else if(points <= 63) return 14;
	else if(points <= 68) return 13;
	else if(points <= 73) return 12;
	else if(points <= 82) return 11;
	else if(points <= 95) return 10;
	else return 9;
	//return points <= 58 ? 15 : 14;
}

public function getGoalSeconds(points:uint):String {
	var arrSeconds:Array = new Array(30,27,24,21,18,15,10,05,55,50,45,42,39,36,33,30,25,15,05,55,45,30,15,05,55,45,30,15,05,55,45,35,30,25,20,15,10,05,55,50,45,40,35,25,20,15,12,09,06,03,00,57,54,51,48,45);
	return arrSeconds[points-45] < 10 ? '0'+String(arrSeconds[points-45]) : String(arrSeconds[points-45]);
	//return ((70-points)*5)%60 < 10 ? '0'+((70-points)*5)%60 : String(((70-points)*5)%60);
}

public function getTimeFromGoal(min:uint,sec:uint):uint {
	var points:uint;
	if(min == 9) points = 100;
	else if(min == 10) points = 95;
	else if(min == 11) points = 82;
	else if(min == 12) points = 73;
	else if(min == 13) points = 68;
	else if(min == 14) points = 63;
	else points = 52;
	
	points -= (sec/5);	//approximation
	return points;
	
	/*var points:uint = (min == 14) ? 70 : 58;
	points -= (sec/5);
	return points;*/
}