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
