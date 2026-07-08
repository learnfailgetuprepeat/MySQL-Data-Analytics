# Nairobi Commuter Logistics Dashboard 
### Optimizing Commercial Operations via Public Commuter Flow

## Project Overview
This project analyzes urban mobility and transit efficiency across Nairobi's major commuter corridors. By evaluating semi-formal matatu transit data, this analysis identifies structural travel bottlenecks to provide private enterprises with actionable, data-driven operational strategies.

## Business Applications
* **FMCG (Fast-Moving Consumer Goods) & Retail:** Identifying high-density passenger interchanges for targeted retail placements and peak-hour staffing allocations.
* **Corporate Operations:** Optimizing shift hours and employee shuttle corridors to minimize hours lost to traffic delays.
* **Logistics & Delivery:** Quantifying a regional delay index to optimize vehicles dispach and delivery routes.

## Technical Architecture & Repository Pipeline
* **Data Layer:** Real-world semi-formal transit network records sourced from the open-source **Digital Matatus** database (GTFS format).
* **Engineering Layer:** MySQL Workbench to clean and aggregate raw data views.
* **Visualization Layer:** (Upcoming Phase) Interactive Dashboard mapping commuter velocities and density matrices.

## Repository Directory Structure
* `01-raw-data/` : Messy text/CSV files representing the baseline transit logs.
* `02-sql-scripts/` : Fully documented structural DDL schemas and cleaning queries.
* `03-dashboard-assets/` : Finished dashboard files, performance assets and screenshots.
