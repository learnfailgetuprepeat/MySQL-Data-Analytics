# Nairobi Commuter Logistics: GTFS-Driven Site Selection for Fast Moving Consumer Goods (FMCG) Expansion

[![Tableau Public](https://img.shields.io/badge/Tableau-Interactive%20Dashboard-blue?logo=tableau)](https://public.tableau.com/shared/QFX4SGSXT?:display_count=n&:origin=viz_share_link)

## 1. Problem Statement & Business Context

For a Fast Moving Consumer Goods (FMCG) startup, such as a fresh bakery chain, opening a retail location based on intuition or cheap rent carries significant financial risk. Commercial success in high-density urban environments relies on **predictable, high-volume pedestrian foot traffic paired with high buying intent**.

In Nairobi, commuter movement is anchored by the matatus (public service vehicles) network:

* **The Morning Peak (6:00 AM – 8:00 AM):** Commuters assemble at stages within residential areas to wait for matatus heading to CBD. Passenger idle time is high at this time, creating a captive audience with peak buying intent for quick, grab-and-go breakfast items (coffee, mandazis, cakes etc).
* **The Evening Peak:** Passengers alight from vehicles returning to residential areas. Ths creates higher demand for family sized packaged goods such as bread.

### Core Objectives

This project analyzes Nairobi’s General Transit Feed Specification (GTFS) data to answer three critical questions for retail site selection:

1. **Where are the hotspots with the highest number of morning commuters?**
2. **Which exact physical side of the tarmac (with matatus heading towards or away from CBD) holds the highest waiting passenger volume?**
3. **What time windows experience the heaviest traffic surges to optimize shift staffing and prep schedules?**

---

## 2. Tech Stack & Data Architecture

* **Database Engine:** MySQL Server
* **Database Client:** DBeaver Community Edition
* **Visualization:** Tableau Public
* **Data Standard:** GTFS Relational Schema
* **Key Schema Relational Joins:**
  * `stops`: Contains platform stage names and geographic coordinates (`stop_lat`, `stop_lon`).
  * `stop_times`: Tracks scheduled vehicle arrival times (`arrival_time`).
  * `trips`: Connects routes to specific trips and holds the directional flag (`direction_id`).
  * `routes`: Links trip schedules to commercial transit corridors.

---

## 3. Analytical SQL Workflow & Iterations

### Step 1: Directional Query
Before running macro aggregations, I verified that `direction_id = '0'` accurately maps to matatus heading toward the Central Business District (CBD) by checking route headsigns across estate transit corridors.

```sql
SELECT DISTINCT 
    r.route_short_name,
    t.direction_id,
    t.trip_headsign
FROM trips t
JOIN routes r ON t.route_id = r.route_id
WHERE t.trip_headsign LIKE '%CBD%' 
   OR t.trip_headsign LIKE '%Odeon%' 
   OR t.trip_headsign LIKE '%Kencom%'
LIMIT 10;
```

---

### Step 2: Core Inbound Morning Density Aggregation
With directional logic confirmed, I queried the GTFS feed to count distinct vehicle arrivals per stage platform during the morning rush hour window (6:00 AM – 8:00 AM) for inbound routes.

```sql
SELECT 
    s.stop_name,
    COUNT(DISTINCT t.trip_id) AS peak_matatu_arrivals,
    t.direction_id,
    s.stop_lat,
    s.stop_lon
FROM stops s
JOIN stop_times st ON s.stop_id = st.stop_id
JOIN trips t ON st.trip_id = t.trip_id
WHERE HOUR(st.arrival_time) IN (6, 7)
  AND t.direction_id = '0'
GROUP BY s.stop_name, t.direction_id, s.stop_lat, s.stop_lon
ORDER BY peak_matatu_arrivals DESC;
```

---

### Step 3: Platform Boundary & Geographic Integrity Check
To prevent data distortion from invalid GPS coordinates or missing listings, I did a quick validation check on the aggregated dataset before exporting to Tableau.

```sql
SELECT 
    stop_name, 
    COUNT(*) AS row_count
FROM stops
WHERE stop_lat IS NOT NULL AND stop_lon IS NOT NULL
GROUP BY stop_name
HAVING row_count > 1;
```

---

### Analytical Insights & Engineering Pivots

#### Pivot A: Isolating Physical Platform Coordinates

* **The Finding:** Grouping strictly by `stop_name` merged opposing sides of the road into a single metric.
* **The Refinement:** Adding `s.stop_lat` and `s.stop_lon` to the `SELECT` and `GROUP BY` clauses separated opposing platforms across the street. This isolated the precise stage where commuters queue, ensuring a kiosk isn't accidentally placed on the exit/drop-off side of the road.

#### Pivot B: Directional Logic Verification

* **The Diagnostic:** Cross-referencing trip destinations (`trip_headsign`) for routes originating in residential estates confirmed that `direction_id = 0` represents inbound routes with trips ending at the CBD (*Odeon, Kencom, Koja*), validating `0` as the target filter for morning foot traffic.

---

## 🗺️ 4. Geospatial Visualization (Tableau)

To communicate my findings to business stakeholders, I mapped the aggregated SQL output using **Tableau Public**.

* **Interactive Map:** [View Live Tableau Dashboard](https://public.tableau.com/shared/QFX4SGSXT?:display_count=n&:origin=viz_share_link)

* **Key Visual Elements:**
  * **Proportional Mark Scaling:** Circle size scales dynamically with `peak_matatu_arrivals`, highlighting high density areas along **Jogoo Road** and **Outering Road feeders**.
  * **Density Filtering:** Low-volume stops (< 3 matatu arrivals) were filtered out to eliminate background noise and isolate primary commercial hubs.

---

## 📊 5. Findings & Strategic Recommendations

### Recommended Launch Locations (6:00 AM – 8:00 AM Peak)

| Rank | Stage Name | Morning Arrival Volume | Direction | Operational & Retail Alignment |
| :---: | :--- | :---: | :---: | :--- |
| **1** | **Church Army** | **13** | Inbound (`0`) | **Tier 1 Launch:** Heavy residential convergence; high passenger volume create ideal conditions for morning grab-and-go sales. |
| **2** | **Donholm Roundabout / Stage** | **12** | Inbound (`0`) | **Tier 1 Launch:** High volume feeder stage serving multiple estate feeder routes. |
| **3** | **Makadara / DC** | **12** | Inbound (`0`) | **Tier 1 Launch:** Key bottleneck along the eastern transit corridor. |
| **4** | **Total Jogoo Road** | **12** | Inbound (`0`) | **Tier 1 Launch:** High visual visibility along major pedestrian walkways. |
| **5** | **Hamza / Posta** | **11** | Inbound (`0`) | **Tier 1 Launch:** Sustained high pedestrian density throughout the 6:00 AM – 7:30 AM window. |

---

### ⏱️ Operational Staffing & Labor Strategy

Matching labor allocation to transit arrival curves minimizes operational costs while preventing queue drop-offs:

* **5:00 AM – 6:00 AM (Prep & Inventory Shift):** *2 Staff Members (Kitchen Prep / Stocking).* Focus on baking, packaging and kiosk setup prior to the transit surge.
* **6:00 AM – 8:30 AM (Peak Rush Shift):** *3–4 Staff Members (2 Cashiers, 1 Restocker).* Maximize transaction speed during the 6–7 AM arrival peak to capture commuter volume before boarding.
* **8:30 AM Onward (Off-Peak Transition):** *1 Staff Member (Maintenance & Low-Volume Service).* Scale down shift labor as inbound transit volume drops off post-8:30 AM.
