SELECT 
 i.product_id,
 p.product_name,
 p.unit_cost,
 p.unit_price,
 s.avg_units_sold_per_day as average_units_sold_per_day,
 i.average_remaining_shelf_life,
 i.average_inventory_in_stock,
 i.average_supplier_lead_time_days,
 CAST(i.average_inventory_in_stock / s.avg_units_sold_per_day AS INT64) AS avg_days_in_stock,
  -- Advanced Metric 1: Place Order Every (X) Days
 CAST((i.average_inventory_in_stock / s.avg_units_sold_per_day) - i.average_supplier_lead_time_days - 1 AS INT64) AS place_order_every_x_days,
  -- Advanced Metric 2: Order Quantity
 CAST((((i.average_inventory_in_stock / s.avg_units_sold_per_day) - i.average_supplier_lead_time_days - 1) * s.avg_units_sold_per_day) + (i.average_supplier_lead_time_days * s.avg_units_sold_per_day) AS INT64) AS order_quantity,
 -- Financial Comparison 1: Current Capital Tied Up (Before)
 ROUND(i.average_inventory_in_stock * p.unit_cost, 2) AS current_inventory_value,
 -- Financial Comparison 2: Optimized Capital Required (After)
 ROUND(
   CAST((((i.average_inventory_in_stock / s.avg_units_sold_per_day) - i.average_supplier_lead_time_days - 1) * s.avg_units_sold_per_day) + (i.average_supplier_lead_time_days * s.avg_units_sold_per_day) AS INT64)
   * p.unit_cost, 2
 ) AS optimized_order_value
FROM `skilful-answer-498915-k5.pharx_data.avg_fact_inventory_logs` AS i
INNER JOIN `skilful-answer-498915-k5.pharx_data.avg_units_sold_per_day` AS s
 ON i.product_id = s.product_id
INNER JOIN `skilful-answer-498915-k5.pharx_data.cleaned_dim_products` AS p
 ON i.product_id = p.product_id;

