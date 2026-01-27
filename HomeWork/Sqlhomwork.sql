--Question 3. For the trips in November 2025, how many trips had a trip_distance of less than or equal to 1 mile? (1 point) 
SELECT COUNT(1) AS trip_count
FROM green_taxi_trips
WHERE lpep_pickup_datetime >= '2025-11-01'
  AND lpep_pickup_datetime <  '2025-12-01'
  AND trip_distance <= 1;
--- answer is : 8007


#--------------------------------------------------------------

--Question 4. Which was the pick up day with the longest trip distance? Only consider trips with trip_distance less than 100 miles. (1 point) 
SELECT
    CAST(lpep_pickup_datetime AS DATE) AS pickup_day,
    MAX(trip_distance) AS max_trip_distance
FROM green_taxi_trips
WHERE trip_distance < 100
GROUP BY pickup_day
ORDER BY max_trip_distance DESC
LIMIT 1;

-- answer is : "2025-11-14"	88.03


#----------------------------------------------------------------
SELECT
    z."Zone" AS pickup_zone,
    SUM(g.total_amount) AS total_amount_sum
FROM green_taxi_trips g
JOIN taxi_zone_lookup z
  ON g."PULocationID" = z."LocationID"
WHERE DATE(g.lpep_pickup_datetime) = '2025-11-18'
GROUP BY pickup_zone
ORDER BY total_amount_sum DESC
LIMIT 1;

--answer is:  "East Harlem North"	9281.919999999991

#---------------------------------------------------------------------

--Question 6. For the passengers picked up in the zone named "East Harlem North" in November 2025, which was the drop off zone that had the largest tip? (1 point) 


SELECT
    dz."Zone" AS dropoff_zone,
    SUM(g.tip_amount) AS total_tip
FROM green_taxi_trips g
JOIN zones pz
  ON g."PULocationID" = pz."LocationID"
JOIN zones dz
  ON g."DOLocationID" = dz."LocationID"
WHERE pz."Zone" = 'East Harlem North'
  AND g.lpep_pickup_datetime >= '2025-11-01'
  AND g.lpep_pickup_datetime <  '2025-12-01'
GROUP BY dropoff_zone
ORDER BY total_tip DESC
LIMIT 1;

--"Upper East Side North"	4242.009999999995