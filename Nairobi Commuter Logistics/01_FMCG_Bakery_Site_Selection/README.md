# 🍞 Module 1: Where Should You Open a Bakery in Nairobi? (FMCG Retail Strategy)

## 📌 What Am I Trying to Solve?
If you want to open a business in Nairobi, guessing where to put your shop based on "good vibes" is an easy way to lose money. For an FMCG business like a bakery, you need eyes on your product. You want to be exactly where commuters are stuck waiting for a matatu or where they are pouring off buses hungry.

Instead of guessing, I used public transit data from Nairobi's transit network to figure out a data-driven retail strategy. By querying the database, I wanted to answer three simple questions for a new bakery startup:
1. **Where** are the absolute biggest commuter hotspots?
2. **What** time does the peak rush happen so we know when to staff up?
3. **Which** directions are people actually traveling (towards CBD or away from CBD) so we can tailor the menu (e.g., selling quick breakfast snacks vs. family bread to take home)?

---

## 🛠️ How the Tables Connect
To find these answers, I had to link four different parts of the transit network together in MySQL:
* `stage_stops`: Gives us the actual names and the exact GPS coordinates of the bus stages.
* `stage_stop_times`: Tracks when buses are actually hitting those stages.
* `trips`: The critical piece that contains the `direction_id` flag (telling us if a bus is going towards the CBD or coming out).
* `routes`: Connects everything to the broader transit corridors.

---

## 💻 The Analytical Query
To split the commuter traffic by direction without double-counting rows, I used conditional aggregation (`COUNT(CASE WHEN...)`). This let me break down exactly how many trips were heading into town versus heading out at each stage.

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
1. Agip (The Evening Exit Throat)
The Data: to_cbd: 136 | from_cbd: 2,584 | Total Unique Routes: 20

The Strategy: Look at that massive imbalance. Only 136 trips heading to the CBD, but over 2,500 heading out. Opening a morning breakfast shop here would be a total waste of money. Agip is structurally an evening bottleneck where people line up to leave the city.

The Menu: The kiosk here should focus entirely on take-home goods. Commuters waiting in lines here are looking for evening snacks for the road, or whole family loaves of bread and packs of shortbread to take home for dinner and the next morning's breakfast.

A Note on the Time Limitation:

Our current dataset only tracks the early morning schedule initialization (the 6:00 AM and 7:00 AM peaks). While we don't have the explicit evening timestamps in the database yet, our spatial analysis of the routing directions proves how the city moves. Knowing that Agip is a outbound hub located away from CBD means its real, massive foot-traffic wave happens between 4:30 PM and 7:30 PM.

For a business, this means using a split-shift model: keep staffing light in the morning for prep work and stack maximum staff on the counter from 4:00 PM onwards to handle the massive evening exit rush.

