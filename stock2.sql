CREATE VIEW `stock2` AS
select 
  s2.ing_name,
  s2.ordered_weight,
  ing.ing_weight * inv.quantity as total_inv_weight,
  ((ing.ing_weight * inv.quantity) - s2.ordered_weight) / (ing.ing_weight * inv.quantity) as remaining_weight_percentage  
from (select
ing_id,
ing_name,
	sum(ordered_weight) as ordered_weight
from
	stock1
    group by ing_name) s2
left join inventory inv on inv.item_id = s2.ing_id
left join ingredient ing on ing.ing_id = s2.ing_id;

