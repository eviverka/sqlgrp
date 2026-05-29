select 
    COALESCE(u.name, 'not defined') as name,
    COALESCE(u.lastname, 'not defined') as lastname,
    bal.type as type,
    SUM(bal.money) as volume,
    COALESCE(cur.name, 'not defined') as currency_name,
    COALESCE(cur.rate_to_usd, 1) as last_rate_to_usd,
    SUM(bal.money)*COALESCE(cur.rate_to_usd, 1) as total_volume_in_usd
from balance as bal
FULL JOIN "user" as u on u.id = bal.user_id
LEFT JOIN (
        SELECT id, name, rate_to_usd
        FROM (
        SELECT 
            id, 
            name, 
            rate_to_usd,
            ROW_NUMBER() OVER (PARTITION BY id ORDER BY updated DESC) as rn 
        FROM currency) as tmp
    WHERE rn = 1
) as cur on cur.id = bal.currency_id
GROUP BY u.name, u.lastname, bal.type, cur.name, cur.rate_to_usd
ORDER BY name DESC, lastname, type;