(* ::Package:: *)

(* ::Input:: *)
(*(*Start the package*)BeginPackage["MonteCarloUncertaintyPackage`"]*)
(**)
(*(*Declare the function and its usage*)*)
(*MonteCarloUncertaintyPropagation::usage="MonteCarloUncertaintyPropagation[f_, params_, OptionsPattern[]]    performs Monte Carlo uncertainty propagation for a given function f with parameters and uncertainties.    It returns a Gaussian fit to the results and a histogram plot.    Options: \"Iterations\" (default 100), \"BinSize\" (default 10), and \"OutputFileName\" (default \"HistogramFit.pdf\").";*)
(**)
(*(*Begin private context*)*)
(*Begin["`Private`"]*)
(**)
(*(*Define the Monte Carlo uncertainty propagation function*)*)
(*Options[MonteCarloUncertaintyPropagation]={"Iterations"->100,"BinSize"->10,"OutputFileName"->"HistogramFit.pdf"};*)
(**)
(*MonteCarloUncertaintyPropagation[f_,params_Association,OptionsPattern[]]:=Module[{paramNames,paramRanges,randomParams,results,fit,histogramPlot,iterations,binSize,outputFileName},(*Extract options*)iterations=OptionValue["Iterations"];*)
(*binSize=OptionValue["BinSize"];*)
(*outputFileName=OptionValue["OutputFileName"];*)
(*(*Extract parameter names and their uncertainty ranges*)paramNames=Keys[params];*)
(*paramRanges=Values[params];*)
(*(*Generate random values for each parameter based on their uncertainty ranges*)randomParams=Table[RandomReal[{param[[1]]-param[[2]],param[[1]]+param[[2]]},iterations],{param,paramRanges}];*)
(*(*Calculate the function for each set of random parameters*)results=Table[f@@(randomParams[[All,i]]),{i,iterations}];*)
(*(*Fit the results to a normal (Gaussian) distribution*)fit=FindDistributionParameters[results,NormalDistribution[\[Mu],\[Sigma]]];*)
(*(*Plot the histogram with a Gaussian fit overlay and apply publication-quality styling*)histogramPlot=Show[Histogram[results,binSize,"PDF",PlotLabel->Style["Gaussian Fit to Function Values",Bold,16],AxesLabel->{Style["Function Value",Bold,14],Style["Probability",Bold,14]},PlotTheme->"Scientific",ChartStyle->ColorData[97,2]],Plot[PDF[NormalDistribution[fit[[1,2]],fit[[2,2]]],x],{x,Min[results],Max[results]},PlotStyle->{Red,Thick}],Frame->True,FrameStyle->Directive[Black,14],LabelStyle->Directive[Black,14],ImageSize->Large];*)
(*(*Export the plot to a PDF file*)Export[outputFileName,histogramPlot,"PDF"];*)
(*(*Return the fitted parameters and the plot object*){fit,histogramPlot}]*)
(**)
(*(*End private context*)*)
(*End[]*)
(**)
(*(*End the package*)*)
(*EndPackage[]*)
(**)