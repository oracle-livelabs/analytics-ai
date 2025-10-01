# Develop an Interactive Map of a Racetrack: Solar Car Race Across Australia

## Introduction

In August 2025, the University of Michigan Solar Car Team joined top student engineering teams from around the world in the Solar Car Race across Australia, covering more than 3,000 km from Darwin to Adelaide. Powered solely by the sun, the team navigated the vast Australian outback with precision and endurance, ultimately finishing 7th overall. Oracle supported their journey with Oracle Cloud Infrastructure, powering interactive maps that tracked real-time progress and delivered performance insights along this iconic route.

![a map of Australia showing the route of the Solar Car Race from Darwin to Port Augusta](./images/route-solarcar.png)

### About this Workshop

Oracle Analytics Cloud supports the configuration of numerous [map background](https://docs.oracle.com/en/cloud/paas/analytics-cloud/acubi/apply-map-backgrounds-and-map-layers-enhance-visualizations.html) types that can be used to visualize your data to tell a story in a way that no conventional map could. Enhancing the map with information such as historical race results, weather conditions, speed, turn and altitude variations and driver statistics makes for a more powerful interactive presentation.

In this hands-on lab you will learn how to create this interactive map. Let’s see how
simple it is to do.

![University of Michigan solar car racing along the Australian outback track under a clear sky, surrounded by sparse vegetation and open landscape, conveying a sense of determination and adventure](./images/racepic-solarcar.JPG =90%x90%)

_Estimated Time:_ 50 minutes

### Objectives

In this workshop, you will learn how to create a custom interactive map for the solar car race using real-world data. Specifically, you will:

- Download the csv files provided in resources section

- Load data into OAC as Datasets

- Build a map with multiple layers in OAC

By the end of this workshop, you will have built a fully layered and interactive map that visualizes the key components of a solar car race.

_At this point, you are ready to start learning! Please proceed._

_Resources:_

This lab includes three csv files. Please download and save them to a folder of your choice:

- [route](./files/route.csv?download=1)
- [speed](./files/speed.csv?download=1)
- [live location](./files/live%20location.csv?download=1)

_Note:_The route was first generated on OpenStreetMap, exported as GeoJSON, and then converted into a csv file containing Well-Known Text (WKT) geometry. This format provides a standardized way of representing geographic features such as points, lines, and polygons. For simplicity, we have also provided the csv, ready to use directly for this live lab.

## **Acknowledgements**

- **Author** - Anita Gupta (Oracle Analytics Product Strategy)
- **Contributors** - Gautam Pisharam (Oracle Analytics Product Management)
