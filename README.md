# PHARx Logistics: Operational Audit

A data-led audit of 12 months of transactional inventory data from the Park Royal Depot, London. This project resolves a dual supply chain bottleneck: specialty medication expiration waste and daily stockout instability.

## Key Outcomes
* **£372,636 Saved:** Relieved capital drag from stagnant inventory, representing a 6% efficiency gain.
* **Zero Disruption:** Full optimisation achieved without impacting standard safety buffers.
* **Targeted Recovery:** Concentrated 99.3% of savings on slow-moving Oncology and Immunology lines.

## Repository Contents
* `master_query.sql` — SQL script compiling baseline averages and replenishment parameters.
* `PHARx - Inventory Audit Report.pdf` — Full technical documentation.
* `PHARx - Inventory Audit Presentation.pdf` — Executive presentation.
* `PHARx - Executive Brief.pdf` — High-level briefing document.

## Core Logic
The BigQuery replenishment engine automates two key operational parameters:

* **Dynamic Ordering Cycle (`place_order_every_x_days`)**
  ```sql
  CAST((average_inventory_in_stock / avg_units_sold_per_day) - average_supplier_lead_time_days - 1 AS INT64)
  ```

* **Responsive Restock Volume (`order_quantity`)**
  ```sql
  CAST((place_order_every_x_days * avg_units_sold_per_day) + (average_supplier_lead_time_days * avg_units_sold_per_day) AS INT64)
  ```
