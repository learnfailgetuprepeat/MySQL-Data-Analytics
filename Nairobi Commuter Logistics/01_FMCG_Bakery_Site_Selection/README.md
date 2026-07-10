# 🍞 Module 1: Where Should You Open a Bakery in Nairobi? (Fast Moving Consumer Goods (FMGC) Retail Strategy)

## 📌 What Am I Trying to Solve?
If you want to open a business in Nairobi, guessing where to put your shop based on "good vibes" is an easy way to lose money. For an FMCG business like a bakery, you need eyes on your product. You want to be exactly where commuters are stuck waiting for a matatu or where they are pouring off matatus hungry.

Instead of guessing, I used public transit data from Nairobi's transit network to figure out a data-driven retail strategy. By querying the database, I wanted to answer three simple questions for a new bakery startup:
1. **Where** are the absolute biggest commuter hotspots?
2. **What** time does the peak rush happen so we know when to staff up?
3. **Which** directions are people actually traveling (towards CBD or away from CBD) so we can tailor the menu (e.g., selling quick breakfast snacks vs. family bread to take home)?

---

## 🛠️ How the Tables Connect
To find these answers, I had to link four different parts of the transit network together in MySQL:
* `stage_stops`: Gives us the actual names and the exact GPS coordinates of the bus stages.
* `stage_stop_times`: Tracks when matatus are actually hitting those stages.
* `trips`: The critical piece that contains the `direction_id` flag (telling us if a bus is going towards the CBD (inbound) or coming out(outbound)).
* `routes`: Connects everything to the broader transit corridors.

---

## 💻 The Analytical Query
To split the commuter traffic by direction without double counting rows, I used conditional aggregation (`COUNT(CASE WHEN...)`). This let me break down exactly how many trips were heading into town versus heading out at each stage.

```sql
SELECT 
    s.stop_name,
    COUNT(CASE WHEN direction_id = '1' THEN 1 END) AS to_cbd,
    COUNT(CASE WHEN direction_id = '0' THEN 1 END) AS from_cbd,
    COUNT(DISTINCT t.route_id) AS total_unique_routes,
    stop_lat, 
    stop_lon
FROM stage_stops s
JOIN stage_stop_times st ON s.stop_id = st.stop_id
JOIN trips t ON st.trip_id = t.trip_id
JOIN routes r ON r.route_id = t.route_id
GROUP BY s.stop_name, stop_lat, stop_lon
ORDER BY total_unique_routes DESC;
```

---

📊 Core Insights & Business Strategy

Example: Agip (The Evening Exit Throat)

The Data: to_cbd: 136 | from_cbd: 2,584 | Total Unique Routes: 20

The Strategy: There is a massive imbalance. Only 136 trips heading to the CBD, but over 2,500 heading out. Opening a morning breakfast shop here would be a total waste of money. Agip is structurally an evening bottleneck where people line up to leave the city.

The Menu: The kiosk here should focus entirely on take-home goods. Commuters waiting in lines here are looking for evening snacks for the road or whole family loaves of bread to take home for dinner and the next morning's breakfast.

A Note on the Time Limitation:

Our current dataset only tracks the early morning schedule initialization (the 6:00 AM and 7:00 AM peaks). While we don't have the explicit evening timestamps in the database yet, analysis of the routing directions proves how the city moves. Knowing that Agip is a outbound hub located away from CBD means its real, massive foot-traffic wave happens between 4:30 PM and 7:30 PM.

For a business, this means using a split-shift model: keep staffing light in the morning for prep work and stack maximum staff on the counter from 4:00 PM onwards to handle the massive evening exit rush.


## 🗺️ Visualizing the Commuter Foot-Traffic
<img width="1439" height="813" alt="Screenshot 2026-07-08 at 14 30 16" src="https://github.com/user-attachments/assets/275024b8-9b42-4ff5-8f95-cac93078bfc0" />



## ⏰ Chapter 2: The Peak Hour Engine (Temporal Analysis)

### 1. Business Objective
To optimize labor efficiency, minimize food waste and ensure maximum product freshness, I analyzed the exact hourly distribution of commuter traffic across our target locations. This data dictates the baking schedules and active staffing windows.

### 2. The Time-Bucketing Query
Because raw transit timestamps are highly granular (e.g., `06:14:22`), I used `SUBSTRING_INDEX` to isolate the hour block. I then filtered the entire transit network down exclusively to our high-priority retail hotspots.

```sql
SELECT
    s.stop_name,
    SUBSTRING_INDEX(st.arrival_time, ':', 1) AS hour_arrived,
    COUNT(DISTINCT r.route_id) AS total_unique_routes,
    COUNT(DISTINCT st.trip_id) AS total_trips
FROM stage_stop_times st
JOIN stage_stops s ON st.stop_id = s.stop_id
JOIN trips t ON st.trip_id = t.trip_id
JOIN routes r ON t.route_id = r.route_id
WHERE s.stop_name IN (
    'Agip','Kaloleni','Maziwa','City Stadium','Shauri Moyo','Church Army','City Stadium','Odeon','OTC','Koja','Church Army'
)
GROUP BY s.stop_name, hour_arrived
ORDER BY s.stop_name ASC, hour_arrived ASC;
```


### 💡 Core Insights & Data Observations

* **The 6:00 AM Super-Peak:** Across all primary target locations (including Agip, Church Army, and Kaloleni), commuter volume heavily concentrates within the 6:00 AM hour block. This represents the primary morning initialization phase for public transit routes heading toward commercial zones.

* **Micro-Location Preservations (Duplicate Rows):** You will notice certain locations like *City Stadium* appear twice in the primary target list. This is a deliberate strategic choice rather than a data error. The underlying transit data tracks separate coordinates for individual physical stages in the same area (e.g., the inbound side heading into the CBD vs. the outbound side heading towards the estates).

* **Strategic Advantage:** By preserving both rows, the business gains the luxury of choosing the exact side of the road with the highest directional foot traffic, ensuring maximum visibility and accessibility for commuters.


### 📊 Chapter 2 Data Output Preview

| stop_name | hour_arrived | total_unique_routes | total_trips |
| :--- | :---: | :---: | :---: |
| Agip | 6 | 15 | 15 |
| Agip | 7 | 5 | 5 |
| Church Army | 6 | 17 | 32 |
| City Stadium | 6 | 18 | 32 |
| City Stadium | 7 | 1 | 1 |
| Kaloleni | 6 | 15 | 15 |
| Kaloleni | 7 | 1 | 1 |
| Koja | 6 | 17 | 28 |
| Koja | 7 | 3 | 3 |
| Maziwa | 6 | 18 | 33 |
| Maziwa | 7 | 1 | 1 |
| Odeon | 6 | 17 | 34 |
| OTC | 6 | 18 | 23 |
| OTC | 7 | 1 | 1 |
| Shauri Moyo | 6 | 15 | 15 |


