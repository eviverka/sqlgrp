with balance_with_date as (
select 
    bal.user_id,
    bal.money,
    bal.currency_id,
    COALESCE (
        (SELECT MAX(cur.updated) from currency as cur WHERE cur.id = bal.currency_id AND cur.updated <= bal.updated),
        (SELECT MIN(cur.updated) from currency as cur WHERE cur.id = bal.currency_id AND cur.updated > bal.updated)
    ) as actual_date
FROM balance as bal
)

SELECT 
    COALESCE(u.name, 'not defined') as name,
    COALESCE(u.lastname, 'not defined') as lastname,
    cur.name as currency_name,
    bwd.money*cur.rate_to_usd as currency_in_usd
from balance_with_date as bwd 
join currency as cur on cur.id = bwd.currency_id AND cur.updated = bwd.actual_date
left join "user" as u on u.id = bwd.user_id
ORDER BY name desc, lastname ASC, currency_name ASC;