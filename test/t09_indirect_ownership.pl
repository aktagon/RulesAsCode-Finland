% T09: CEO of ltd holding, holding owns 80% of target, person owns 60% of holding → entrepreneur (indirect, item 1)
limited_company(holding_oy).
limited_company(target_oy).
ceo(irina, holding_oy).
direct_share(irina, holding_oy, 60).
direct_share(holding_oy, target_oy, 80).
?- entrepreneur(irina).
